import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';
import 'package:reality_near/core/framework/globals.dart';

class FsGaPlaceModel {
  String
      name; // nameentificador único del documento (Firestore asigna automáticamente)
  int radio;
  LatLng location;

  // Constructor
  FsGaPlaceModel({this.name, this.radio, this.location});

  // Método para crear una instancia del modelo de datos a partir de un DocumentSnapshot
  factory FsGaPlaceModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data();
    return FsGaPlaceModel(
      name: snapshot.id,
      radio: data['radio'] ?? '',
      // GeoPoint -> LatLng
      location: LatLng(data['location'].latitude, data['location'].longitude),
    );
  }

  // Método para convertir el modelo de datos a un mapa (para guardar en Firestore)
  Map<String, dynamic> toMap() {
    return {
      'radio': radio,
      'location': location,
    };
  }

  bool isInside(LatLng userLocation) {
    return calculateDistanceMts(userLocation, location) <= radio;
  }
}
