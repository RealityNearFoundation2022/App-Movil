import 'package:flutter/material.dart';
import 'package:reality_near/presentation/views/mapScreen/mapScreen.dart';
import 'package:reality_near/presentation/views/menuScreen/menuScreen.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  "assets/imgs/Logo_sin_fondo.png",
                  width: 200,
                  height: 200,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Align(alignment: Alignment.bottomLeft, child: MapContainer()),
                  Align(
                      alignment: Alignment.bottomRight, child: MenuContainer())
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
