import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/presentation/views/AR/arview.dart';
import 'package:reality_near/presentation/views/mapScreen/mapScreen.dart';
import 'package:reality_near/presentation/views/menuScreen/menuScreen.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool status = false;
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
              status ? const ARSection() : const SizedBox(),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/imgs/Logo_sin_fondo.png",
                        width: 80,
                        height: 80,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "AR:",
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: greenPrimary2,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: FlutterSwitch(
                        width: 60.0,
                        height: 25.0,
                        valueFontSize: 16.0,
                        toggleSize: 20.0,
                        value: status,
                        borderRadius: 30.0,
                        activeColor: Palette.kgreenNR,
                        inactiveColor: Colors.red,
                        showOnOff: true,
                        onToggle: (val) {
                          setState(() {
                            status = val;
                          });
                        },
                      ),
                    ),
                  ],
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
