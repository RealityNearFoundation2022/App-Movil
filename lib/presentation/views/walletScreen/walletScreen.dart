import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/presentation/views/walletScreen/widgets/tabMovesNFTs.dart';

class WalletScreen extends StatefulWidget {
  static String routeName = "/wallet";

  const WalletScreen({Key key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
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
            "Wallet",
            style: GoogleFonts.sourceSansPro(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: greenPrimary2,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: greenPrimary2, size: 35),
        leading: IconButton(
          padding: const EdgeInsets.only(left: 35),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "0.00",
                style: GoogleFonts.sourceSansPro(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: greenPrimary2,
                ),
              ),
            ),
            Text(
              "Realities",
              style: GoogleFonts.sourceSansPro(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: greenPrimary2,
              ),
            ),
            TabMovesNFTs()
          ],
        ),
      ),
    );
  }
}
