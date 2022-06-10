import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/presentation/views/AR/arview.dart';
import 'package:reality_near/presentation/views/homeScreen/widgets/initialGuide.dart';
import 'package:reality_near/presentation/views/noAR/noARSection.dart';
import 'package:reality_near/presentation/views/mapScreen/mapScreen.dart';
import 'package:reality_near/presentation/views/menuScreen/menuScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool status = false;
  bool viewGuide = true;
  _storeGuidedInfo() async {
    print("Shared pref called");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      viewGuide = prefs.getBool('Guide') ?? true;
    });
    print(prefs.getBool('Guide'));
  }

  @override
  void initState() {
    super.initState();
    _storeGuidedInfo();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SizedBox(
          // width: double.infinity,
          // height: double.infinity,
          child: Stack(
            children: [
              Container(
                height: ScreenWH(context).height * 0.87,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                        FittedBox(
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
                        Container(
                          padding: const EdgeInsets.only(left: 35),
                          child: Image.asset(
                            "assets/imgs/Logo_sin_fondo.png",
                            width: 80,
                            height: 80,
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: status ? const ARSection() : const NoArSection(),
                    ),
                  ],
                ),
              ),
              Align(alignment: Alignment.bottomLeft, child: MapContainer()),
              Align(alignment: Alignment.bottomRight, child: MenuContainer()),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: const [
              //     Align(alignment: Alignment.bottomLeft, child: MapContainer()),
              //     Align(
              //         alignment: Alignment.bottomRight, child: MenuContainer())
              //   ],
              // ),
              viewGuide
                  ? initialGuide(
                      index: 1,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
