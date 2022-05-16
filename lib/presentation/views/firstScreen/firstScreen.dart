import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../core/helper/url_constants.dart';
import '../login/login.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

//Variables
  static String routeName = "/firstScreen";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundSoftBlue,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//Top spacer
            SizedBox(height: ScreenWH(context).height * 0.3),
//Logo image
            Image.asset('assets/imgs/Logo_sin_fondo.png',
                height: 200, width: 200),
//Login Text
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: (() => Navigator.pushNamed(context, Login.routeName)),
                  child: Text('Ingresa con tu Near Wallet',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: txtPrimary,
                          decoration: TextDecoration.none)),
                )),
//Register Text
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText(
                  text: TextSpan(
                      text: '¿No tienes una? ',
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 20,
                        color: txtPrimary,
                      ),
                      children: [
                    TextSpan(
                      text: 'Crea una',
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 20,
                          color: txtPrimary,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchUrlString(REGISTER_NEAR_WALLET,
                            mode: LaunchMode.externalApplication),
                    ),
                  ])),
            ),
//Version Text
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.bottomCenter,
                child: Text('v. 1.0.0',
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 18,
                        color: const Color.fromARGB(255, 216, 216, 216),
                        decoration: TextDecoration.none)),
              ),
            ),
          ]),
    );
  }
}
