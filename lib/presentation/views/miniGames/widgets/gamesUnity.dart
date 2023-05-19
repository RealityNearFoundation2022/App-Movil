import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/bloc/menu/menu_bloc.dart';
import 'package:reality_near/presentation/views/homeScreen/home_screen.dart';

class GameUnity extends StatefulWidget {
  static String routeName = "/gameView";
  final String scene;

  const GameUnity({Key key, this.scene}) : super(key: key);

  @override
  State<GameUnity> createState() => _GameUnityState();
}

class _GameUnityState extends State<GameUnity> {
  HttpClient httpClient;
  UnityWidgetController _unityWidgetController;

  @override
  void dispose() {
    close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  close() async {
    await _unityWidgetController.pause();
    await Future.delayed(const Duration(milliseconds: 200));
    _unityWidgetController.unload();
    _unityWidgetController.dispose();
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 100),
      pageBuilder: (context, animation, secondaryAnimation) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: const HomeScreenV2(),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: UnityWidget(
          onUnityCreated: _onUnityCreated,
          onUnityMessage: onUnityMessage,
          onUnitySceneLoaded: onUnitySceneLoaded,
          unloadOnDispose: true,
          enablePlaceholder: false,
          fullscreen: false),
    );
  }

  _bottomBar() {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        return Positioned(
          bottom: 15,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
                horizontal: state is MenuMapaState ? 0 : 15),
            color: Colors.transparent,
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: ScreenWH(context).width * 0.15,
                  height: ScreenWH(context).width * 0.15,
                  margin: const EdgeInsets.only(bottom: 15),
                  child: IconButton(
                    iconSize: MediaQuery.of(context).size.height * 0.06,
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: greenPrimary,
                    ),
                    onPressed: () {
                      close();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //Loading Screen
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
          ),
          const SizedBox(height: 20),
          Text(
            S.current.Cargando,
            style: GoogleFonts.sourceSansPro(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  //Header with icon logo and Switch for AR
  Widget header() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top + 10),
      width: ScreenWH(context).width,
      height: ScreenWH(context).height * 0.15,
      child: Center(
        child: Image.asset(
          "assets/imgs/Logo_sin_fondo.png",
          width: ScreenWH(context).width * 0.45,
          height: ScreenWH(context).height * 0.12,
        ),
      ),
    );
  }

  void onUnityMessage(message) async {}

  void onUnitySceneLoaded(SceneLoaded scene) {
    print("Scene loaded: ${scene.buildIndex}");
    print("Scene loaded: ${scene.name}");
  }

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(controller) {
    _unityWidgetController = controller;
    selectScene(widget.scene);
  }

  void selectScene(String sceneName) async {
    _unityWidgetController.postMessage(
        'InitialController', 'LoadScene', sceneName);
  }
}
