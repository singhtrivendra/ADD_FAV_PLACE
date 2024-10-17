import 'dart:convert';

import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget{
  const LocationInput({
    super.key, 
    required this.onSelectLocation,
    });

  final void Function(PlaceLocation) onSelectLocation;

  @override
  State<StatefulWidget> createState() {
      return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput>{
  PlaceLocation? _pickedLoction;
  var _isGettingLoction = false; 
  String get locationImage{
    if(_pickedLoction == null){
      return '';
    }
    final lat = _pickedLoction!.latitude;
    final lng = _pickedLoction!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng=&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyCQ8jX30fl6XLGo-tktojQcPTV1SbAWfSM';
  }

  void _getCurrentLoaction() async{
    setState(() {
          _isGettingLoction = true;
    });

    Location location =  Location();

bool serviceEnabled;
PermissionStatus permissionGranted;
LocationData locationData;

serviceEnabled = await location.serviceEnabled();
if (!serviceEnabled) {
  serviceEnabled = await location.requestService();
  if (!serviceEnabled) {
    return;
  }
}

permissionGranted = await location.hasPermission();
if (permissionGranted == PermissionStatus.denied) {
  permissionGranted = await location.requestPermission();
  if (permissionGranted != PermissionStatus.granted) {
    return;
  }
}

locationData = await location.getLocation();
final lat = locationData.latitude;
final lng = locationData.longitude;

if (lat== null || lng == null){
  return;
}

final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyCQ8jX30fl6XLGo-tktojQcPTV1SbAWfSM');
final response = await http.get(url);
final resData = json.decode(response.body);
final address = resData['results'][0]['formatted_address'];
setState(() {
  _pickedLoction = PlaceLocation(
    latitude: lat, 
    longitude: lng, 
    address: address
    );
      _isGettingLoction = false;
});

widget.onSelectLocation(_pickedLoction!);

  }
  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text('No location chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
      ),
      );

if(_pickedLoction != null){
  previewContent = Image.network(
    locationImage,
    fit: BoxFit.cover,
    width: double.infinity,
    height: double.infinity,
    );
}
      if(_isGettingLoction){
        previewContent = CircularProgressIndicator();
      }
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
      ),
      child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Get current Loaction'),
                  onPressed: _getCurrentLoaction ,
              ),
                TextButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
                  onPressed: (){},
              )
          ],
        ),
      ],
    );
  }
} 