import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/walletScreen/widgets/tab_cupons_features.dart';

class WalletScreen extends StatefulWidget {
  static String routeName = "/wallet";

  const WalletScreen({Key key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double walletBalance = 0;
  @override
  void initState() {
    super.initState();
    //obtener balance de wallet
    // ContractRemoteDataSourceImpl().getMyBalance().then((value) => setState(() {
    //       walletBalance = value;
    //     }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalApppBar(context, S.current.Wallet),
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: ScreenWH(context).width,
        height: ScreenWH(context).height,
        child: const TabCuponsFeatures(),
      ),
    );
  }

  Widget Buttons(
      String text, Color color, BuildContext context, Function funcOnPress) {
    return GestureDetector(
      onTap: () {
        funcOnPress();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7),
        width: ScreenWH(context).width * 0.4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: color),
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Center(
            child: Text(text,
                style: GoogleFonts.sourceSansPro(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600))),
      ),
    );
  }
}
