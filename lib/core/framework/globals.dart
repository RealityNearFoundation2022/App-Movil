import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:location/location.dart' as loc;

class ScreenWH {
  BuildContext context;

  ScreenWH(this.context);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}

String loremIpsum =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

String getRandomName() {
  List<String> names = [
    "Juan",
    "Maria",
    "Jose",
    "Luis",
    "Pedro",
    "Jorge",
    "Miriam",
    "Ana",
    "Sofia",
    "Sara",
    "Carolina",
    "Daniel"
  ];
  List<String> apellidos = [
    "Perez",
    "Garcia",
    "Lopez",
    "Gonzalez",
    "Martinez",
    "Rodriguez",
    "Hernandez",
    "Gomez",
    "Sanchez",
    "Perez",
    "Garcia"
  ];
  return names[Random().nextInt(names.length)] +
      " " +
      apellidos[Random().nextInt(apellidos.length)];
}

setPreference(String key, dynamic value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  switch (value.runtimeType) {
    case String:
      await prefs.setString(key, value);
      break;
    case int:
      await prefs.setInt(key, value);
      break;
    case double:
      await prefs.setDouble(key, value);
      break;
    case bool:
      await prefs.setBool(key, value);
      break;
    case List:
      await prefs.setStringList(key, value);
      break;
  }
}

getPreference(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.get(key);
}

deletesetPreference(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

deleteAllsetPreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

//Convert a string to base64
String convertToBase64(String val) {
  return base64.encode(utf8.encode(val));
}

//Convert dateTime To String
String convertDateTimeToString(DateTime dateTime) {
  return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
}

getPermissions() async {
  // You can request multiple permissions at once.
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.camera,
    Permission.storage
  ].request();

  return (statuses[Permission.location].isGranted &&
          statuses[Permission.camera].isGranted &&
          statuses[Permission.storage].isGranted)
      ? true
      : false;
}

double calculateDistanceMts(LatLng pos1, LatLng pos2) {
  int radiusEarth = 6371;
  double distanceKm;
  double distanceMts;
  double dlat, dlng;
  double a;
  double c;

  double lat1 = pos1.latitude;
  double lat2 = pos2.latitude;
  double lng1 = pos1.longitude;
  double lng2 = pos2.longitude;

  //Convertimos de grados a radianes
  lat1 = math.radians(lat1);
  lat2 = math.radians(lat2);
  lng1 = math.radians(lng1);
  lng2 = math.radians(lng2);
  // Fórmula del semiverseno
  dlat = lat2 - lat1;
  dlng = lng2 - lng1;
  a = sin(dlat / 2) * sin(dlat / 2) +
      cos(lat1) * cos(lat2) * (sin(dlng / 2)) * (sin(dlng / 2));
  c = 2 * atan2(sqrt(a), sqrt(1 - a));

  distanceKm = radiusEarth * c;
  distanceMts = 1000 * distanceKm;
  print('Distancia en Metros:$distanceMts');

  // return distanceKm;
  return distanceMts;
}

//Obtener hora y minuto actual
String getTimeHyM() {
  DateTime now = DateTime.now();
  return "${now.hour}:${now.minute}";
}

//obten posicion del usuario
Future<loc.LocationData> getCurrentLocation() async {
  return await loc.Location().getLocation();
}

double getResponsiveText(BuildContext context, double size) =>
    size * 900 / MediaQuery.of(context).size.longestSide;
