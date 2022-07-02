import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/bloc/user/user_bloc.dart';
import 'package:reality_near/presentation/views/AR/localandwebobjectsexample.dart';
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
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) async {
        if (state is UserLoggedInState) {
          //Show dialog when Login failed or login without wallet
          if (state.isLoggedIn) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/createUser', ModalRoute.withName('/'));
          }
        }
      },
      child: Scaffold(
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
                height: MediaQuery.of(context).size.height * 0.25,
              ),
            ),
            Positioned(
                bottom: 10,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: LoginBtns(context))),
          ],
        ),
      ),
    );
  }

  Widget LoginBtns(BuildContext context) {
    return Column(
      children: [
        //Login Text
        FittedBox(
          child: GestureDetector(
            onTap: (() => //creamos un evento en el bloc
                BlocProvider.of<UserBloc>(context, listen: false)
                    .add(UserLoginWalletEvent(context, ''))),
            child: Container(
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                decoration: BoxDecoration(
                    color: greenPrimary,
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
      ],
    );
  }
}
