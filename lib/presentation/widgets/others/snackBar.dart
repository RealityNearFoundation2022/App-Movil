import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';

SnackBar rnSnackBar(String message, bool isError) {
  return SnackBar(
    content: Text(
      message,
      textAlign: TextAlign.center,
      style: GoogleFonts.sourceSansPro(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
    duration: const Duration(seconds: 3),
    backgroundColor: isError ? Colors.red :greenPrimary,
    elevation: 30,
  );
}

 showSnackBar(BuildContext context, String message, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(
      rnSnackBar(message, isError),
    );
  }
