import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/generated/l10n.dart';

buildCategory(String name, Color defaultFontColor, Size size, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        name,
        style: GoogleFonts.sourceSansPro(
          color: defaultFontColor,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      // GestureDetector(
      //   onTap: onTap,
      //   child: Text(
      //     S.current.Vertodos,
      //     style: GoogleFonts.sourceSansPro(
      //       color: const Color(0xff555555),
      //       fontSize: 16,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      // ),
    ],
  );
}
