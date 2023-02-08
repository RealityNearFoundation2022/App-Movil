import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/repository/userRepository.dart';
import 'package:reality_near/domain/entities/user.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/bloc/user/user_bloc.dart';
import 'package:reality_near/presentation/widgets/others/snackBar.dart';

class NoAvatarScreen extends StatefulWidget {
  User user;
  NoAvatarScreen({Key key, this.user}) : super(key: key);

  @override
  State<NoAvatarScreen> createState() => _NoAvatarScreenState();
}

class _NoAvatarScreenState extends State<NoAvatarScreen> {
//Variables

  List<bool> avatarSelect = [false, false, false];
  List<String> pathAvatarSelected = [
    "assets/gift/MEN_SELECTED.gif",
    "assets/gift/WOMEN_SELECT.gif",
    "assets/gift/MONSTER_SELECT.gif"
  ];
  List<String> pathAvatarNoSelect = [
    "assets/gift/MEN_WAITING.gif",
    "assets/gift/WOMEN_WAITING.gif",
    "assets/gift/MONSTER_WAITING.gif"
  ];
  String pathSelectedAvatar = "";
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) async {
        if (state is UserLoggedInState) {
          //Show dialog when Login failed or login without wallet
          if (state.isLoggedIn) {
            setPreference('usAvatar', pathSelectedAvatar);
            //Go to Home
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (Route<dynamic> route) => false);
          }
        }
      },
      child: Scaffold(
        backgroundColor: backgroundWhite,
        appBar: AppBar(
          backgroundColor: backgroundWhite,
          elevation: 0,
          centerTitle: true,
          title: Image.asset(
            'assets/imgs/logoSolo.png',
            height: 50,
          ),
          automaticallyImplyLeading: false,
        ),

        //Body
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: ListView(children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            //AVATAR
            //textSpan left
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.unpasoMas,
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: greenPrimary,
                        decoration: TextDecoration.none),
                  ),
                  const SizedBox(height: 15),
                  Text.rich(
                    TextSpan(
                      text: "${S.current.Bienvenido} ${widget.user.fullName}, ",
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: greenPrimary,
                          decoration: TextDecoration.none),
                      children: <TextSpan>[
                        TextSpan(
                            text: S.current.selectAvatar,
                            style: GoogleFonts.sourceSansPro(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: greenPrimary,
                                decoration: TextDecoration.none)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
                height: ScreenWH(context).height * 0.26, child: selectAvatar()),
            const SizedBox(height: 30),

            //Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              //Button
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () async {
                  if (pathSelectedAvatar.isEmpty) {
                    showSnackBar(context, S.current.DatosIncompletos, true);
                  } else {
                    await UserRepository()
                        .editUser(pathSelectedAvatar, widget.user.fullName,
                            widget.user.email)
                        .then((value) async => {
                              await getPermissions().then((value) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/home', ModalRoute.withName('/'));
                              })
                            });
                  }
                },
                child: Text(
                  S.current.Siguiente,
                  style: GoogleFonts.sourceSansPro(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      decoration: TextDecoration.none),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget avatar(String name, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          for (int i = 0; i < avatarSelect.length; i++) {
            avatarSelect[i] = index == i ? !avatarSelect[i] : false;
          }
          if (avatarSelect.contains(true)) {
            pathSelectedAvatar = pathAvatarSelected[index];
          }
        });
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                  color: avatarSelect[index] ? greenPrimary : Colors.grey,
                  width: avatarSelect[index] ? 3 : 2),
            ),
            child: Image.asset(
                avatarSelect[index]
                    ? pathAvatarSelected[index]
                    : pathAvatarNoSelect[index],
                height: ScreenWH(context).height * 0.23,
                width: ScreenWH(context).width * 0.24),
          ),
        ],
      ),
    );
  }

  Widget selectAvatar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        avatar("Male", 0),
        avatar("Female", 1),
        avatar("Monster", 2),
      ],
    );
  }
}
