import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/generated/l10n.dart';

class ConfirmUserDialog extends StatefulWidget {
  const ConfirmUserDialog({Key key, this.username, this.avatar, this.pressFunc})
      : super(key: key);
  final String username, avatar;
  final Function pressFunc;

  @override
  State<ConfirmUserDialog> createState() => _ConfirmUserDialogState();
}

class _ConfirmUserDialogState extends State<ConfirmUserDialog> {
  bool _loading = false;

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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    S.current.EsteSeraTuAvatar,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: txtPrimary),
                  ),
                ),
                Image.asset(widget.avatar,
                    height: ScreenWH(context).height * 0.23,
                    width: ScreenWH(context).width * 0.24),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    widget.username,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: txtPrimary),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      button(S.current.Confirmar, () {
                        widget.pressFunc();
                      }, greenPrimary),
                      const SizedBox(
                        width: 10,
                      ),
                      button(S.current.Volver, () {
                        Navigator.of(context).pop();
                      }, Colors.grey),
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
      ),
      child: (_loading && greenPrimary == color)
          ? SizedBox(
              width: ScreenWH(context).width * 0.04,
              height: ScreenWH(context).width * 0.04,
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ))
          : Text(
              text,
              style: GoogleFonts.notoSansJavanese(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
      onPressed: () async {
        setState(() {
          _loading = true;
        });
        press();
      },
    );
  }
}
