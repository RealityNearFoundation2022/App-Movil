import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/register/registerScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../core/helper/url_constants.dart';
import '../login/login.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key key}) : super(key: key);
  static String routeName = "/firstScreen";

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  _storeGuidedInfo() async {
    print("Shared pref called");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('Guide', true);
    print(prefs.getBool('Guide'));
  }

  @override
  void initState() {
    super.initState();
    _storeGuidedInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //Logo image
            Image.asset('assets/imgs/Logo_sin_fondo.png',
                height: 200, width: 200),
            //Login Text
            FittedBox(
              child: GestureDetector(
                onTap: (() => Navigator.pushNamed(context, Login.routeName,
                    arguments: {'type': 'wallet'})),
                child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    decoration: BoxDecoration(
                        color: greenPrimary2,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(S.current.btnLogWallet,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sourceSansPro(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            decoration: TextDecoration.none))),
              ),
            ),
            //Register Text
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText(
                  text: TextSpan(
                      text: S.current.noTienesUna,
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 16,
                        color: Colors.grey[400],
                      ),
                      children: [
                    TextSpan(
                      text: S.current.CreaUna,
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 16,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w600),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchUrlString(REGISTER_NEAR_WALLET,
                            mode: LaunchMode.externalApplication),
                    ),
                  ])),
            ),
            //Divider
            const SizedBox(height: 10),
            SizedBox(
              width: 300,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey[400],
                      thickness: 0.9,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      S.current.O,
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 16,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey[400],
                      thickness: 0.9,
                    ),
                  ),
                ],
              ),
            ),

            //Login Text
            FittedBox(
              child: GestureDetector(
                onTap: (() => Navigator.pushNamed(context, Login.routeName,
                    arguments: {'type': 'email'})),
                child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(S.current.btnLogEmail,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sourceSansPro(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            decoration: TextDecoration.none))),
              ),
            ),

            //Register Text
            GestureDetector(
              onTap: (() =>
                  Navigator.pushNamed(context, RegisterScreen.routeName)),
              child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    S.current.Registrate,
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 16,
                      color: Colors.grey[400],
                    ),
                  )),
            ),
          ]),
    );
  }
}
