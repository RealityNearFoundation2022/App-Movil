import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/generated/l10n.dart';

class PermisosDialog extends StatefulWidget {
  const PermisosDialog({Key key}) : super(key: key);

  @override
  State<PermisosDialog> createState() => _PermisosDialogState();
}

class _PermisosDialogState extends State<PermisosDialog> {
  List<bool> statusPermisos = [
    false,
    false,
    false,
  ];

  checkCameraPermisionStatus() {
    Permission.camera.status.then((value) {
      setState(() {
        statusPermisos[1] = value.isGranted;
      });
    });
  }

  getCameraPermision() {
    Permission.camera.request().then((value) {
      setState(() {
        statusPermisos[1] = value.isGranted;
      });
    });
  }

  checkLocationPermisionStatus() {
    Permission.location.status.then((value) {
      setState(() {
        statusPermisos[2] = true;
      });
    });
  }

  getLocationPermision() {
    Permission.location.request().then((value) {
      setState(() {
        statusPermisos[2] = value.isGranted;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkCameraPermisionStatus();
    checkLocationPermisionStatus();
  }

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
                    fontSize: 24,
                    color: Colors.black54),
              ),
              const SizedBox(height: 5),
              permision(S.current.MostrarAvatarMapa, 0),
              permision(S.current.Camara, 1),
              permision(S.current.Ubicacion, 2),
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
          CupertinoSwitch(
            activeColor: greenPrimary,
            value: statusPermisos[index],
            onChanged: (value) {
              //show info dialog
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      title: Text(text,
                          style: GoogleFonts.sourceSansPro(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: txtPrimary)),
                      content: Text(
                        S.current.ChangePermission,
                        style: GoogleFonts.sourceSansPro(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black38),
                      ),
                      actions: [
                        Center(
                          child: TextButton(
                              onPressed: () {
                                openAppSettings();
                              },
                              child: Text(S.current.irConfig,
                                  style: GoogleFonts.sourceSansPro(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: greenPrimary))),
                        )
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
