import 'dart:io';
import 'package:favorite_places/main.dart';
import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPalaceScreen extends ConsumerStatefulWidget{
  const AddPalaceScreen({super.key});

  @override
  ConsumerState<AddPalaceScreen> createState() => _AddPalaceScreenState();
}

class _AddPalaceScreenState extends ConsumerState<AddPalaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void _savePlace(){
    final enteredTitle = _titleController.text;
    if(enteredTitle.isEmpty || _selectedImage == null || _selectedLocation==null){
      return;
    }
      ref
      .read(userPlacesProvider.notifier)
      .addPlace(
        enteredTitle,
        _selectedImage!,
      _selectedLocation!,
      );
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
      appBar: AppBar(
    actions: [
      IconButton(onPressed: (){}, icon: Icon(Icons.add)),
    ],
    title: const Text('Your Places',style: TextStyle(fontSize: 20),),
    backgroundColor: colorScheme.onPrimary,
  ),
  body: SingleChildScrollView(
    padding: EdgeInsets.all(12),
    child: Column(
      children: [
        TextFormField(
          decoration: InputDecoration(label: Text('title')),
          controller: _titleController,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
    SizedBox(height: 16),
      // image input  
      ImageInput(onPickImage: (image) { 
        _selectedImage = image;
      },
    ),
        SizedBox(height: 16),

      LocationInput(onSelectLocation: (location ) { 
        _selectedLocation = location;
      },),

      SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: _savePlace,
          icon: Icon(Icons.add),
          label:  const Text('Add Items'),
          ),
      ],
    ),
  ),
    );
  }
}