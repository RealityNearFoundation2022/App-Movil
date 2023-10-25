import 'package:flutter/material.dart';

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);

    // Agrega los triángulos
    final triangleWidth = size.width / 15;
    final triangleHeight = size.height / 20;
    var x = 0.0;
    while (x < size.width) {
      path.lineTo(x, size.height);
      path.lineTo(x + triangleWidth / 2, size.height - triangleHeight);
      path.lineTo(x + triangleWidth, size.height);
      x += triangleWidth;
    }

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
