import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/generated/l10n.dart';

import '../../../data/repository/user_repository.dart';
import '../../../data/models/user_model.dart';
import '../../widgets/forms/textForm.dart';

class userScreen extends StatefulWidget {
  //Variables
  static String routeName = "/userScreen";
  const userScreen({Key key}) : super(key: key);

  @override
  State<userScreen> createState() => _userScreenState();
}

class _userScreenState extends State<userScreen> {
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  List<bool> avatarSelect = [false, false, false];
  UserModel user = UserModel();
  String pathSelectedAvatar = "";
  bool loadingData = true;
  // bool loadSaveData = false;
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

  @override
  initState() {
    // TODO: implement initState
    super.initState();

    UserRepository().getMyData().then((value) => value.fold(
          (failure) => print(failure),
          (success) => setState(() {
            user = success;
            avatarSelect[pathAvatarSelected
                .indexWhere((element) => element == user.avatar)] = true;
            loadingData = false;
          }),
        ));
  }

  @override
  Widget build(BuildContext context) {
//text-Form-Password
    TxtForm _txtFormUserName = TxtForm(
      placeholder: user.username,
      controller: _userNameController,
      inputType: InputType.Default,
      txtColor: txtPrimary,
      prefixIcon: const Icon(Icons.person),
      errorMessage: S.current.Obligatorio,
    );
//text-Form-Username
    TxtForm _txtFormPassword = TxtForm(
      placeholder: S.current.Password,
      controller: _passwordController,
      inputType: InputType.Password,
      txtColor: txtPrimary,
      prefixIcon: const Icon(Icons.lock),
      errorMessage: S.current.PasswordOblig,
    );
//text-Form-mail
    TxtForm _txtFormEmail = TxtForm(
      placeholder: user.email,
      controller: _emailController,
      inputType: InputType.Email,
      txtColor: txtPrimary,
      prefixIcon: const Icon(Icons.mail),
      errorMessage: S.current.Obligatorio,
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          margin: const EdgeInsets.only(right: 10),
          alignment: Alignment.centerRight,
          child: Text(
            S.current.Usuario,
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
        child: loadingData
            ? loading()
            : ListView(children: <Widget>[
                Image.asset('assets/imgs/Logo_sin_fondo.png',
                    height: 150, width: 150),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Edita tus datos",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: greenPrimary,
                          decoration: TextDecoration.none)),
                ),
                const SizedBox(height: 20),
                _txtFormUserName,
                const SizedBox(height: 20),
                _txtFormEmail,
                const SizedBox(height: 20),
                _txtFormPassword,
                const SizedBox(height: 20),
                //AVATAR
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Edita tú avatar",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: greenPrimary,
                          decoration: TextDecoration.none)),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    height: ScreenWH(context).height * 0.28,
                    child: selectAvatar()),
                const SizedBox(height: 20),
                //Button
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 40),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: greenPrimary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.all(10),
                      ),
                      child: Text(
                        S.current.Guardar,
                        style: GoogleFonts.sourceSansPro(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        // _userNameController.text = _userNameController.text.isEmpty ? user.username : _userNameController.text;
                        //   showDialog(
                        //       context: context,
                        //       builder: (context) {
                        //         return ConfirmUserDialog(
                        //           username: _userNameController.text,
                        //           avatar: pathSelectedAvatar,
                        //           pressFunc: () {
                        //             UserRepository().editUser(_passwordController.text, _userNameController.text, pathSelectedAvatar);
                        //           },
                        //         );
                        //       });
                      }),
                ),
              ]),
      ),
    );
  }

  loading() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LoadingAnimationWidget.dotsTriangle(
            color: greenPrimary,
            size: ScreenWH(context).width * 0.3,
          ),
          const SizedBox(height: 20),
          Text(
            S.current.Cargando,
            style: GoogleFonts.sourceSansPro(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          )
        ],
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
