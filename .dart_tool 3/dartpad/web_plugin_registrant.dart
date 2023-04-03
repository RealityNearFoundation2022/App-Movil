// Flutter web plugin registrant file.
//
// Generated file. Do not edit.
//

// @dart = 2.13
// ignore_for_file: type=lint

import 'package:device_info_plus_web/device_info_plus_web.dart';
import 'package:flutter_native_splash/flutter_native_splash_web.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:location_web/location_web.dart';
import 'package:package_info_plus_web/package_info_plus_web.dart';
import 'package:share_plus_web/share_plus_web.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';
import 'package:url_launcher_web/url_launcher_web.dart';
import 'package:video_player_web/video_player_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void registerPlugins([final Registrar? pluginRegistrar]) {
  final Registrar registrar = pluginRegistrar ?? webPluginRegistrar;
  DeviceInfoPlusPlugin.registerWith(registrar);
  FlutterNativeSplashWeb.registerWith(registrar);
  UnityWidgetController.registerWith(registrar);
  LocationWebPlugin.registerWith(registrar);
  PackageInfoPlugin.registerWith(registrar);
  SharePlusPlugin.registerWith(registrar);
  SharedPreferencesPlugin.registerWith(registrar);
  UrlLauncherPlugin.registerWith(registrar);
  VideoPlayerPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
