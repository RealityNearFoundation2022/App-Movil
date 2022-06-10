import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/generated/l10n.dart';

class PermisosDialog extends StatefulWidget {
  const PermisosDialog({Key key}) : super(key: key);

  @override
  State<PermisosDialog> createState() => _PermisosDialogState();
}

class _PermisosDialogState extends State<PermisosDialog> {
  List<bool> statusPermisos = [
    true,
    true,
    false,
    true,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.current.Permisos,
                style: GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.black54),
              ),
              const SizedBox(height: 15),
              permision(S.current.MostrarAvatarMapa, 0),
              permision(S.current.Camara, 1),
              permision(S.current.Microfono, 2),
              permision(S.current.Ubicacion, 3),
              permision(S.current.Notificaciones, 4)
            ],
          ),
        ),
      ),
    );
  }

  Widget permision(String text, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              text,
              style: GoogleFonts.sourceSansPro(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.black38),
            ),
          ),
          FlutterSwitch(
            width: 45.0,
            height: 25.0,
            valueFontSize: 16.0,
            toggleSize: 20.0,
            value: statusPermisos[index],
            borderRadius: 30.0,
            activeColor: Palette.kgreenNR,
            onToggle: (val) {
              setState(() {
                statusPermisos[index] = val;
              });
            },
          ),
        ],
      ),
    );
  }
}
