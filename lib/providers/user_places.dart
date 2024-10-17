
import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:riverpod/riverpod.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>>{
  UserPlacesNotifier() : super([]);

  void addPlace(String title,File image,PlaceLocation location){
    final newPlace = Place(title: title,image: image, location:location );
    state = [newPlace,...state];

  }
}

final userPlacesProvider = StateNotifierProvider<UserPlacesNotifier,List<Place>>(
  (ref) => UserPlacesNotifier(),
  );