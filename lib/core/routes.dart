import 'package:flutter/cupertino.dart';
import 'package:reality_near/presentation/views/firstScreen/firstScreen.dart';
import 'package:reality_near/presentation/views/homeScreen/homeScreen.dart';
import 'package:reality_near/presentation/views/login/login.dart';
import 'package:reality_near/presentation/views/onboard/onboard.dart';

final Map<String, WidgetBuilder> routes = {
  FirstScreen.routeName: (context) => const FirstScreen(),
  Login.routeName: (context) => Login(),
  HomeScreen.routeName: (context) => HomeScreen(),
  OnBoard.routeName: (context) => OnBoard(),
};
