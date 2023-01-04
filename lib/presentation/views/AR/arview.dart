import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:latlong2/latlong.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:native_screenshot/native_screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:reality_near/data/models/assetModel.dart';
import 'package:reality_near/data/repository/assetRepository.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/mapScreen/mapScreen.dart';
import 'package:reality_near/presentation/views/menuScreen/menuScreen.dart';
import 'package:reality_near/presentation/widgets/others/snackBar.dart';
import '../mapScreen/widgets/placeDialog.dart';

class ARSection extends StatefulWidget {
  static String routeName = "/arView";

  const ARSection({Key key}) : super(key: key);

  @override
  State<ARSection> createState() => _ARSectionState();
}

class _ARSectionState extends State<ARSection> {
  HttpClient httpClient;
  var scr = GlobalKey();
  String urlAr;
  bool status = true;
  AssetModel assetAR;
  bool loadDataAPI = true;
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  UnityWidgetController _unityWidgetController;
  LatLng positionAsset = LatLng(0, 0);
  bool inLocationRange = false;

  @override
  void dispose() {
    _unityWidgetController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    getAsset("8").then((result) async {
      setState(() {});
    });
    super.initState();
  }

  getAsset(String id) async {
    assetAR = await AssetRepository().getAsset(id);
    urlAr = API_REALITY_NEAR_IMGs + assetAR.path.split(" | ")[0];
    double latitude = double.parse(assetAR.path.split(" | ")[1].split(",")[0]);
    double longitude = double.parse(assetAR.path.split(" | ")[1].split(",")[1]);
    positionAsset = LatLng(latitude, longitude);
    loadDataAPI = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          body: Stack(
        children: [
          loadDataAPI
              ? loading()
              : RepaintBoundary(
                  key: scr,
                  child: UnityWidget(
                      onUnityCreated: _onUnityCreated,
                      onUnityMessage: onUnityMessage,
                      onUnitySceneLoaded: onUnitySceneLoaded,
                      useAndroidViewSurface: false,
                      printSetupLog: false,
                      enablePlaceholder: false,
                      // fullscreen: false
                  ),
                ),
          header(),
          //Map-Button
          Align(
              alignment: Alignment.bottomLeft,
              child: MapContainer(
                showCaseKey: _two,
              )),
          //Menu-Button
          Align(
              alignment: Alignment.bottomRight,
              child: MenuContainer(
                showCaseKey: _one,
              )),
          Positioned(
            left: ScreenWH(context).width * 0.4,
            bottom: ScreenWH(context).height * 0.04,
            //Button Cammera
            child: SizedBox(
              width: ScreenWH(context).width * 0.18,
              height: ScreenWH(context).height * 0.08,
              child: FloatingActionButton(
                backgroundColor: greenPrimary,
                onPressed: () {
                  onTakeScreenshot();
                },
                child: Icon(
                  Icons.camera_alt,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  size: ScreenWH(context).width * 0.1,
                ),
              ),
            ),
          ),
        ],
      )),
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
      margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      width: double.infinity,
      child: Column(
        children: [
          Image.asset(
            "assets/imgs/Logo_sin_fondo.png",
            width: ScreenWH(context).width * 0.45,
            height: ScreenWH(context).height * 0.12,
          ),
          Container(
            width: ScreenWH(context).width * 0.8,
            alignment: Alignment.centerRight,
            child: CupertinoSwitch(
              activeColor: greenPrimary,
              value: status,
              onChanged: (value) {
                setState(() {
                  status = value;
                  // arSessionManager.dispose();
                  _unityWidgetController.dispose();

                  Navigator.pushNamed(context, "/home");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void onUnityMessage(message) async {
    // var location = await getCurrentLocation();
    // if (message.toString() == "touchAsset" &&
    //     (calculateDistanceMts(location.latitude, location.longitude,
    //             positionAsset.latitude, positionAsset.longitude) <
    //         100)) {
    //   setState(() {
    //     showDialog(context: context, builder: (context) => const PlaceDialog());
    //   });
    // }
    if (message.toString() == "touchAsset") {
      setState(() {
        showDialog(context: context, builder: (context) => const PlaceDialog());
      });
    }
  }

  void onUnitySceneLoaded(SceneLoaded scene) {}

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(controller) {
    controller.resume();
    _unityWidgetController = controller;
    _unityWidgetController.postMessage(
        "assetAR", "DownloadAssetBundleFromServer", assetAR.path);
    // "https://drive.google.com/u/0/uc?id=1EFnShz7yh8awVNW8tkqQuTQ_4FADCwJP&export=download | ");
  }

  takescreenshot() async {
    RenderRepaintBoundary boundary = scr.currentContext.findRenderObject();
    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    var pngBytes = byteData.buffer.asUint8List();
    return pngBytes;
  }

  ss() async {
    String path = await NativeScreenshot.takeScreenshot();

    debugPrint('Screenshot taken, path: $path');

    if (path == null || path.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error taking the screenshot :('),
        backgroundColor: Colors.red,
      )); // showSnackBar()
    } // if error

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('The screenshot has been saved'))); // showSnackBar()
  }

  deleteImageFromPath(String path) async {
    final file = File(path);
    await file.delete();
    Navigator.pop(context);
  }

  // //Function to take screenshot and share image
  Future<void> onTakeScreenshot() async {
    // var capture = await arSessionManager.snapshot();
    String path = await NativeScreenshot.takeScreenshot();
    File screenShot = File(path);
    await showDialog(
        context: context,
        builder: (_) => Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
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
                    // Stack(
                    //   children: [
                    //     Container(
                    //       width: MediaQuery.of(context).size.width * 0.7,
                    //       height: MediaQuery.of(context).size.height * 0.6,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(20),
                    //           image: DecorationImage(
                    //               image: FileImage(screenShot),
                    //               fit: BoxFit.cover)),
                    //     ),
                    //     // Positioned(
                    //     //   top: 10,
                    //     //   left: MediaQuery.of(context).size.width * 0.22,
                    //     //   child: Image.asset(
                    //     //     "assets/imgs/Logo_sin_fondo.png",
                    //     //     width: ScreenWH(context).width * 0.25,
                    //     //     height: ScreenWH(context).height * 0.08,
                    //     //   ),
                    //     // ),
                    //   ],
                    // ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: FileImage(screenShot), fit: BoxFit.fill)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          button(S.current.Confirmar,
                              () => Navigator.pop(context), greenPrimary),
                          button(
                              S.current.Volver,
                              () => deleteImageFromPath(path),
                              const Color.fromRGBO(183, 182, 182, 1.0)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
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

  saveimage(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    String time = DateTime.now()
        .toIso8601String()
        .replaceAll(':', '-')
        .replaceAll('.', '-');
    final image = File('${directory.path}/realityNearSS$time.png');
    image.writeAsBytes(bytes);
    ImageGallerySaver.saveFile(image.path)
        .whenComplete(() => showSnackBar(context, "Imagen Guardada", false));
  }
}
