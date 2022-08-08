import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/bloc/user/user_bloc.dart';
import 'package:reality_near/presentation/views/login/widgets/button_with_states.dart';
import 'package:reality_near/presentation/views/register/widgets/ConfirmDialog.dart';
import 'package:reality_near/presentation/widgets/forms/textForm.dart';
import 'package:reality_near/presentation/widgets/others/snackBar.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = "/register";
  const RegisterScreen({Key key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
//Variables
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _userNameController = TextEditingController();

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
//text-Form-EMAIL
    TxtForm _txtFormEmail = TxtForm(
      placeholder: S.current.Email,
      controller: _emailController,
      inputType: InputType.Email,
      txtColor: txtPrimary,
      prefixIcon: const Icon(Icons.mail),
      errorMessage: S.current.EmailOblig,
    );
//text-Form-Password
    TxtForm _txtFormPassword = TxtForm(
      placeholder: S.current.UserName,
      controller: _userNameController,
      inputType: InputType.Default,
      txtColor: txtPrimary,
      prefixIcon: const Icon(Icons.person),
      errorMessage: S.current.Obligatorio,
    );
//text-Form-Username
    TxtForm _txtFormPasswordConf = TxtForm(
      placeholder: S.current.Password,
      controller: _passwordController,
      inputType: InputType.Password,
      txtColor: txtPrimary,
      prefixIcon: const Icon(Icons.lock),
      errorMessage: S.current.PasswordOblig,
    );

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) async {
        if (state is UserLoggedInState) {
          //Show dialog when Login failed or login without wallet
          if (state.isLoggedIn) {
            //Go to Home
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (Route<dynamic> route) => false);
          }
        }
      },
      child: Scaffold(
        backgroundColor: backgroundWhite,
        //Top bar with back button
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: greenPrimary),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        //Body
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
          child: ListView(children: <Widget>[
            //Logo image
            Image.asset('assets/imgs/Logo_sin_fondo.png',
                height: 150, width: 150),
            //Login form
            _txtFormEmail,
            const SizedBox(height: 20),
            _txtFormPassword,
            const SizedBox(height: 20),
            _txtFormPasswordConf,
            const SizedBox(height: 20),
            //AVATAR
            Container(
              alignment: Alignment.centerLeft,
              child: Text("Select you avatar",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sourceSansPro(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: greenPrimary,
                      decoration: TextDecoration.none)),
            ),
            const SizedBox(height: 20),
            SizedBox(
                height: ScreenWH(context).height * 0.28, child: selectAvatar()),
            const SizedBox(height: 20),
            //Button
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40),
              child: ButtonWithStates(
                  text: S.current.Registrate,
                  press: () {
                    if (_emailController.text.isEmpty ||
                        _passwordController.text.isEmpty ||
                        _userNameController.text.isEmpty) {
                      showSnackBar(context, S.current.DatosIncompletos, true);
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return ConfirmUserDialog(
                              username: _userNameController.text,
                              avatar: pathSelectedAvatar,
                              pressFunc: () {
                                //creamos un evento en el bloc
                                BlocProvider.of<UserBloc>(context).add(
                                    UserRegisterEvent(
                                        _emailController.text,
                                        _passwordController.text,
                                        _userNameController.text));
                              },
                            );
                          });
                    }
                  }),
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
          Text(name,
              textAlign: TextAlign.center,
              style: GoogleFonts.sourceSansPro(
                  fontSize: avatarSelect[index] ? 22 : 20,
                  fontWeight:
                      avatarSelect[index] ? FontWeight.bold : FontWeight.w700,
                  color: avatarSelect[index] ? greenPrimary : txtPrimary,
                  decoration: TextDecoration.none))
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
