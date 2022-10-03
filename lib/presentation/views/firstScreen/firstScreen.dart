import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/register/registerScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../../../core/framework/globals.dart';
import '../login/login.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key key}) : super(key: key);
  static String routeName = "/firstScreen";

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

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
    _controller = VideoPlayerController.network("https://github.com/RealityNearFoundation2022/App-Movil/raw/develop/assets/video/IntroAppRN.mp4")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    // Inicializa el controlador y almacena el Future para utilizarlo luego
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.play();
    // Usa el controlador para hacer un bucle en el vídeo
    _controller.setLooping(true);

  }

  @override
  void dispose() {
    // Asegúrate de despachar el VideoPlayerController para liberar los recursos
    _controller.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _controller.value.isInitialized
              ? VideoPlayer(_controller) : loading(),
          //Logo image
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 15),
            alignment: Alignment.topCenter,
            child: Image.asset('assets/imgs/Logo_sin_fondo.png',
                height: 120, width: 120),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     color: Colors.white,
          //     height: MediaQuery.of(context).size.height * 0.21,
          //   ),
          // ),
          Positioned(
              bottom: MediaQuery.of(context).size.height * 0.06,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: loginBtns(context))),
        ],
      ),
    );
  }

  loading() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LoadingAnimationWidget.dotsTriangle(
            color: greenPrimary,
            size: ScreenWH(context).width * 0.3,
          )
        ],
      ),
    );
  }
  Widget loginBtns(BuildContext context) {
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
                child: Center(
                  child: Text(S.current.btnLogEmail,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          decoration: TextDecoration.none)),
                )),
          ),
        ),
        // const SizedBox(height: 10,),


        FittedBox(
          child: GestureDetector(
            onTap: (() => Navigator.pushNamed(context, RegisterScreen.routeName)),
              child: Container(
                alignment: Alignment.center,
                  margin:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 85),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Center(
                  child: Text(S.current.Registrate,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: greenPrimary,
                          decoration: TextDecoration.none)),
                )),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
