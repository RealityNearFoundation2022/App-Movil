import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/generated/l10n.dart';
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
            S.current.Wallet,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/iconLogo.png"),
                  radius: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  child: Text(
                    "1452.64451",
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: greenPrimary2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Buttons(S.current.Transferir, greenPrimary, context),
                Buttons(S.current.Recibir, Colors.black45, context),
              ],
            ),
            TabMovesNFTs()
          ],
        ),
      ),
    );
  }

  Widget Buttons(String text, Color color, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7),
      width: ScreenWH(context).width * 0.4,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(30), color: color),
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Center(
          child: Text(text,
              style: GoogleFonts.sourceSansPro(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600))),
    );
  }
}
