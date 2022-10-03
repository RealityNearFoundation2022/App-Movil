import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/datasource/nearRPC/contracts.dart';
import 'package:reality_near/data/models/nftModel.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/walletScreen/receiveScreen.dart';
import 'package:reality_near/presentation/views/walletScreen/transferScreen.dart';
import 'package:reality_near/presentation/views/walletScreen/widgets/tabMovesNFTs.dart';
import 'package:sizer/sizer.dart';

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
    // TODO: implement initState
    super.initState();
    //obtener balance de wallet
    ContractRemoteDataSourceImpl().getMyBalance().then((value) => setState(() {
          walletBalance = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
          margin: const EdgeInsets.only(right: 10),
          alignment: Alignment.centerRight,
          child: Text(
            S.current.Wallet,
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
                    "$walletBalance",
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: txtPrimary,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Text(
                "\$ 140",
                style: GoogleFonts.sourceSansPro(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: txtPrimary,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Buttons(S.current.Transferir, greenPrimary, context, () {
                  Navigator.of(context).pushNamed(TransferScreen.routeName);
                }),
                Buttons(S.current.Recibir, Colors.black45, context, () {
                  Navigator.of(context)
                      .pushNamed(ReceiveScreen.routeName, arguments: {
                    "walletId": "walletUsuario.near",
                  });
                }),
              ],
            ),
            TabMovesNFTs()
          ],
        ),
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
