import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:reality_near/core/framework/colors.dart';

class QrScannScreen extends StatefulWidget {
  static String routeName = "/qrScannScreen";

  const QrScannScreen({Key key}) : super(key: key);

  @override
  State<QrScannScreen> createState() => _QrScannScreenState();
}

class _QrScannScreenState extends State<QrScannScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

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
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Container(
            padding: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: greenPrimary,
              border: Border.all(
                color: greenPrimary,
                width: 4,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: QRView(
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
              ),
            ),
          ),
          Center(
            child: (result != null)
                ? Text(
                    'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}')
                : Text('Scan a code'),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }
}
