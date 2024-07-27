import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:osw_test/location/location_error_message.dart';

class LocationHelper {
  Future<bool> _serviceEnabled() async {
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      return await location.requestService();
    } else {
      return true;
    }
  }

  Future<bool> _hasPermission() async {
    Location location = Location();
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus != PermissionStatus.granted &&
        permissionStatus != PermissionStatus.grantedLimited) {
      permissionStatus = await location.requestPermission();
      return (permissionStatus == PermissionStatus.granted ||
          permissionStatus == PermissionStatus.grantedLimited);
    } else {
      return true;
    }
  }

  Future<bool> enableAndGrantPermissionToLocation(
      BuildContext context, Function errorCallback) async {
    bool hasPermission = false;
    bool serviceEnabled = await this._serviceEnabled();
    if (!serviceEnabled) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorMessage(
              text: 'Please enable location services on your device',
              callback: () {
                errorCallback.call();
              },
              buttonText: 'Done',
            );
          });
    } else {
      hasPermission = await this._hasPermission();
      if (!hasPermission) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return ErrorMessage(
                  text:
                      'Please grant permission to access to your current location',
                  callback: () {
                    errorCallback.call();
                  });
            });
      }
    }
    return serviceEnabled && hasPermission;
  }

  Future<LocationData> getCurrentLocation(BuildContext context) async {
    return await Location().getLocation();
  }
}
