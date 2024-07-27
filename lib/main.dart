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
    return StreamProvider<UserLocation>.value(
      initialData: UserLocation(latitude: 0, longitude: 0),
      value: LocationService().locationStream,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Test1',
              style: TextStyle(fontSize: 22),
            ),
          ),
          body: Builder(builder: (context) {
            return mapa(context);
          }),
        ),
      ),
    );
  }

// print current position
  Widget position(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return Text('${userLocation.latitude}, ${userLocation.longitude}');
  }

// show current position on map
  Widget mapa(BuildContext context) {
    UserLocation userLocation = moveMap(context);
    return FlutterMap(
        options: MapOptions(
          //initialCenter: LatLng(userLocation.latitude, userLocation.longitude),
          initialCenter: LatLng(52.33, 20.48),
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
                  color: Colors.red,
                ))
          ])
        ]);
  }

  UserLocation moveMap(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    late MapController _mapControler = MapController();
    var latlng = LatLng(userLocation.latitude, userLocation.longitude);
    double zoom = 10;
    //_mapControler.move(latlng, zoom);
    return userLocation;
  }

  TileLayer get openStreetMapTileLayer => TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
      );
}
