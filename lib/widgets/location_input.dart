import 'dart:convert';

import 'package:favorite_places/keys/location_key.dart';
import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectLocation});

  final void Function(PlaceLocation location) onSelectLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedlocation;
  var _isGettingLocation = false;

  String get locationPreviewImage {
    if (_pickedlocation == null) {
      return '';
    }
    final lat = _pickedlocation!.latitude;
    final long = _pickedlocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$long&key=$locationKey';
  }

  Future _savedPlace(double latitude, double longitude) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$locationKey',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to fetch address. Status Code: ${response.statusCode}',
      );
    }

    final data = json.decode(response.body);

    if (data['results'] == null || (data['results'] as List).isEmpty) {
      throw Exception('No address found for the given coordinates.');
    }

    final address = data['results'][0]['formatted_address'];

    setState(() {
      _pickedlocation = PlaceLocation(
        latitude: latitude,
        longitude: longitude,
        address: address,
      );
      _isGettingLocation = false;
    });

    widget.onSelectLocation(_pickedlocation!);
  }

  void _getCurrentlocation() async {
    Location location = Location();

    setState(() {
      _isGettingLocation = true;
    });

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // User did not enable the location service. Stop.
        setState(() {
          _isGettingLocation = false;
        });
        return;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        // User did not grant location permission. Stop.
        setState(() {
          _isGettingLocation = false;
        });
        return;
      }
    }

    try {
      final locationData = await location.getLocation();
      final lat = locationData.latitude;
      final long = locationData.longitude;

      if (lat == null || long == null) {
        throw Exception('Could not get latitude or longitude.');
      }

      _savedPlace(lat, long);
    } catch (error) {
      print('An error occurred during location fetching: $error');
      setState(() {
        _isGettingLocation = false;
      });
    }
  }

  void _selectOnMap() async {
    final initialLocation = _pickedlocation;

    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(
          location:
              initialLocation ??
              const PlaceLocation(
                latitude: 37.422,
                longitude: -122.084,
                address: '',
              ),
          isSelecting: true,
        ),
      ),
    );
    // To remove autofocus on title textfeld after user comme back from MapScreen.
    if (!mounted) {
      return;
    }
    FocusScope.of(context).unfocus();

    if (pickedLocation == null) {
      return;
    }
    _savedPlace(pickedLocation.latitude, pickedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location choosen',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );

    if (_pickedlocation != null) {
      previewContent = Image.network(
        locationPreviewImage,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      );
    }

    if (_isGettingLocation == true) {
      previewContent = CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          height: 169,
          width: double.infinity,
          alignment: Alignment.center,
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Get current location'),
              onPressed: _getCurrentlocation,
            ),
            TextButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}
