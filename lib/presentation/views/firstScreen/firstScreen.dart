import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/register/registerScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      body: Stack(
        children: [
          Container(
            color: Colors.grey,
          ),
          //Logo image
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            alignment: Alignment.topCenter,
            child: Image.asset('assets/imgs/Logo_sin_fondo.png',
                height: 120, width: 120),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.09,
            ),
          ),
          Positioned(
              bottom: MediaQuery.of(context).size.height * 0.015,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: LoginBtns(context))),
        ],
      ),
    );
  }

  Widget LoginBtns(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: GestureDetector(
            onTap: (() => Navigator.pushNamed(context, Login.routeName)),
            child: Container(
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                decoration: BoxDecoration(
                    color: greenPrimary,
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
          onTap: (() => Navigator.pushNamed(context, RegisterScreen.routeName)),
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
        const SizedBox(height: 15),
      ],
    );
  }
}
