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

  List<bool> avatarSelect = [false, false];
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

    Widget avatar(String path, String name, int index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            avatarSelect[index] = !avatarSelect[index];
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
                      ? "assets/imgs/man_selected.gif"
                      : "assets/imgs/man_waiting.gif",
                  height: ScreenWH(context).height * 0.3,
                  width: 100),
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
          avatar("assets/imgs/gifRN.gif", "Male", 0),
          avatar("assets/imgs/gifRN.gif", "Female", 1),
          avatar("assets/imgs/gifRN.gif", "Monster", 1),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ButtonWithStates(
                    text: S.current.Registrate,
                    press: () {
                      if (_userNameController.text.isNotEmpty) {
                        Navigator.of(context).pushNamed(HomeScreen.routeName);
                      }
                      //creamos un evento en el bloc
                    }),
              ),
            ]),
      ),
    );
  }
}
