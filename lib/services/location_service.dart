import 'dart:async';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import 'package:osw_test/datamodels/user_location.dart';

class LocationService {
  late UserLocation _currentLocation;

  Location location = Location();

  final StreamController<UserLocation> _locationControler =
      StreamController<UserLocation>.broadcast();

  LocationService() {
    location.requestPermission().then((granted) {
      if (granted == PermissionStatus.granted) {
        location.onLocationChanged.listen((locationData) {
          if (locationData.altitude != null && locationData.longitude != null) {
            _locationControler.add(UserLocation(
                latitude: locationData.latitude!,
                longitude: locationData.longitude!));
            print(locationData.toString());
          }
        });
      }
    });
  }

  Stream<UserLocation> get locationStream => _locationControler.stream;

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
          latitude: userLocation.latitude!, longitude: userLocation.longitude!);
    } catch (e) {
      if (kDebugMode) {
        print('Nie mogę ustalić lokalizacji GPS: $e');
      }
    }
    return _currentLocation;
  }
}
