import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/framework/colors.dart';
import '../../../core/framework/globals.dart';

class PermissionsDialog extends StatelessWidget {
  const PermissionsDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Container(
        height: ScreenWH(context).height *0.65,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/imgs/PersonaChateando.png'),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Para interactuar con los objetos en realidad aumentada necesitas habilitar los permisos de cámara y localización.',
              textAlign: TextAlign.center,
              style: GoogleFonts.sourceSansPro(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: txtPrimary,
              ),
            ),
          ),
          const SizedBox(height: 15,),
          ElevatedButton(
            onPressed: () async {
              bool pass = await getPermissions();
              if(pass){
                Navigator.pushNamed(context, "/arView");
                }
              },
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(greenPrimary),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0))),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 50)),
            ),
            child: Text(
              'Dar Permisos',
              textAlign: TextAlign.center,
              style: GoogleFonts.sourceSansPro(
                color: const Color.fromRGBO(255, 255, 255, 1.0),
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
    ),
      ),
    );
  }
}
