// import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/generated/l10n.dart';

class ReceiveScreen extends StatefulWidget {
  ReceiveScreen({Key key}) : super(key: key);
  static String routeName = "/receive";

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> {
  String _walletAddress = "";

  bool _loading = true;

  _getWalletAddress() async {
    getPreference('walletId').then((value) {
      setState(() {
        _walletAddress = value;
        _loading = false;
      });
    });
  }

  @override
  initState() {
    super.initState();
    _getWalletAddress();
  }

  @override
  Widget build(BuildContext context) {
    Widget copyConfirm() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            S.current.copyClip,
            textAlign: TextAlign.center,
            style: GoogleFonts.sourceSansPro(),
          ),
          duration: const Duration(milliseconds: 1500),
          width: 180.0, // Width of the SnackBar.
          padding: const EdgeInsets.all(
            8.0,
          ), // Inner padding for SnackBar content.
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          margin: const EdgeInsets.only(right: 10),
          alignment: Alignment.centerRight,
          child: Text(
            S.current.Recibir + ' Realities',
            style: GoogleFonts.sourceSansPro(
              fontSize: 30,
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
      body: Center(
        child: _loading
            ? LoadingAnimationWidget.dotsTriangle(
                color: greenPrimary,
                size: ScreenWH(context).width * 0.3,
              )
            : SizedBox(
                width: ScreenWH(context).width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 80,
                      child: Center(
                        child: Text(
                          _walletAddress,
                          style: GoogleFonts.sourceSansPro(
                              fontSize: 24,
                              color: txtPrimary,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    // DottedBorder(
                    //     borderType: BorderType.RRect,
                    //     color: txtPrimary,
                    //     dashPattern: const [12],
                    //     strokeWidth: 2,
                    //     child: SizedBox(
                    //       height: 80,
                    //       child: Center(
                    //         child: Text(
                    //           _walletAddress,
                    //           style: GoogleFonts.sourceSansPro(
                    //               fontSize: 24,
                    //               color: txtPrimary,
                    //               fontWeight: FontWeight.w700),
                    //         ),
                    //       ),
                    //     )),
                    const SizedBox(height: 20),
                    Text(
                      S.current.reciveDescrip,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 18,
                          color: txtPrimary,
                          fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            //copy to clipboard
                            Clipboard.setData(
                                ClipboardData(text: _walletAddress));
                            copyConfirm();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(greenPrimary),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(horizontal: 30)),
                          ),
                          child: Text(
                            S.current.Copiar,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        // IconButton(
                        //   icon: const Icon(Icons.share_outlined,
                        //       color: icongrey, size: 35),
                        //   onPressed: () => Navigator.of(context).pop(),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
