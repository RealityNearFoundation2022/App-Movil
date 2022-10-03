import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/models/cuponModel.dart';
import 'package:reality_near/domain/usecases/cuppons/getCuponsWithId.dart';

import '../../../generated/l10n.dart';

class QrViewScreen extends StatefulWidget {
  static String routeName = "/qrViewScreen";
  const QrViewScreen({Key key}) : super(key: key);

  @override
  State<QrViewScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrViewScreen> {

  bool _loadingInfoCupon = true;
  CuponModel cupon = CuponModel();

  _getInfoCupon(String cuponId) async {
    await GetCuponsWithIdUseCase(cuponId).call().then((value) =>
        setState(() {
          cupon = value;
          _loadingInfoCupon = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    if(cupon.id ==null) _getInfoCupon(args['cuponId'].toString());

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
        body: _loadingInfoCupon ? loadScreen() : _body());
  }

  loadScreen(){
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LoadingAnimationWidget.dotsTriangle(
            color: greenPrimary,
            size: ScreenWH(context).width * 0.3,
          ),
          const SizedBox(height: 20),
          Text(
            S.current.Cargando,
            style: GoogleFonts.sourceSansPro(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
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
              cupon.title,
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
          // Center(
          //   child: _partnerInfo(),
          // ),
          SizedBox(
            height: ScreenWH(context).height * 0.03,
          ),
          _infoSection('Descripción', cupon.description),
          SizedBox(
            height: ScreenWH(context).height * 0.02,
          ),
          _infoSection('Terminos y Condiciónes', cupon.terms),
          // SizedBox(
          //   height: ScreenWH(context).height * 0.02,
          // ),
          // SizedBox(
          //   width: ScreenWH(context).width * 0.9,
          //   child: Text(
          //     'Válido hasta el ${cupon.expiration.day}/${cupon.expiration.month}/${cupon.expiration.year}',
          //     textAlign: TextAlign.center,
          //     style: GoogleFonts.sourceSansPro(
          //       fontSize: 14,
          //       fontWeight: FontWeight.w600,
          //       color: greenPrimary2,
          //     ),
          //   ),
          // ),
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

  Future<String> _getOwnerId()async{
    return await getPersistData("userId");
  }

  _qrGenerator() {
    return Center(
        child: FutureBuilder<String>(
          future: _getOwnerId(),
          builder: (context, snapshot){
            String owner = snapshot.data;
            if(snapshot.hasData){
              return QrImage(
                data: cupon.id.toString() + ' | ' + owner,
                foregroundColor: greenPrimary,
                version: QrVersions.auto,
                size: ScreenWH(context).width * 0.5,
              );
            }
            return LoadingAnimationWidget.dotsTriangle(
              color: greenPrimary,
              size: ScreenWH(context).width * 0.3,
            );
          },
        )
    );
  }
}
