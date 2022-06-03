import 'dart:math';

import 'package:flutter/material.dart';

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
