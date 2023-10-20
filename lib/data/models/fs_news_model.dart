import 'package:cloud_firestore/cloud_firestore.dart';

class FsNewsModel {
  String
      id; // Identificador único del documento (Firestore asigna automáticamente)
  String content;
  String img;
  int order;
  bool pinned;
  String title;

  // Constructor
  FsNewsModel({
    this.id,
    this.content,
    this.img,
    this.order,
    this.pinned,
    this.title,
  });

  // Método para crear una instancia del modelo de datos a partir de un DocumentSnapshot
  factory FsNewsModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data();
    return FsNewsModel(
      id: snapshot.id,
      content: data['Content'] ?? '',
      img: data['Img'] ?? '',
      order: data['Order'] ?? 0,
      pinned: data['Pinned'] ?? false,
      title: data['Title'] ?? '',
    );
  }

  // Método para convertir el modelo de datos a un mapa (para guardar en Firestore)
  Map<String, dynamic> toMap() {
    return {
      'Content': content,
      'Img': img,
      'Order': order,
      'Pinned': pinned,
      'Title': title,
    };
  }
}
