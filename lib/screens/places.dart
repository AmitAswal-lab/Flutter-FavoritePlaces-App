import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() {
  return _PlaceScreenState();
  }
}

class _PlaceScreenState extends ConsumerState<PlacesScreen>{ 

  late Future<void> _placesFuture;
  @override
  void initState() {
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext contextf) {
    final userPlaces = ref.watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text('your places'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (ctx) => AddPlaceScreem()));
              },
              icon: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: 
         Padding(
           padding: const EdgeInsets.only(top: 12),
           child: FutureBuilder(
            future: _placesFuture, 
            builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting ? 
            Center(child: CircularProgressIndicator())  : 
            PlacesList(places: userPlaces),),
            
         ),
    );
  }
}
