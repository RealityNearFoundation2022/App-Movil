import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/bloc/user/user_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../core/framework/globals.dart';
import '../../../core/helper/url_constants.dart';

class UpdateDialog extends StatefulWidget {
  UpdateDialog({Key key, this.url}) : super(key: key);
  String url;
  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                    children: [
                      Text(
                        S.current.NuevaActualizacion,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sourceSansPro(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: greenPrimary),
                      ),
                      Image.asset(
                        "assets/imgs/Logo_sin_fondo.png",
                        width: ScreenWH(context).width * 0.4,
                        height: ScreenWH(context).height * 0.15,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        width: MediaQuery.of(context).size.width * 0.57,
                        child: Text( S.current.ActualizacionDesc,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sourceSansPro(
                            fontSize: 16,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width * 0.64,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            button(S.current.luego, () {
                              Navigator.of(context).pop();
                            }, Colors.grey),
                            button(
                                S.current.Actualizar,
                                    () {
                                  launchUrlString(
                                      widget.url,
                                      mode: LaunchMode.externalApplication);
                                },
                                greenPrimary),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ));
  }

  Widget button(String text, Function press, Color color) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        primary: Colors.white,
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 30),
      ),
      child: Text(
        text,
        style: GoogleFonts.notoSansJavanese(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      onPressed: () async {
        press();
      },
    );
  }
}
