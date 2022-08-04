import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';

class QrViewScreen extends StatefulWidget {
  static String routeName = "/qrViewScreen";
  const QrViewScreen({Key key}) : super(key: key);

  @override
  State<QrViewScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrViewScreen> {
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
              'Cupón QR',
              style: GoogleFonts.sourceSansPro(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: greenPrimary,
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: greenPrimary, size: 35),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: _body());
  }

  _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          SizedBox(
            height: ScreenWH(context).height * 0.01,
          ),
          SizedBox(
            width: ScreenWH(context).width * 0.9,
            child: Text(
              '50% de descuento en entrenamientos por 1 mes',
              textAlign: TextAlign.center,
              style: GoogleFonts.sourceSansPro(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: greenPrimary2,
              ),
            ),
          ),
          SizedBox(
            height: ScreenWH(context).height * 0.03,
          ),
          _qrGenerator(),
          SizedBox(
            height: ScreenWH(context).height * 0.01,
          ),
          Center(
            child: _partnerInfo(),
          ),
          SizedBox(
            height: ScreenWH(context).height * 0.03,
          ),
          _infoSection('Descripción', loremIpsum),
          SizedBox(
            height: ScreenWH(context).height * 0.02,
          ),
          _infoSection('Terminos y Condiciónes', loremIpsum),
          SizedBox(
            height: ScreenWH(context).height * 0.05,
          ),
        ],
      ),
    );
  }

  _partnerInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/imgs/logo_lutaLivre.jpeg",
          width: ScreenWH(context).width * 0.1,
          height: ScreenWH(context).width * 0.1,
        ),
        SizedBox(
          width: ScreenWH(context).width * 0.02,
        ),
        Text(
          'Luta Livre',
          textAlign: TextAlign.center,
          style: GoogleFonts.sourceSansPro(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: txtPrimary,
          ),
        ),
      ],
    );
  }

  _infoSection(String title, String info) {
    return Column(
      children: [
        SizedBox(
          width: ScreenWH(context).width * 0.9,
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: GoogleFonts.sourceSansPro(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: greenPrimary2,
            ),
          ),
        ),
        SizedBox(
          height: ScreenWH(context).height * 0.02,
        ),
        SizedBox(
          width: ScreenWH(context).width * 0.9,
          child: Text(
            info,
            textAlign: TextAlign.left,
            style: GoogleFonts.sourceSansPro(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: txtPrimary,
            ),
          ),
        ),
      ],
    );
  }

  _qrGenerator() {
    return Center(
      child: QrImage(
        data: "1234567890",
        foregroundColor: greenPrimary,
        version: QrVersions.auto,
        size: ScreenWH(context).width * 0.5,
      ),
    );
  }
}
