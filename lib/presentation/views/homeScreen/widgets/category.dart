import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/generated/l10n.dart';

buildCategory(String name, Color defaultFontColor, Size size, Function onTap) {
  return Row(
    // mainAxisAlignment: MainAxisAlignment.,
    children: [
      Text(
        name,
        style: GoogleFonts.poppins(
          color: defaultFontColor,
          fontSize: size.width * 0.05,
          fontWeight: FontWeight.bold,
        ),
      ),
      const Spacer(),
      GestureDetector(
        onTap: onTap,
        child: Text(
          S.current.Vertodos,
          style: GoogleFonts.sourceSansPro(
            color: Colors.black54.withOpacity(0.5),
            fontSize: size.width * 0.042,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}
