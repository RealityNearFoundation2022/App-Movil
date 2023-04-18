import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:latlong2/latlong.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/models/asset_model.dart';
import 'package:reality_near/data/repository/assetRepository.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/bloc/menu/menu_bloc.dart';
import 'package:reality_near/presentation/views/mapScreen/map_halfscreen.dart';
import 'dart:ui' as ui;

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
    _unityWidgetController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    getAssets().then((result) {
      setState(() {});
    });

    super.initState();
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
            _unityWidgetController.dispose();
            Navigator.pop(context);
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
                  child: IconButton(
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
                            onTakeScreenshot();
                          },
                          icon: Icon(
                            FontAwesomeIcons.camera,
                            color: greenPrimary,
                            size: MediaQuery.of(context).size.height * 0.04,
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
                            //end unity
                            _unityWidgetController.dispose();
                            Navigator.pushNamed(context, "/home");
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
      "assetAR",
      'TakeScreenshot',
      '',
    );
    setState(() {
      _loadScreenshot = true;
    });

    // Espera un segundo para asegurarse de que se haya enviado el mensaje antes de intentar obtener los datos de la imagen
    await Future.delayed(const Duration(seconds: 1));
  }

  Uint8List _unityScreenshot;
  Uint8List _screenshotCompleted;
  bool _loadScreenshot = false;
  final GlobalKey _globalKey = GlobalKey();
  File file = File('');
  List<XFile> filesToShare = <XFile>[];
  // //Function to take screenshot and share image
  Future<void> onTakeScreenshot() async {
    // Llama a la función que toma la captura de pantalla
    await takeScreenshot();

    await showDialog(
        context: context,
        builder: (_) => Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: _loadScreenshot
                    ? Column(
                        children: [
                          //Muestra un circulo de carga y el mensaje de cargando
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
                      )
                    : Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "¿Deseas guardar la imagen?",
                            style: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                color: greenPrimary),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          RepaintBoundary(
                            key: _globalKey,
                            child: Stack(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image.memory(
                                    _unityScreenshot,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/imgs/Logo_sin_fondo.png",
                                      width: ScreenWH(context).width * 0.3,
                                      height: ScreenWH(context).height * 0.08,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.ios_share,
                                    color: greenPrimary,
                                  ),
                                  onPressed: () async {
                                    await _capturePng().whenComplete(() =>
                                        _shareImage(_screenshotCompleted));
                                  },
                                ),
                                // const SizedBox(
                                //   width: 5,
                                // ),
                                button(
                                    S.current.Confirmar,
                                    () async => {
                                          await _capturePng().whenComplete(() =>
                                              _saveImageToGallery(
                                                  _screenshotCompleted))
                                        },
                                    greenPrimary),
                                const SizedBox(
                                  width: 5,
                                ),
                                button(
                                    S.current.Volver,
                                    () => {Navigator.pop(context)},
                                    const Color.fromRGBO(183, 182, 182, 1.0)),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            )));
  }

  Future<void> _saveImageToGallery(Uint8List uint8List) async {
    // Guarda la imagen en la galería y obten el path
    final String path = await ImageGallerySaver.saveImage(uint8List);
    Navigator.pop(context);
  }

  Future<void> _capturePng() async {
    // Captura la imagen del widget
    ui.Image image = await (_globalKey.currentContext.findRenderObject()
            as RenderRepaintBoundary)
        .toImage(pixelRatio: 3.0);

    // Convierte la imagen en bytes
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8list = byteData.buffer.asUint8List();
    setState(() {
      _screenshotCompleted = uint8list;
    });
  }

  Future<void> _shareImage(Uint8List imageBytes) async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      String fileName =
          "screenshot_${DateTime.now().millisecondsSinceEpoch}.png";
      File file = File('${tempDir.path}/$fileName');
      await file.writeAsBytes(imageBytes);

      //create XFile and add to list
      // XFile xFile = XFile(file.path);
      // filesToShare.add(xFile);

      await Share.shareFiles([file.path], text: 'Check out my screenshot!');
      // await Share.shareXFiles(filesToShare, text: 'Check out my screenshot!');
    } catch (e) {
      print('Error sharing image: $e');
    }
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
