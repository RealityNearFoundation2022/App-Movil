import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/repository/WalletRepository.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/bloc/user/user_bloc.dart';
import 'package:reality_near/presentation/views/login/widgets/button_with_states.dart';
import 'package:reality_near/presentation/widgets/dialogs/errorAlertDialog.dart';
import 'package:reality_near/presentation/widgets/dialogs/infoDialog.dart';
import 'package:reality_near/presentation/widgets/forms/textForm.dart';

class Login extends StatelessWidget {
  Login({Key key}) : super(key: key);
//Variables
  static String routeName = "/login";
  final TextEditingController _walletController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
//Variables
    //Argumentos
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

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
          if (!state.isLoggedIn) {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (dialogContext) {
                  return args["type"] == "wallet"
                      ? ErrorAlertDialog(
                          errorMessage: S.current.failLogin,
                        )
                      : const InfoDialog(
                          title: "No estas registrando una wallet",
                          message:
                              "Al no registrarte con una Near Wallet, no podrás almacenar ni transaccionar dentro de Reality Near. Cuando quieras, podrás vincular tu Near Wallet, desde la sección de “Cuenta”.",
                        );
                });
          } else {
            //Go to Home
            await Future.delayed(const Duration(microseconds: 500));
            Navigator.pushNamedAndRemoveUntil(
                context, '/onBoard', ModalRoute.withName('/'));
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
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            //Top spacer
            SizedBox(height: ScreenWH(context).height * 0.1),
            //Logo image
            Image.asset('assets/imgs/Logo_sin_fondo.png',
                height: 200, width: 200),
            //Login form
            logInEmail(_txtFormEmail, _txtFormPassword),
            //Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: BlocBuilder<UserBloc, UserState>(
                builder: ((context, state) {
                  return ButtonWithStates(
                      text: S.current.Ingresar,
                      press: () {
                        //creamos un evento en el bloc
                        BlocProvider.of<UserBloc>(context, listen: false).add(
                            UserLoginEvent(context, _walletController.text));
                      });
                }),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget logInEmail(TxtForm email, TxtForm password) {
    return Column(
      children: [
        //Form
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: email,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: password,
        ),
      ],
    );
  }
}
