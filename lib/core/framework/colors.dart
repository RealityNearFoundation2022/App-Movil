import 'package:flutter/material.dart';

//User Interface and Theming
const txtPrimary = Color.fromRGBO(85, 85, 85, 1);
const offSwitch = Color.fromRGBO(102, 102, 102, 1);
const icongrey = Color.fromRGBO(112, 112, 112, 1);
const greenPrimary = Color.fromRGBO(51, 204, 153, 1);
const greenPrimary2 = Color.fromRGBO(70, 183, 142, 1);
const greenPrimary3 = Color.fromRGBO(51, 204, 153, 1);
const greySoft = Color.fromRGBO(223, 222, 211, 1);

const backgroundWhite = Colors.white;

class Palette {
  static const MaterialColor kgreenNR = MaterialColor(
    0xFF46B78E, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color.fromRGBO(70, 183, 142, 0.1), //10%
      100: Color.fromRGBO(70, 183, 142, 0.2), //20%
      200: Color.fromRGBO(70, 183, 142, 0.3), //30%
      300: Color.fromRGBO(70, 183, 142, 0.4), //40%
      400: Color.fromRGBO(70, 183, 142, 0.5), //50%
      500: Color.fromRGBO(70, 183, 142, 0.6), //60%
      600: Color.fromRGBO(70, 183, 142, 0.7), //70%
      700: Color.fromRGBO(70, 183, 142, 0.8), //80%
      800: Color.fromRGBO(70, 183, 142, 0.9), //90%
      900: Color.fromRGBO(70, 183, 142, 1), //100%
    },
  );
}
