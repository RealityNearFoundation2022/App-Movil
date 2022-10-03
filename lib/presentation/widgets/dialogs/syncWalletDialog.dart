import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/bloc/user/user_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../core/helper/url_constants.dart';

class SyncWalletDialog extends StatefulWidget {
  SyncWalletDialog({Key key, this.onLogin}) : super(key: key);
  Function onLogin;
  @override
  State<SyncWalletDialog> createState() => _SyncWalletDialogState();
}

class _SyncWalletDialogState extends State<SyncWalletDialog> {
  bool pressNo = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: pressNo
                ? _noSync(context)
                : Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          S.current.PvinecularNearWallet,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sourceSansPro(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: txtPrimary),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            button(
                                S.current.Si,
                                () => //creamos un evento en el bloc
                                    BlocProvider.of<UserBloc>(context,
                                            listen: false)
                                        .add(UserLoginWalletEvent(context, '')),
                                greenPrimary),
                            button(S.current.No, () {
                              setState(() {
                                pressNo = true;
                              });
                            }, Colors.grey),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: S.current.noTienesUna,
                                style: GoogleFonts.sourceSansPro(
                                  fontSize: 16,
                                  color: Colors.grey[400],
                                ),
                                children: [
                                  TextSpan(
                                    text: S.current.CreaUna,
                                    style: GoogleFonts.sourceSansPro(
                                        fontSize: 16,
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.w600),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => launchUrlString(
                                          REGISTER_NEAR_WALLET,
                                          mode: LaunchMode.externalApplication),
                                  ),
                                ])),
                      ),
                    ],
                  ),
          ),
        ));
  }

  Widget _noSync(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Text(
            S.current.NoRegistraWalletTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.sourceSansPro(
                fontWeight: FontWeight.w700, fontSize: 18, color: txtPrimary),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Text(
            S.current.NoRegistraWalletDesc1,
            textAlign: TextAlign.center,
            style: GoogleFonts.sourceSansPro(
                fontWeight: FontWeight.w500, fontSize: 14, color: txtPrimary),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Text(
            S.current.NoRegistraWalletDesc2,
            textAlign: TextAlign.center,
            style: GoogleFonts.sourceSansPro(
                fontWeight: FontWeight.w500, fontSize: 14, color: txtPrimary),
          ),
        ),
        const SizedBox(height: 10),
        button(S.current.Confirmar, () {
          widget.onLogin();
        }, Colors.grey),
      ],
    );
  }

  Widget button(String text, Function press, Color color) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        primary: Colors.white,
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 30),
      ),
      child: Text(
        text,
        style: GoogleFonts.notoSansJavanese(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      onPressed: () async {
        press();
      },
    );
  }
}
