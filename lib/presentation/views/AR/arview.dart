import 'dart:io';

import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:vector_math/vector_math_64.dart';

import '../mapScreen/widgets/placeDialog.dart';

class ARSection extends StatefulWidget {
  const ARSection({Key key}) : super(key: key);

  @override
  State<ARSection> createState() => _ARSectionState();
}

class _ARSectionState extends State<ARSection> {
  ARSessionManager arSessionManager;
  ARObjectManager arObjectManager;
  //String localObjectReference;
  ARNode localObjectNode;
  //String webObjectReference;
  ARNode webObjectNode;
  ARNode fileSystemNode;
  HttpClient httpClient;
  String UrlAr =
      "https://github.com/eduperaltas/3dGLBRepository/raw/main/Luta_livre_final2.glb";
  // String UrlAr =
  //     "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Avocado/glTF-Binary/Avocado.glb";

  @override
  void dispose() {
    super.dispose();
    arSessionManager.dispose();
  }

  @override
  void initState() {
    onWebObjectAtOriginButtonPressed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ARView(
      onARViewCreated: onARViewCreated,
      planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
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
    print("Node tapped: ${nodes.toString()}");
    showDialog(context: context, builder: (context) => const PlaceDialog());
    // Navigator.pushNamed(context, '/qrViewScreen');
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
}
