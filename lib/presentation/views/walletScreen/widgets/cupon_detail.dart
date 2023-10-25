import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:reality_near/core/framework/globals.dart';

class CuponDetail extends StatelessWidget {
  final String heroTag;
  final Color backGroungColor;
  const CuponDetail({Key key, this.heroTag, this.backGroungColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: Scaffold(
        backgroundColor: backGroungColor,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: ScreenWH(context).height * 0.1,
                ),
                SvgPicture.asset(
                  'assets/icons/logo.svg',
                  color: Colors.white,
                  height: ScreenWH(context).height * 0.2,
                ),
                SizedBox(
                  height: ScreenWH(context).height * 0.03,
                ),
                Text(
                  '10% OFF',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.sourceSansPro(
                    fontSize: getResponsiveText(context, 24),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: ScreenWH(context).height * 0.03,
                ),
                Text(
                  'Luta Livre',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.sourceSansPro(
                    fontSize: getResponsiveText(context, 14),
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '1 JUN - 30 JUN 2023',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.sourceSansPro(
                    fontSize: getResponsiveText(context, 14),
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: ScreenWH(context).height * 0.03,
                ),
                Text(
                  loremIpsum.substring(0, 300),
                  textAlign: TextAlign.left,
                  style: GoogleFonts.sourceSansPro(
                    fontSize: getResponsiveText(context, 14),
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: ScreenWH(context).height * 0.03,
                ),
                _qrGenerator(context),
                SizedBox(
                  height: ScreenWH(context).height * 0.05,
                ),
                // x icon button
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.13,
                    width: MediaQuery.of(context).size.width * 0.13,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenWH(context).height * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _qrGenerator(BuildContext context) {
    return QrImageView(
      data: 'example',
      foregroundColor: Colors.white,
      version: QrVersions.auto,
      size: ScreenWH(context).width * 0.6,
    );
  }
}
