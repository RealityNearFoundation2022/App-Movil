import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/homeScreen/homeScreen.dart';
import 'package:reality_near/presentation/views/login/widgets/button_with_states.dart';
import 'package:reality_near/presentation/widgets/forms/textForm.dart';

class CreateUserScreen extends StatefulWidget {
  static String routeName = "/createUser";
  CreateUserScreen({Key key}) : super(key: key);

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
//Variables
  final TextEditingController _userNameController = TextEditingController();

  List<bool> avatarSelect = [false, false, false];
  @override
  Widget build(BuildContext context) {
//text-Form-UserName
    TxtForm _txtFormUserName = TxtForm(
      placeholder: S.current.UserName,
      controller: _userNameController,
      inputType: InputType.Email,
      txtColor: txtPrimary,
      prefixIcon: const Icon(Icons.person),
      errorMessage: S.current.EmailOblig,
    );

    Widget avatar(
        String pathSelected, String pathNoSelected, String name, int index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            for (int i = 0; i < avatarSelect.length; i++) {
              avatarSelect[i] = index == i ? !avatarSelect[i] : false;
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
                  avatarSelect[index] ? pathSelected : pathNoSelected,
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
          avatar("assets/gift/MEN_SELECTED.gif", "assets/gift/MEN_WAITING.gif",
              "Male", 0),
          avatar("assets/gift/WOMEN_SELECT.gif",
              "assets/gift/WOMEN_WAITING.gif", "Female", 1),
          avatar("assets/gift/MEN_SELECTED.gif", "assets/gift/MEN_WAITING.gif",
              "Monster", 2),
        ],
      );
    }

    return Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //Logo image
              Image.asset('assets/imgs/Logo_sin_fondo.png',
                  height: 120, width: 120),
              //AVATAR
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: selectAvatar(),
              ),
              const SizedBox(height: 20),
              //Login form
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
                child: _txtFormUserName,
              ),
              //Button
              FittedBox(
                child: GestureDetector(
                  onTap: () {
                    if (_userNameController.text.isNotEmpty) {
                      Navigator.of(context).pushNamed(HomeScreen.routeName);
                    }
                  },
                  child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      decoration: BoxDecoration(
                          color: greenPrimary,
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(S.current.Guardar,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sourceSansPro(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              decoration: TextDecoration.none))),
                ),
              ),
            ]),
      ),
    );
  }
}
