import 'package:favorite_places/Screens/add_palace.dart';
import 'package:favorite_places/main.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget{
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final userPlaces = ref.watch(userPlacesProvider);
  return Scaffold(

  appBar: AppBar(
    title: const Text('Your Places',style: TextStyle(fontSize: 20)),
     actions: [
      IconButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> AddPalaceScreen()));
        },
         icon: Icon(Icons.add),
         ),
    ],
    backgroundColor: colorScheme.onPrimary,
  ),
  body: Padding(
    padding: EdgeInsets.all(8),
    child: PlacesList(places:userPlaces,
    ),
  ),
   );
  }
}