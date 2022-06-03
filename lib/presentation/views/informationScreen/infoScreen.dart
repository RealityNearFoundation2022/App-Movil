import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/presentation/views/bugScreen/bugScreen.dart';
import 'package:sizer/sizer.dart';

class InfoScreen extends StatelessWidget {
  //Variables
  static String routeName = "/infoScreen";
  const InfoScreen({Key key}) : super(key: key);

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
            "Información",
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
          const SizedBox(
            height: 40,
          ),
          // textAndIcon('Actualizaciones', Icons.keyboard_arrow_right_rounded),
          GestureDetector(
              onTap: (() {
                Navigator.of(context).pushNamed(BugScreen.routeName);
              }),
              child: textAndIcon(
                  'Reporte de Fallos', Icons.keyboard_arrow_right_rounded)),
          textAndIcon(
              'Política de privacidad', Icons.keyboard_arrow_right_rounded),
          textAndIcon(
              'Términos y condiciones', Icons.keyboard_arrow_right_rounded),
        ],
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
