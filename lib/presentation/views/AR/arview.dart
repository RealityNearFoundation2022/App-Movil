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
import 'package:path_provider/path_provider.dart';

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
  // String UrlAr =
  //     "https://github.com/eduperaltas/3dGLBRepository/raw/main/Bienvenido2.glb";
  String UrlAr =
      "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/DamagedHelmet/glTF-Binary/DamagedHelmet.glb";

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

    var newNode = ARNode(
        type: NodeType.webGLB,
        uri:
            "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/DamagedHelmet/glTF-Binary/DamagedHelmet.glb",
        scale: Vector3(0.2, 0.2, 0.2));
    bool didAddWebNode = await this.arObjectManager.addNode(newNode);

    //Download model to file system
    httpClient = HttpClient();
    _downloadFile(
        "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/DamagedHelmet/glTF-Binary/DamagedHelmet.glb",
        "LocalDuck.glb");
    // Alternative to use type fileSystemAppFolderGLTF2:
    //_downloadAndUnpack(
    //    "https://drive.google.com/uc?export=download&id=1fng7yiK0DIR0uem7XkV2nlPSGH9PysUs",
    //    "Chicken_01.zip");
  }

  Future<File> _downloadFile(String url, String filename) async {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename');
    await file.writeAsBytes(bytes);
    print("Downloading finished, path: " '$dir/$filename');
    return file;
  }

  // Future<void> _downloadAndUnpack(String url, String filename) async {
  //   var request = await httpClient.getUrl(Uri.parse(url));
  //   var response = await request.close();
  //   var bytes = await consolidateHttpClientResponseBytes(response);
  //   String dir = (await getApplicationDocumentsDirectory()).path;
  //   File file = new File('$dir/$filename');
  //   await file.writeAsBytes(bytes);
  //   print("Downloading finished, path: " + '$dir/$filename');

  //   // To print all files in the directory: print(Directory(dir).listSync());
  //   try {
  //     await ZipFile.extractToDirectory(
  //         zipFile: File('$dir/$filename'), destinationDir: Directory(dir));
  //     print("Unzipping successful");
  //   } catch (e) {
  //     print("Unzipping failed: " + e);
  //   }
  // }

  Future<void> onWebObjectAtOriginButtonPressed() async {
    if (webObjectNode != null) {
      arObjectManager.removeNode(webObjectNode);
      webObjectNode = null;
    } else {
      var newNode = ARNode(
          type: NodeType.webGLB,
          uri:
              "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/DamagedHelmet/glTF-Binary/DamagedHelmet.glb",
          scale: Vector3(0.2, 0.2, 0.2));
      bool didAddWebNode = await arObjectManager.addNode(newNode);
      webObjectNode = (didAddWebNode) ? newNode : null;
    }
  }
}
