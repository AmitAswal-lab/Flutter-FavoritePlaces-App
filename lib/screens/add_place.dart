import 'package:favorite_places/providers/user_places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class AddPlaceScreem extends ConsumerStatefulWidget {
  const AddPlaceScreem({super.key});

  @override
  ConsumerState<AddPlaceScreem> createState() => _AddPlaceScreemState();
}

class _AddPlaceScreemState extends ConsumerState<AddPlaceScreem> {
  final _titleController = TextEditingController();

  void _savePlace(){
    final enteredTexted = _titleController.text;

    if(enteredTexted.isEmpty){
      return;
    }
    ref.read(userPlacesProvider.notifier).addPlace(enteredTexted);

    Navigator.of(context).pop();

  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add new place')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(label: Text('Title')),
              controller: _titleController,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: Icon(Icons.add),
              label: Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}
