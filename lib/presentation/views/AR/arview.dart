import 'dart:io';
import 'dart:typed_data';

import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:latlong2/latlong.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/models/assetModel.dart';
import 'package:reality_near/data/repository/assetRepository.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/mapScreen/mapScreen.dart';
import 'package:reality_near/presentation/views/menuScreen/menuScreen.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vector_math/vector_math_64.dart';

import '../../../providers/location_provider.dart';
import '../mapScreen/widgets/placeDialog.dart';

class ARSection extends StatefulWidget {
  static String routeName = "/arView";

  const ARSection({Key key}) : super(key: key);

  @override
  State<ARSection> createState() => _ARSectionState();
}

class _ARSectionState extends State<ARSection> {
  ARSessionManager arSessionManager;
  ARObjectManager arObjectManager;
  ARNode localObjectNode;
  ARNode webObjectNode;
  ARNode fileSystemNode;
  HttpClient httpClient;
  ScreenshotController screenshotController = ScreenshotController();
  String UrlAr;
  bool status = true;
  AssetModel assetAR;
  bool loadDataAPI = true;
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();

  List<String> tiempos = [
    "11:00","11:30", "12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30"];
  LatLng positionAsset = LatLng(0, 0);
  bool inLocationRange = false;


  @override
  void dispose() {
    arSessionManager.dispose();
    super.dispose();
  }


  @override
  void initState() {
    getAsset("2").then((result) async {
      setState(() { });
    });
    onWebObjectAtOriginButtonPressed();
    Provider.of<LocationProvider>(context, listen: false).initialization();
    super.initState();
  }
  
  getAsset(String id) async{
    assetAR = await AssetRepository().getAsset(id);
    UrlAr = assetAR.path.split(" | ")[0];
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
              loadDataAPI  ? loading()
                  : ARView(
                onARViewCreated: onARViewCreated,
                planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
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
                    child:  Icon(Icons.camera_alt, color:const Color.fromARGB(
                        255, 255, 255, 255), size: ScreenWH(context).width * 0.1,),
                  ),
                ),
              ) ,
            ],
          )
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
                    arSessionManager.dispose();
                  Navigator.pushNamed(context, "/home");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onARViewCreated(

      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) async {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;

    this.arSessionManager.onInitialize(
          showFeaturePoints: false,
          showPlanes: false,
          customPlaneTexturePath: "assets/imgs/triangle.png",
          showWorldOrigin: false,
          handleTaps: false,
        );
    this.arObjectManager.onInitialize();
    this.arObjectManager.onNodeTap = onNodeTapped;

    var newNode = ARNode(
        type: NodeType.webGLB, uri: UrlAr, scale: Vector3(0.2, 0.2, 0.2));
    bool didAddWebNode = await this.arObjectManager.addNode(newNode);

  }

  Future<void> onNodeTapped(List<String> nodes) async{
    print("Node tapped: ${nodes.toString()} || ${inLocationRange.toString()}");
    var location = await getCurrentLocation();
    if(
        calculateDistanceMts(location.latitude, location.longitude,
            positionAsset.latitude, positionAsset.longitude)< 100){
      setState(() {
        inLocationRange = true;
        print("CAMBIO - " + inLocationRange.toString());
      });
    }

    if(tiempos.any((e) => e==getTimeHyM()) && inLocationRange ) {
      showDialog(context: context, builder: (context) => const PlaceDialog());
    }
  }

  Future<void> onTakeScreenshot() async {
    var capture = await arSessionManager.snapshot();

    await showDialog(
        context: context,
        builder: (_) => Dialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
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
                    Screenshot(
                      controller: screenshotController,
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.6,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: capture),
                              borderRadius: BorderRadius.circular(20.0),),
                          ),
                          Positioned(
                            top: 10,
                            left: MediaQuery.of(context).size.width * 0.22,
                            child: Image.asset(
                              "assets/imgs/Logo_sin_fondo.png",
                              width: ScreenWH(context).width * 0.25,
                              height: ScreenWH(context).height * 0.08,
                            ),
                          ),

                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          button(S.current.Confirmar, () async{
                            //Take Screenshot
                            final image = await screenshotController.capture();
                            //Save Screenshot
                            if(image != null){
                              await saveAndShare(image);
                            }
                          },  greenPrimary),
                          button(S.current.Volver, () => Navigator.pop(context),  const Color.fromRGBO(183, 182, 182, 1.0)),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        primary: const Color.fromRGBO(255, 255, 255, 1.0),
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

  Future<void> onWebObjectAtOriginButtonPressed() async {
    if (webObjectNode != null) {
      arObjectManager.removeNode(webObjectNode);
      webObjectNode = null;
    } else {
      var newNode = ARNode(
          type: NodeType.webGLB, uri: UrlAr, scale: Vector3(0.2, 0.2, 0.2));
      bool didAddWebNode = await arObjectManager.addNode(newNode);
      webObjectNode = (didAddWebNode) ? newNode : null;
    }
  }

  Future<String> saveImage(Uint8List bytes) async{
    await [Permission.storage].request();
    final time = DateTime.now().toIso8601String()
        .replaceAll(':', '-')
        .replaceAll('.', '-');
    final name = 'RealityNear_SS_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);

    return result['filePath'];
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytes(bytes);

    await Share.shareFiles([image.path]);
  }


}
