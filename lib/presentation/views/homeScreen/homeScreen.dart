import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/presentation/bloc/menu/menu_bloc.dart';
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
  bool status = true;
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
    return BlocBuilder<MenuBloc, MenuState>(builder: ((context, state) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: SizedBox(
            child: Stack(
              children: [
                //Body
                state is MenuArState
                    ? const ARSection()
                    : SizedBox(
                        height: ScreenWH(context).height * 0.91,
                        child: const NoArSection(),
                      ),
                //Header
                state is MenuArState ? header() : const SizedBox(),
                //Footer
                //MapBTN
                const Align(
                    alignment: Alignment.bottomLeft, child: MapContainer()),
                //MenuBTN
                const Align(
                    alignment: Alignment.bottomRight, child: MenuContainer()),
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
    }));
  }

  Widget header() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      width: double.infinity,
      child: Column(
        children: [
          Image.asset(
            "assets/imgs/Logo_sin_fondo.png",
            width: ScreenWH(context).width * 0.5,
            height: ScreenWH(context).height * 0.15,
          ),
          Container(
            width: ScreenWH(context).width * 0.8,
            alignment: Alignment.centerRight,
            child: FittedBox(
              child: FlutterSwitch(
                width: 45.0,
                height: 22.0,
                valueFontSize: 16.0,
                toggleSize: 15.0,
                value: status,
                borderRadius: 30.0,
                activeColor: greenPrimary,
                inactiveColor: offSwitch,
                onToggle: (val) {
                  setState(() {
                    status = val;
                  });
                  BlocProvider.of<MenuBloc>(context, listen: false)
                      .add(MenuCloseEvent());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
