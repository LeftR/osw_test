import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:osw_test/datamodels/user_location.dart';
import 'package:osw_test/services/location_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
        create: (context) => LocationService().locationStream,
        initialData: UserLocation(latitude: 52, longitude: 20),
        child: MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Test1',
                  style: TextStyle(fontSize: 22),
                ),
              ),
              body: Builder(builder: (context) {
                return MyMapView();
              })),
        ));
  }
}

class MyMapView extends StatelessWidget {
  const MyMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return MyMap(context);
  }
}

// show current position on map, as StatefullWidget
Widget MyMap(context) {
  var userLocation = Provider.of<UserLocation>(context);
  return FlutterMap(
      options: MapOptions(
        //initialCenter: LatLng(userLocation.latitude, userLocation.longitude),
        initialCenter: LatLng(userLocation.latitude, userLocation.longitude),
        initialZoom: 10,
        interactionOptions:
            const InteractionOptions(flags: ~InteractiveFlag.doubleTapZoom),
      ),
      //mapController: _mapControler,
      children: [
        openStreetMapTileLayer,
        MarkerLayer(markers: [
          Marker(
              point: LatLng(userLocation.latitude, userLocation.longitude),
              width: 60,
              height: 60,
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.location_pin,
                size: 60,
                color: Colors.yellow,
              ))
        ])
      ]);
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );
