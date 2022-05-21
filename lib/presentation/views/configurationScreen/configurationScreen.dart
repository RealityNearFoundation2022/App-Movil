import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/presentation/bloc/menu/menu_bloc.dart';
import 'package:reality_near/presentation/views/FriendsScreen/friendsScreen.dart';
import 'package:reality_near/presentation/views/informationScreen/infoScreen.dart';
import 'package:sizer/sizer.dart';

class ConfigurationScreen extends StatefulWidget {
  //Variables
  static String routeName = "/configScreen";
  const ConfigurationScreen({Key? key}) : super(key: key);

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          margin: const EdgeInsets.only(right: 10),
          alignment: Alignment.centerRight,
          child: Text(
            "Configuración",
            style: GoogleFonts.sourceSansPro(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: greenPrimary2,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: greenPrimary2, size: 35),
        leading: IconButton(
          padding: const EdgeInsets.only(left: 35),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpansionMenu(context),
          textAndIcon('Permisos', Icons.keyboard_arrow_right_rounded),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(InfoScreen.routeName);
            },
            child:
                textAndIcon('Información', Icons.keyboard_arrow_right_rounded),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.only(
                bottom: 25,
                right: 25,
              ),
              child: const Text(
                'Cerrar Sesión',
                style: TextStyle(
                    color: greenPrimary2,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget ExpansionMenu(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: ScreenWH(context).width * 0.4,
          child: Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              collapsedTextColor: greenPrimary2,
              textColor: greenPrimary2,
              onExpansionChanged: (bool value) {
                setState(() {
                  isExpanded = value;
                });
              },
              trailing: Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_right_rounded,
                color: greenPrimary2,
                size: 35,
              ),
              childrenPadding: const EdgeInsets.only(right: 15),
              title: Text(
                "Cuenta",
                style: GoogleFonts.sourceSansPro(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: greenPrimary2,
                ),
              ),
              children: <Widget>[
                txtSubMenu('Usuario'),
                txtSubMenu('Wallet'),
                GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, FriendScreen.routeName),
                    child: txtSubMenu('Amigos'))
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget txtSubMenu(String txt) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.all(5.0),
      child: Text(
        txt,
        style: GoogleFonts.sourceSansPro(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black54),
      ),
    );
  }

  Widget textAndIcon(String text, IconData icon) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              text,
              style: GoogleFonts.sourceSansPro(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: greenPrimary2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Icon(
                icon,
                size: 20.sp,
                color: greenPrimary2,
              ),
            ),
          ],
        ),
      );
    });
  }
}
