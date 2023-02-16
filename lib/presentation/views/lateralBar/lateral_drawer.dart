import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/repository/userRepository.dart';
import 'package:reality_near/domain/entities/user.dart';
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
    {'icon': 'assets/icons/wallet_icon.svg', 'text': 'Wallet', 'path': ''},
    {
      'icon': 'assets/icons/social_icon.svg',
      'text': 'Reality Social',
      'path': '/RealitySocial'
    },
    {'icon': 'assets/icons/info_icon.svg', 'text': 'Eventos', 'path': ''},
    {
      'icon': 'assets/icons/juegos_icon.svg',
      'text': 'Minijuegos',
      'path': '/miniGames'
    },
    {
      'icon': 'assets/icons/config_icon.svg',
      'text': 'Configuración',
      'path': ''
    },
  ];
  User user;
  bool loading = true;
  getUserData() async {
    bool _CurrentUserComplete = await getPreference('username') != null &&
        await getPreference('usAvatar') != null &&
        await getPreference('userId') != null;
    if (_CurrentUserComplete) {
      String _fullName = await getPreference('username');
      String _avatar = await getPreference('usAvatar');
      int _id = int.parse(await getPreference('userId'));

      user = User(
        id: _id,
        fullName: _fullName,
        avatar: _avatar,
      );
      loading = false;
    } else {
      await UserRepository().getMyData().then((value) => value.fold(
            (failure) => print(failure),
            (success) => {
              success.avatar.isEmpty
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NoAvatarScreen(
                                user: success,
                              )),
                    )
                  : {
                      setPreference('username', success.fullName),
                      setPreference('userId', success.id.toString()),
                      user = success,
                      setPreference('usAvatar', user.avatar),
                      loading = false
                    }
            },
          ));
    }
  }

  @override
  void initState() {
    getUserData().then((value) => setState(() {}));
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
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: greenPrimary.withOpacity(0.2),
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
                    fontSize: getResponsiveText(context, 19),
                    color: txtPrimary,
                    fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            for (var i = 0; i < menuOptions.length; i++)
              ListTile(
                horizontalTitleGap: 10,
                minLeadingWidth: 10,
                leading: SvgPicture.asset(
                  menuOptions[i]['icon'],
                  height: MediaQuery.of(context).size.height * 0.04,
                  color: greenPrimary,
                ),
                title: Text(
                  menuOptions[i]['text'],
                  style: GoogleFonts.sourceSansPro(
                      fontSize: getResponsiveText(context, 16),
                      color: txtPrimary,
                      fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.pushNamed(context, menuOptions[i]['path']);
                },
              ),
            const Spacer(),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/logout_icon.svg',
                height: MediaQuery.of(context).size.height * 0.04,
                color: greenPrimary,
              ),
              title: Text(
                'Cerrar Sesión',
                style: GoogleFonts.sourceSansPro(
                    fontSize: getResponsiveText(context, 16),
                    color: txtPrimary,
                    fontWeight: FontWeight.w600),
              ),
              onTap: () {
                BlocProvider.of<UserBloc>(context, listen: false)
                    .add(UserLogOutEvent());
                Navigator.pushNamedAndRemoveUntil(
                    context, '/firstScreen', ModalRoute.withName('/'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
