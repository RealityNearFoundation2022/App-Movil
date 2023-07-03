import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/models/asset_model.dart';
import 'package:reality_near/data/repository/assetRepository.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/bloc/menu/menu_bloc.dart';
import 'package:reality_near/presentation/views/AR/widget/screenshot_dialog.dart';
import 'package:reality_near/presentation/views/homeScreen/home_screen.dart';
import 'package:reality_near/presentation/views/mapScreen/map_halfscreen.dart';

import 'package:share_plus/share_plus.dart';

class ARSection extends StatefulWidget {
  static String routeName = "/arView";
  final String scene;

  const ARSection({Key key, this.scene}) : super(key: key);

  @override
  State<ARSection> createState() => _ARSectionState();
}

class _ARSectionState extends State<ARSection> {
  HttpClient httpClient;
  AssetModel assetAR;
  bool loadDataAPI = true;
  UnityWidgetController _unityWidgetController;
  bool inLocationRange = false;

  @override
  void dispose() {
    close();
    super.dispose();
  }

  @override
  void initState() {
    getAssets().then((result) {
      setState(() {});
    });

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

  getAssets() async {
    var lstAssets = await AssetRepository().getAllAssets();
    await evaluateMostCloseAsset(lstAssets);
  }

  //distancia apropriada para AR
  evaluateMostCloseAsset(List<AssetModel> lst) async {
    AssetModel mostCloseAsset;
    double distance = 0;
    LatLng userLocation;

    //lista de objetos no default
    var lstNoDefault =
        lst.where((element) => element.defaultAsset == false).toList();
    //lista de objetos default
    var lstDefault =
        lst.where((element) => element.defaultAsset == true).toList();

    var currentLocation = await getCurrentLocation();
    userLocation = LatLng(currentLocation.latitude, currentLocation.longitude);
    for (var item in lstNoDefault) {
      for (var location in item.locations) {
        double range = double.parse(location.rule);
        double distanceTemp =
            calculateDistanceMts(userLocation, location.position);
        if (distance == 0) {
          distance = distanceTemp;
          if (distanceTemp < range) {
            mostCloseAsset = item;
          }
        } else if (distanceTemp < distance && distanceTemp < range) {
          distance = distanceTemp;
          mostCloseAsset = item;
        }
      }
    }

    assetAR = mostCloseAsset ?? randomElementFromList(lstDefault);
    print("el asset mas cercano es: ${assetAR.name} esta a $distance mts");
    setState(() {
      loadDataAPI = false;
    });
  }

  randomElementFromList(List lst) {
    if (lst.length > 1) {
      var random = Random();
      var element = lst[random.nextInt(lst.length)];
      return element;
    } else {
      return lst[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Material(
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            close();
          },
          child: Stack(
            children: [
              loadDataAPI
                  ? loading()
                  : UnityWidget(
                      onUnityCreated: _onUnityCreated,
                      onUnityMessage: onUnityMessage,
                      onUnitySceneLoaded: onUnitySceneLoaded,
                      unloadOnDispose: true,
                      useAndroidViewSurface: false,
                      printSetupLog: false,
                      enablePlaceholder: false,
                      fullscreen: true),
              header(),
              _bottomBar()
            ],
          ),
        ),
      ),
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
                  child: widget.scene != "Vuforia"
                      ? const SizedBox()
                      : IconButton(
                          iconSize: MediaQuery.of(context).size.height * 0.06,
                          icon: const Icon(
                            Icons.map_rounded,
                            color: greenPrimary,
                          ),
                          onPressed: () {
                            // show modal bottom sheet
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: false,
                              //border
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30),
                                ),
                              ),
                              builder: (context) => const MapBoxScreen(),
                            );
                          },
                        ),
                ),
                state is MenuMapaState
                    ? const SizedBox()
                    : Container(
                        width: ScreenWH(context).width * 0.15,
                        height: ScreenWH(context).width * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: greenPrimary, width: 2),
                        ),
                        margin: const EdgeInsets.only(bottom: 15),

                        //Button Cammera
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _loadScreenshot = true;
                            });
                            onTakeScreenshot();
                          },
                          icon: _loadScreenshot
                              ? LoadingAnimationWidget.dotsTriangle(
                                  color: greenPrimary,
                                  size: ScreenWH(context).width * 0.05,
                                )
                              : Icon(
                                  FontAwesomeIcons.camera,
                                  color: greenPrimary,
                                  size:
                                      MediaQuery.of(context).size.height * 0.04,
                                ),
                        ),
                      ),
                state is MenuMapaState
                    ? const SizedBox()
                    : Container(
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

  void onUnityMessage(message) async {
    print(message.toString());
    if (message.toString() == "downloadAssetBundle") {
      downloadAssetBundle();
    }
    if (message != "downloadAssetBundle") {
      String encoded = message;
      setState(() {
        _unityScreenshot = base64.decode(encoded);
        _loadScreenshot = false;
      });
    }
  }

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

  void downloadAssetBundle() async {
    var path = Platform.isAndroid ? assetAR.path : assetAR.path2;
    _unityWidgetController.postMessage(
        "assetAR", "DownloadAssetBundleFromServer", path);
  }

  void takeScreenshot() async {
    // Llama a la función de Unity que toma la captura de pantalla
    _unityWidgetController.postMessage(
      widget.scene == "Vuforia" ? "assetAR" : "InitialController",
      'TakeScreenshot',
      '',
    );

    // Espera un segundo para asegurarse de que se haya enviado el mensaje antes de intentar obtener los datos de la imagen
    await Future.delayed(const Duration(seconds: 1));
    _unityWidgetController.pause();
    setState(() {
      _loadScreenshot = false;
    });
  }

  Uint8List _unityScreenshot;
  bool _loadScreenshot = false;
  File file = File('');
  List<XFile> filesToShare = <XFile>[];
  final GlobalKey _globalKey = GlobalKey();
  // //Function to take screenshot and share image
  Future<void> onTakeScreenshot() async {
    // Llama a la función que toma la captura de pantalla
    await takeScreenshot();

    await showDialog(
        context: context,
        barrierColor: Colors.black.withOpacity(0.9),
        builder: (_) => ScreenshotDialog(
              globalKey: _globalKey,
              unityScreenshot: _unityScreenshot,
              xFunction: () {
                _unityWidgetController.resume();
              },
              saveFunction: () {
                _unityWidgetController.resume();
              },
              shareFunction: () {
                _unityWidgetController.resume();
              },
            )).whenComplete(() => _unityWidgetController.resume());
  }

  Widget button(String text, Function press, Color color) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 30),
      ),
      child: Text(
        text,
        style: GoogleFonts.notoSansJavanese(
          fontSize: 16,
          color: const Color.fromRGBO(255, 255, 255, 1.0),
          fontWeight: FontWeight.w700,
        ),
      ),
      onPressed: () async {
        press();
      },
    );
  }
}
