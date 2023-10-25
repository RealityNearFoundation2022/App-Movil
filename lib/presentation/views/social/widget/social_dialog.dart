// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';

class SocialDetailDialog extends StatefulWidget {
  const SocialDetailDialog({
    Key key,
  }) : super(key: key);

  @override
  State<SocialDetailDialog> createState() => _SocialDetailDialogState();
}

class _SocialDetailDialogState extends State<SocialDetailDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      insetPadding: const EdgeInsets.symmetric(vertical: 10),
      insetAnimationCurve: Curves.easeInOut,
      insetAnimationDuration: const Duration(milliseconds: 500),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/imgs/imgAlfaTest.png"),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: greenSoft.withOpacity(0.8),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset(
                    "assets/gift/MEN_SELECTED.gif",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              FittedBox(
                fit: BoxFit.fitHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Name',
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Hace 1 hora',
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: txtGrey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Icon(
                FontAwesomeIcons.heart,
                color: greenPrimary,
                size: MediaQuery.of(context).size.height * 0.27 / 8,
              ),
            ],
          )),
    );
  }
}
