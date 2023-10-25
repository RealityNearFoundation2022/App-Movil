import 'package:flutter/material.dart';

enum AppTheme { lightMode, darkMode }

final appThemeData = {
  AppTheme.lightMode: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.green,
  ),
  AppTheme.darkMode: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green[700],
  )
};
