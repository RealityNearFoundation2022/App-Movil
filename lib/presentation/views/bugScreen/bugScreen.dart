// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:sizer/sizer.dart';

class BugScreen extends StatefulWidget {
  //Variables
  static String routeName = "/bugScreen";
  const BugScreen({Key key}) : super(key: key);

  @override
  State<BugScreen> createState() => _BugScreenState();
}

class _BugScreenState extends State<BugScreen> {
  List<bool> isExpanded = [false, false, false];

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
            S.current.ReporteFallos,
            style: GoogleFonts.sourceSansPro(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        leading: IconButton(
          padding: const EdgeInsets.only(left: 35),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: greenPrimary,
      body: Sizer(builder: (context, orientation, deviceType) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              BugSection(context, S.current.FalloCensura,
                  S.current.FiltracionContenidoSensible, 0),
              BugSection(context, S.current.CamaraAR, S.current.FalloAR, 1),
              BugSection(context, S.current.Otro, S.current.DescribeFallo, 2),
            ],
          ),
        );
      }),
    );
  }

  Widget BugSection(
      BuildContext context, String title, String description, int index) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: ExpansionTile(
            collapsedTextColor: Colors.white,
            textColor: Colors.white,
            onExpansionChanged: (bool value) {
              setState(() {
                isExpanded[index] = value;
              });
            },
            childrenPadding: const EdgeInsets.only(right: 15),
            trailing: Icon(
              isExpanded[index]
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_right_rounded,
              color: Colors.white,
              size: 35,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.sourceSansPro(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: GoogleFonts.sourceSansPro(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            children: <Widget>[
              bugForm(),
            ],
          ),
        ),
      );
    });
  }

  Widget bugForm() {
    return Container(
      width: ScreenWH(context).width * 0.7,
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            cursorColor: Colors.black12,
            style: GoogleFonts.sourceSansPro(
                color: Colors.black54,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500),
            maxLines: 5,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                hintStyle: GoogleFonts.sourceSansPro(
                    color: Colors.black26,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                hintText: S.current.QueDeseasQueMejoremos),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                S.current.AdjuntarFoto,
                style: GoogleFonts.sourceSansPro(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey[600]),
                elevation: MaterialStateProperty.all(1),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 35,
                    // vertical: 10,
                  ),
                ),
              ),
              onPressed: () {},
              child: Text(
                S.current.Enviar,
                style: GoogleFonts.sourceSansPro(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
