import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  MapController _mapController;
  MapController get mapController => _mapController;

  Location _location;
  Location get location => _location;

  LatLng _locationPosition;
  LatLng get locationPosition => _locationPosition;

  BuildContext ctx;
  BuildContext get context => ctx;

  bool locationServiceActive = true;

  LocationProvider() {
    _location = Location();
    // _markers = <MarkerId, Marker>{};
  }

  initialization() async {
    await getUserLocation();
  }

  getUserLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    location.onLocationChanged.listen(
      (LocationData currentLocation) {
        _locationPosition = LatLng(
          currentLocation.latitude,
          currentLocation.longitude,
        );

        print(_locationPosition);

        notifyListeners();
      },
    );
  }

  setMapController(MapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  setCameraToCurrentPosition() {
    _mapController.move(
        LatLng(_locationPosition.latitude, _locationPosition.longitude), 17);
    notifyListeners();
  }
}
