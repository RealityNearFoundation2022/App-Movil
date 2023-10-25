import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/walletScreen/receiveScreen.dart';
import 'package:reality_near/presentation/views/walletScreen/transferScreen.dart';
import 'package:reality_near/presentation/views/walletScreen/widgets/tabMovesNFTs.dart';
import 'package:reality_near/presentation/views/walletScreen/widgets/tab_cupons_features.dart';

import '../../bloc/user/user_bloc.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                constraints: const BoxConstraints(
                    maxHeight: 50, maxWidth: 200, minHeight: 50, minWidth: 200),
                onPressed: () {
                  BlocProvider.of<UserBloc>(context, listen: false)
                      .add(UserLoginWalletEvent(context));
                },
                icon: SvgPicture.asset(
                  'assets/icons/near_logo_complete.svg',
                  color: const Color(0xFF555555),
                  height: MediaQuery.of(context).size.height * 0.030,
                  width: MediaQuery.of(context).size.height * 0.090,
                )),
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
