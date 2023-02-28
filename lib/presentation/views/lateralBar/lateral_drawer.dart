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
  final List<Map<String, String>> menuOptions = [
    {
      'icon': 'assets/icons/profile_icon.svg',
      'text': 'Mi Perfil',
      'path': '/ProfileScreen'
    },
    {
      'icon': 'assets/icons/wallet_icon.svg',
      'text': 'Wallet',
      'path': '/wallet'
    },
    // {
    //   'icon': 'assets/icons/social_icon.svg',
    //   'text': 'Reality Social',
    //   'path': '/RealitySocial'
    // },
    // {'icon': 'assets/icons/info_icon.svg', 'text': 'Eventos', 'path': ''},
    // {
    //   'icon': 'assets/icons/juegos_icon.svg',
    //   'text': 'Minijuegos',
    //   'path': '/miniGames'
    // },
    {
      'icon': 'assets/icons/config_icon.svg',
      'text': 'Configuración',
      'path': '/configScreen'
    },
  ];
  User user;
  bool loading = true;

  @override
  void initState() {
    // UserData().then((value) => setState(() {}));
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
                loading ? 'Cargando...' : loremIpsum.substring(0, 10),
                style: GoogleFonts.sourceSansPro(
                    fontSize: getResponsiveText(context, 22),
                    color: txtPrimary,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            for (var i = 0; i < menuOptions.length; i++)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, menuOptions[i]['path']);
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: menuOptions[i]['icon'] ==
                                "assets/icons/config_icon.svg"
                            ? const EdgeInsets.only(left: 3.0)
                            : const EdgeInsets.all(0),
                        child: SvgPicture.asset(
                          menuOptions[i]['icon'],
                          height: menuOptions[i]['icon'] ==
                                  "assets/icons/config_icon.svg"
                              ? MediaQuery.of(context).size.height * 0.035
                              : MediaQuery.of(context).size.height * 0.04,
                          color: greenPrimary,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          menuOptions[i]['text'],
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
                      title: Text(
                        'Cerrar Sesión',
                        style: GoogleFonts.sourceSansPro(
                            fontSize: getResponsiveText(context, 16),
                            color: txtPrimary,
                            fontWeight: FontWeight.w400),
                      ),
                      content: Text(
                        '¿Estás seguro que deseas cerrar sesión?',
                        style: GoogleFonts.sourceSansPro(
                            fontSize: getResponsiveText(context, 16),
                            color: txtPrimary,
                            fontWeight: FontWeight.w600),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancelar',
                            style: GoogleFonts.sourceSansPro(
                                fontSize: getResponsiveText(context, 16),
                                color: txtPrimary,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextButton(
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
                                color: greenPrimary,
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
                      padding: const EdgeInsets.all(0),
                      child: SvgPicture.asset(
                        'assets/icons/logout_icon.svg',
                        height: MediaQuery.of(context).size.height * 0.04,
                        color: greenPrimary,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
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
