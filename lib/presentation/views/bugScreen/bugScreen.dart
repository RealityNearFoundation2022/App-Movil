// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:sizer/sizer.dart';

class BugScreen extends StatefulWidget {
  const BugScreen({Key? key}) : super(key: key);

  @override
  State<BugScreen> createState() => _BugScreenState();
}

class _BugScreenState extends State<BugScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SingleChildScrollView(
        child: Column(
          children: [
            bugContainer(context, 'Bug 1', 'Pequeña desprición de la falla'),
            bugContainer(context, 'Bug 2', 'Pequeña desprición de la falla'),
            bugContainer(context, 'Bug 3', 'Pequeña desprición de la falla'),
            otroBug(context)
          ],
        ),
      );
    });
  }

//Bugs preestablecidos
  Widget bugContainer(BuildContext context, String Title, String Description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: ScreenWH(context).width * 0.55,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Title,
                  style: GoogleFonts.sourceCodePro(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  Description,
                  style: GoogleFonts.sourceCodePro(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_right_rounded,
            color: Colors.white,
            size: 35,
          ),
        ],
      ),
    );
  }

  Widget otroBug(BuildContext context) {
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
                isExpanded = value;
              });
            },
            childrenPadding: const EdgeInsets.only(right: 15),
            trailing: Icon(
              isExpanded
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_right_rounded,
              color: Colors.white,
              size: 35,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Otro',
                  style: GoogleFonts.sourceCodePro(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Describe el bug',
                  style: GoogleFonts.sourceCodePro(
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
            style: GoogleFonts.sourceCodePro(
                color: Colors.black54,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500),
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                hintStyle: GoogleFonts.sourceCodePro(
                    color: Colors.black26,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.white),
                ),
                hintText: '¿Qué deseas que mejoremos?'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Adjuntar foto',
              style: GoogleFonts.sourceCodePro(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromRGBO(61, 232, 160, 0.5)),
              elevation: MaterialStateProperty.all(1),
            ),
            onPressed: () {},
            child: Text(
              'Galería',
              style: GoogleFonts.sourceCodePro(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromRGBO(61, 232, 160, 0.5)),
                elevation: MaterialStateProperty.all(1),
              ),
              onPressed: () {},
              child: Text(
                'Enviar',
                style: GoogleFonts.sourceCodePro(
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