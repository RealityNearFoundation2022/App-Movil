import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/repository/user_repository.dart';
import 'package:reality_near/domain/entities/user.dart';
import 'package:reality_near/domain/usecases/user/user_data.dart';
import 'package:reality_near/presentation/bloc/user/user_bloc.dart';
import 'package:reality_near/presentation/views/login/no_avatar_screen.dart';

class LateralDrawer extends StatefulWidget {
  const LateralDrawer({Key key}) : super(key: key);

  @override
  State<LateralDrawer> createState() => _LateralDrawerState();
}

class _LateralDrawerState extends State<LateralDrawer> {
  //List of Map<String, String> with the menu options

  User user;
  bool loading = true;

  @override
  void initState() {
    UserData(context).get().then((value) => setState(() {
          user = value;
          loading = false;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //lateral bar drawer with user data and list menus
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.6,
      backgroundColor: Colors.white,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).viewPadding.top + 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.width * 0.35,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: greenSoft,
              ),
              child: loading
                  ? LoadingAnimationWidget.dotsTriangle(
                      color: greenPrimary,
                      size: ScreenWH(context).width * 0.2,
                    )
                  : Image.asset(user.avatar),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                loading ? 'Cargando...' : user.fullName,
                style: GoogleFonts.sourceSansPro(
                    fontSize: getResponsiveText(context, 22),
                    color: txtPrimary,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/ProfileScreen');
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: SvgPicture.asset(
                        "assets/icons/profile_icon.svg",
                        height: MediaQuery.of(context).size.height * 0.042,
                        color: greenPrimary,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Mi Perfil',
                        style: GoogleFonts.sourceSansPro(
                            fontSize: getResponsiveText(context, 16),
                            color: txtPrimary,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/wallet');
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: SvgPicture.asset(
                        "assets/icons/wallet_icon.svg",
                        height: MediaQuery.of(context).size.height * 0.042,
                        color: greenPrimary,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Wallet',
                        style: GoogleFonts.sourceSansPro(
                            fontSize: getResponsiveText(context, 16),
                            color: txtPrimary,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/configScreen');
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: SvgPicture.asset(
                        "assets/icons/info_icon.svg",
                        height: MediaQuery.of(context).size.height * 0.03,
                        color: greenPrimary,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13.0),
                      child: Text(
                        'About',
                        style: GoogleFonts.sourceSansPro(
                            fontSize: getResponsiveText(context, 16),
                            color: txtPrimary,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      title: Text(
                        'Cerrar Sesión',
                        style: GoogleFonts.sourceSansPro(
                            fontSize: getResponsiveText(context, 16),
                            color: txtPrimary,
                            fontWeight: FontWeight.bold),
                      ),
                      content: Text(
                        '¿Estás seguro que deseas cerrar sesión?',
                        style: GoogleFonts.sourceSansPro(
                            fontSize: getResponsiveText(context, 16),
                            color: txtPrimary,
                            fontWeight: FontWeight.w400),
                      ),
                      // actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.25),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancelar',
                            style: GoogleFonts.sourceSansPro(
                                fontSize: getResponsiveText(context, 16),
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: greenPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            BlocProvider.of<UserBloc>(context, listen: false)
                                .add(UserLogOutEvent());
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/firstScreen', (route) => false);
                          },
                          child: Text(
                            'Aceptar',
                            style: GoogleFonts.sourceSansPro(
                                fontSize: getResponsiveText(context, 16),
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 1),
                      child: SvgPicture.asset(
                        'assets/icons/logout_icon.svg',
                        height: MediaQuery.of(context).size.height * 0.033,
                        color: greenPrimary,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13.0),
                      child: Text(
                        'Cerrar Sesión',
                        style: GoogleFonts.sourceSansPro(
                            fontSize: getResponsiveText(context, 16),
                            color: txtPrimary,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).viewPadding.bottom + 10,
            ),
          ],
        ),
      ),
    );
  }
}
