import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/datasource/nearRPC/contracts.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/bloc/user/user_bloc.dart';
import 'package:reality_near/presentation/views/FriendsScreen/friendsScreen.dart';
import 'package:reality_near/presentation/views/configurationScreen/configurationScreen.dart';
import 'package:reality_near/presentation/views/userProfile/profile_screen.dart';
import 'package:reality_near/presentation/views/walletScreen/walletScreen.dart';
import 'package:reality_near/presentation/widgets/dialogs/syncWalletDialog.dart';
import 'package:sizer/sizer.dart';

class MenuPrincSection extends StatefulWidget {
  const MenuPrincSection({Key key}) : super(key: key);

  @override
  State<MenuPrincSection> createState() => _MenuPrincSectionState();
}

class _MenuPrincSectionState extends State<MenuPrincSection> {
  String username = '';
  double walletBalance = 0;
  String walletId = "";
  String usAvatar = "";

  @override
  void initState() {
    super.initState();
    getPersistData('username').then((value) => {
          setState(() {
            username = value;
          })
        });

    getPersistData('usAvatar').then((value) => {
          if (value != null)
            {
              setState(() {
                usAvatar = value;
              })
            }
        });

    getPersistData('walletId').then((value) => {
          if (value != null)
            {
              //obtener balance de wallet
              ContractRemoteDataSourceImpl()
                  .getMyBalance()
                  .then((value) => setState(() {
                        walletBalance = value;
                      })),
              setState(() {
                walletId = value;
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [topSection(context), bottomSection(context)]);
    });
  }

  Widget topSection(BuildContext context) {
    return Column(children: [
      Align(alignment: Alignment.centerRight, child: personCircle()),
      Align(
        alignment: Alignment.centerRight,
        child: Text(
          username ?? 'noUser',
          style: GoogleFonts.sourceSansPro(
              fontSize: 33.sp, color: txtPrimary, fontWeight: FontWeight.w800),
        ),
      ),
      walletId.isNotEmpty
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 13.0,
                  backgroundImage:
                      AssetImage("assets/imgs/RealityIconCircle.png"),
                ),
                const SizedBox(width: 5),
                Text(
                  '$walletBalance',
                  style: GoogleFonts.sourceSansPro(
                      fontSize: 33.sp,
                      color: txtPrimary,
                      fontWeight: FontWeight.w500),
                ),
              ],
            )
          : const SizedBox(),
      Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, FriendScreen.routeName);
          },
          child: Text(
            S.current.Amigos,
            style: GoogleFonts.sourceSansPro(
                fontSize: 33.sp,
                color: txtPrimary,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
      walletId.isNotEmpty
          ? Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, WalletScreen.routeName);
                },
                child: Text(
                  S.current.Wallet,
                  style: GoogleFonts.sourceSansPro(
                      fontSize: 33.sp,
                      color: txtPrimary,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          : const SizedBox(),
    ]);
  }

  Widget personCircle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(ProfileScreen.routeName);
        },
        child: CircleAvatar(
          radius: 27.w,
          child: usAvatar.isNotEmpty
              ? Image.asset(
                  usAvatar,
                  fit: BoxFit.cover,
                )
              : Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                    color: Colors.white,
                    size: ScreenWH(context).width * 0.2,
                  ),
                ),
        ),
      ),
    );
  }

  Widget bottomSection(BuildContext context) {
    return Column(
      children: [
        walletId.isEmpty
            ? Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => SyncWalletDialog(
                              onLogin: () {
                                Navigator.pop(context);
                              },
                            ));
                  },
                  child: Text(
                    S.current.SyncWallet,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 33.sp,
                        color: txtPrimary,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )
            : const SizedBox(),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ConfigurationScreen.routeName);
                },
                child:
                    const Icon(Icons.settings, color: greenPrimary3, size: 35)),
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<UserBloc>(context, listen: false)
                            .add(UserLogOutEvent());
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/firstScreen', ModalRoute.withName('/'));
                      },
                      child: Text(
                        'Logout',
                        style: GoogleFonts.sourceSansPro(
                            color: greenPrimary3,
                            fontWeight: FontWeight.w700,
                            fontSize: 33.sp),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
