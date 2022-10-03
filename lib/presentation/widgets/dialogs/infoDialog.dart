import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';

class InfoDialog extends StatelessWidget {
  final String title, message;
  final Function onPressed;
  Widget icon;
  InfoDialog({Key key, this.title, this.message, this.icon, this.onPressed})
      : super(key: key);

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
                icon ?? Container(),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: GoogleFonts.sourceSansPro(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: txtPrimary),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    message,
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: txtPrimary),
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    onPressed();
                  },
                  child: Text(
                    'Continuar',
                    style: GoogleFonts.sourceSansPro(
                        color: greenPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
