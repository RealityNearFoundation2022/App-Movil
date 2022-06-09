import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:ui' as ui;

import 'package:reality_near/presentation/views/mapScreen/widgets/placeDialog.dart';

class LocationProvider with ChangeNotifier {
  BitmapDescriptor _pinLocationIcon;
  BitmapDescriptor _pinPlaceIcon;
  Map<MarkerId, Marker> _markers;
  Map<MarkerId, Marker> get markers => _markers;
  final MarkerId markerLocationId = const MarkerId("location");
  final MarkerId markerPlaceId = const MarkerId("place");

  GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;

  Location _location;
  Location get location => _location;
  BitmapDescriptor get pinLocationIcon => _pinLocationIcon;
  BitmapDescriptor get pinPlaceIcon => _pinPlaceIcon;

  LatLng _locationPosition;
  LatLng get locationPosition => _locationPosition;

  BuildContext ctx;
  BuildContext get context => ctx;

  bool locationServiceActive = true;

  LocationProvider() {
    _location = Location();
    _markers = <MarkerId, Marker>{};
  }

  initialization() async {
    await getUserLocation();
    await setCustomMapPin();
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

        _markers.clear();

        Marker marker = Marker(
            flat: true,
            markerId: markerLocationId,
            position: LatLng(
              _locationPosition.latitude,
              _locationPosition.longitude,
            ),
            icon: pinLocationIcon);
        Marker marker2 = Marker(
            markerId: markerPlaceId,
            position: const LatLng(-12.13188463912557, -77.03051894903845),
            icon: pinPlaceIcon,
            onTap: () {
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return const PlaceDialog();
                },
              );
            });

        _markers[markerLocationId] = marker;
        _markers[markerPlaceId] = marker2;

        notifyListeners();
      },
    );
  }

  setMapController(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  setCameraToCurrentPosition() {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _locationPosition,
          zoom: 18,
        ),
      ),
    );
  }

  setCustomMapPin() async {
    _pinLocationIcon = BitmapDescriptor.fromBytes(
        await getBytesFromAsset('assets/imgs/person_map.png', 120));
    _pinPlaceIcon = BitmapDescriptor.fromBytes(
        await getBytesFromAsset('assets/imgs/place_map.png', 140));
  }

  takeSnapshot() {
    return _mapController.takeSnapshot();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }
}
