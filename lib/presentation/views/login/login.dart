import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/presentation/bloc/user/user_bloc.dart';
import 'package:reality_near/presentation/views/homeScreen/homeScreen.dart';
import 'package:reality_near/presentation/views/login/widgets/button_with_states.dart';
import 'package:reality_near/presentation/widgets/dialogs/errorAlertDialog.dart';
import 'package:reality_near/presentation/widgets/forms/textForm.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
//Variables
  static String routeName = "/login";
  final TextEditingController _walletController = TextEditingController();

  @override
  Widget build(BuildContext context) {
//Variables
//text-Form
    TxtForm _txtFormWallet = TxtForm(
      controller: _walletController,
      inputType: InputType.Default,
      txtColor: txtPrimary,
      prefixIcon: const Icon(Icons.account_balance_wallet),
      errorMessage: 'Wallet obligatoria',
    );

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) async {
        if (state is UserLoggedInState) {
          if (!state.isLoggedIn) {
            showDialog(
                // barrierDismissible: false,
                context: context,
                builder: (dialogContext) {
                  return const ErrorAlertDialog(
                    errorMessage:
                        'No se pudo Iniciar sesión con esta wallet, prueba de nuevo',
                  );
                });
          } else {
            await Future.delayed(const Duration(microseconds: 500));
            Navigator.pushNamedAndRemoveUntil(
                context, '/onBoard', ModalRoute.withName('/'));
          }
        }
      },
      child: Scaffold(
        backgroundColor: backgroundSoftBlue,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Top spacer
                SizedBox(height: ScreenWH(context).height * 0.1),
                //Logo image
                Image.asset('assets/imgs/Logo_sin_fondo.png',
                    height: 200, width: 200),
                //Login form
                //Title
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text('Ingresa tu Near Wallet',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sourceSansPro(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color: txtPrimary,
                            decoration: TextDecoration.none))),
                //Form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: _txtFormWallet,
                ),
                //Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: ((context, state) {
                      return ButtonWithStates(
                          text: 'Ingresar',
                          press: () {
                            //creamos un evento en el bloc
                            BlocProvider.of<UserBloc>(context, listen: false)
                                .add(UserLoginEvent(_walletController.text));
                          });
                    }),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
