import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';

class AppButton extends StatelessWidget {
  final String label;
  final double width;
  final double height;
  final Color colorDefault;
  final Color borderColorDefault;
  final Color textColor;
  final VoidCallback onPressed;
  final double radius;
  // ignore: use_key_in_widget_constructors
  const AppButton({
    this.label,
    this.width,
    this.colorDefault = greenPrimary,
    this.borderColorDefault = Colors.transparent,
    this.textColor = Colors.white,
    this.height = 50,
    this.onPressed,
    this.radius = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          color: colorDefault,
          border: Border.all(color: borderColorDefault, width: 3)),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          onTap: onPressed,
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.sourceSansPro(
                  fontSize: getResponsiveText(context, 16),
                  color: Colors.white,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }
}
