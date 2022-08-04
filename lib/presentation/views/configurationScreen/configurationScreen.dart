import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/bloc/user/user_bloc.dart';
import 'package:reality_near/presentation/views/FriendsScreen/friendsScreen.dart';
import 'package:reality_near/presentation/views/configurationScreen/widgets/permisosDialog.dart';
import 'package:reality_near/presentation/views/informationScreen/infoScreen.dart';
import 'package:reality_near/presentation/views/userScreen/userScreen.dart';
import 'package:reality_near/presentation/views/walletScreen/walletScreen.dart';
import 'package:sizer/sizer.dart';

class ConfigurationScreen extends StatefulWidget {
  //Variables
  static String routeName = "/configScreen";
  const ConfigurationScreen({Key key}) : super(key: key);

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  bool isExpanded = false;
  String walletId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPersistData('walletId').then((value) => {
          if (value != null)
            {
              setState(() {
                walletId = value;
              })
            }
        });
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
            S.current.Configuracion,
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
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpansionMenu(context),
          GestureDetector(
              onTap: (() {
                showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return const PermisosDialog();
                    });
              }),
              child: textAndIcon(S.current.Permisos, null)),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(InfoScreen.routeName);
            },
            child: textAndIcon(S.current.Informacion, null),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.only(
                bottom: 25,
                right: 25,
              ),
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<UserBloc>(context, listen: false)
                      .add(UserLogOutEvent());
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/firstScreen', ModalRoute.withName('/'));
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                      color: greenPrimary,
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget ExpansionMenu(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: ScreenWH(context).width * 0.4,
          child: Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              collapsedTextColor: greenPrimary,
              textColor: greenPrimary,
              onExpansionChanged: (bool value) {
                setState(() {
                  isExpanded = value;
                });
              },
              trailing: Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_right_rounded,
                color: greenPrimary,
                size: 35,
              ),
              childrenPadding: const EdgeInsets.only(right: 15),
              title: Text(
                S.current.Cuenta,
                style: GoogleFonts.sourceSansPro(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: greenPrimary,
                ),
              ),
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(userScreen.routeName);
                    },
                    child: txtSubMenu(S.current.Usuario)),
                walletId.isEmpty
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, WalletScreen.routeName),
                        child: txtSubMenu(S.current.Wallet)),
                GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, FriendScreen.routeName),
                    child: txtSubMenu(S.current.Amigos))
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget txtSubMenu(String txt) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.all(5.0),
      child: Text(
        txt,
        style: GoogleFonts.sourceSansPro(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black54),
      ),
    );
  }

  Widget textAndIcon(String text, IconData icon) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              text,
              style: GoogleFonts.sourceSansPro(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: greenPrimary,
              ),
            ),
            icon != null
                ? Icon(
                    icon,
                    size: 20.sp,
                    color: greenPrimary,
                  )
                : const SizedBox(
                    width: 15,
                  ),
          ],
        ),
      );
    });
  }
}
