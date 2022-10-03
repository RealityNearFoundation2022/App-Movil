import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/bloc/user/user_bloc.dart';

class ErrorAlertDialog extends StatelessWidget {
  final String errorMessage;
  const ErrorAlertDialog({Key key, this.errorMessage}) : super(key: key);

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
                Container(
                  width: ScreenWH(context).width * 0.15,
                  height: ScreenWH(context).width * 0.15,
                  //circle
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red,
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: ScreenWH(context).width * 0.12,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: txtPrimary),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    S.current.VerificaLosDatosIngresados,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: txtPrimary),
                  ),
                ),
                const SizedBox(height: 20),
                button(S.current.Intentardenuevo, () {
                  BlocProvider.of<UserBloc>(context, listen: false)
                      .add(UserLoginAgainEvent());
                  Navigator.of(context).pop();
                }, greenPrimary),
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
