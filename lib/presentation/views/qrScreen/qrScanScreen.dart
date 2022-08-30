import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/domain/usecases/cuppons/redeemCupon.dart';
import 'package:reality_near/generated/l10n.dart';

import '../../../data/models/cuponAssignModel.dart';

class QrScannScreen extends StatefulWidget {
  static String routeName = "/qrScannScreen";

  const QrScannScreen({Key key}) : super(key: key);

  @override
  State<QrScannScreen> createState() => _QrScannScreenState();
}

class _QrScannScreenState extends State<QrScannScreen> {
  AssignCuponModel cupon = AssignCuponModel();
  bool _loadingValidate = false;
  String errorMessage = "";
  _redeemCupon() async {
    setState(() {
      _loadingValidate = true;
    });
    String cuponId = result.code.split(' | ')[0];
    String ownerId = result.code.split(' | ')[1];
    await RedeemCuponUseCase(cuponId,ownerId).call().then((value) => value.fold(
        (l) => {
          setState(() {
            _loadingValidate = false;
            errorMessage= S.current.CuponInvalido;
          }),
        },
        (r) => {
          setState(() {
                cupon = r;
                _loadingValidate = false;
              })
            }));
  }
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

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
            'Scaner QR',
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: errorMessage.isEmpty ? greenPrimary : Colors.red,
              border: Border.all(
                color: errorMessage.isEmpty ? greenPrimary : Colors.red,
                width: 4,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: result == null ? _qrScan()
                  : _loadingValidate ? _qrValidateLoading()
              : _validateScreen(cupon.redeemed??false),
              // child: _qrValidateLoading(),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Center(
            child: SizedBox(
              width: ScreenWH(context).width * 0.9,
              child: Text(
                result == null
                    ? 'Enfoca el codigo QR para validar'
                    : _loadingValidate ? 'Validando...'
                    : errorMessage.isNotEmpty ? errorMessage :'',
                // 'Validando...',
                textAlign: TextAlign.center,
                style: GoogleFonts.sourceSansPro(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: errorMessage.isEmpty ? greenPrimary2 : Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _qrValidateLoading() {
    return Container(
      alignment: Alignment.center,
      child: LoadingAnimationWidget.dotsTriangle(
        color: Colors.white,
        size: ScreenWH(context).width * 0.3,
      ),
    );
  }

  _validateScreen(bool isValidate ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: ScreenWH(context).height * 0.01,
        ),
        Container(
          width: ScreenWH(context).width * 0.4,
          height: ScreenWH(context).width * 0.4,
          //circle
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
          ),
          child: Icon(
            isValidate ? Icons.check : Icons.close,
            color: isValidate ? greenPrimary : Colors.red,
            size: ScreenWH(context).width * 0.2,
          ),
        ),
        SizedBox(
          height: ScreenWH(context).height * 0.05,
        ),
        SizedBox(
          width: ScreenWH(context).width * 0.8,
          child: Text(
            isValidate ? 'Valido' : 'No valido',
            textAlign: TextAlign.center,
            style: GoogleFonts.sourceSansPro(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  _qrScan() {
    return QRView(
      overlay: QrScannerOverlayShape(
        borderColor: greenPrimary,
        borderRadius: 20,
        borderLength: 30,
        borderWidth: 10,
        // cutOutSize: 300,
      ),
      overlayMargin: const EdgeInsets.all(40),
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {

      setState(() {
        print('Scanned data: ${scanData.code}');
        result = scanData;
      });
      _redeemCupon();
    });
  }
}
