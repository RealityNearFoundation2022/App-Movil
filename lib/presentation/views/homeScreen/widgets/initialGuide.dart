import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/homeScreen/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class initialGuide extends StatefulWidget {
  int index;
  initialGuide({Key key, this.index}) : super(key: key);

  @override
  State<initialGuide> createState() => _initialGuideState();
}

class _initialGuideState extends State<initialGuide> {
  _storeOnboardInfo() async {
    print("Shared pref called");
    bool guideIsViewed = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('Guide', guideIsViewed);
    print(prefs.getBool('Guide'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Stack(
        children: [
          widget.index != 3
              ? Row(
                  mainAxisAlignment: widget.index == 1
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(
                          left: ScreenWH(context).width * 0.01,
                          bottom: ScreenWH(context).height * 0.024),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Colors.grey[350].withOpacity(0.5),
                              Colors.grey[600].withOpacity(0.5)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          widget.index == 1 ? Icons.map_rounded : Icons.menu,
                          size: 40,
                          color: greenPrimary,
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
          widget.index == 3
              ? Container(
                  margin: const EdgeInsets.only(top: 60, left: 20),
                  child: Row(
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
                            value: true,
                            borderRadius: 30.0,
                            activeColor: Palette.kgreenNR,
                            showOnOff: true,
                            onToggle: (val) {},
                          ),
                        ),
                      ]),
                )
              : const SizedBox(),
          widget.index == 1
              ? centerContainer(S.current.Map, loremIpsum)
              : widget.index == 2
                  ? centerContainer(S.current.Menu, loremIpsum)
                  : centerContainer(S.current.Camara, loremIpsum),
        ],
      ),
    );
  }

  Widget centerContainer(String title, String body) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Center(
                  child: Text(title,
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: greenPrimary2,
                      )),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    width: ScreenWH(context).width * 0.8,
                    child: Text(
                      loremIpsum,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[400]),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 6,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  width: ScreenWH(context).width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.grey),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                          ),
                          onPressed: () {
                            _storeOnboardInfo();
                          },
                          child: Text(
                            S.current.Omitir,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 6,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(greenPrimary2),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                          ),
                          onPressed: () {
                            widget.index < 3
                                ? setState(() {
                                    widget.index = widget.index + 1;
                                  })
                                : {
                                    Navigator.pushNamed(
                                        context, HomeScreen.routeName),
                                    _storeOnboardInfo()
                                  };
                          },
                          child: Text(
                            S.current.Siguiente,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 6,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
