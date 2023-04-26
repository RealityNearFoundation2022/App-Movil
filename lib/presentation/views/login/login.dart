import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/repository/user_repository.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/bloc/user/user_bloc.dart';
import 'package:reality_near/presentation/views/login/no_avatar_screen.dart';
import 'package:reality_near/presentation/views/login/widgets/button_with_states.dart';
import 'package:reality_near/presentation/widgets/dialogs/errorAlertDialog.dart';
import 'package:reality_near/presentation/widgets/forms/textForm.dart';
import 'package:reality_near/presentation/widgets/others/snackBar.dart';

class Login extends StatelessWidget {
  Login({Key key}) : super(key: key);
//Variables
  static String routeName = "/login";
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
          // If no have avatarPath go to noAvatar Screen to select one
          UserRepository().getMyData().then((value) => value.fold(
                // ignore: avoid_print
                (failure) => print(failure),
                (success) async => {
                  success.avatar.isEmpty
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoAvatarScreen(
                                    user: success,
                                  )),
                        )
                      : await getPermissions().then((value) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/home', ModalRoute.withName('/'));
                        })
                },
              ));
          // showDialog(
          //     context: context,
          //     builder: (context) => SyncWalletDialog(
          //           onLogin: () {
          //             Navigator.pushNamedAndRemoveUntil(
          //                 context, '/home', ModalRoute.withName('/'));
          //           },
          //         ));
        } else if (state is UserFailState) {
          //Show dialog when Login failed
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (dialogContext) {
                return ErrorAlertDialog(
                  errorMessage: S.current.failLogin,
                );
              });
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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Top spacer
                SizedBox(height: ScreenWH(context).height * 0.04),
                //Logo image
                Image.asset('assets/imgs/Logo_sin_fondo.png',
                    height: 200, width: 200),
                SizedBox(height: ScreenWH(context).height * 0.04),

                //Login form
                logInEmail(_txtFormEmail, _txtFormPassword),
                //Button
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: ((context, state) {
                      return ButtonWithStates(
                          text: S.current.Ingresar,
                          press: () {
                            //creamos un evento en el bloc
                            if (_emailController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              showSnackBar(
                                  context, S.current.DatosIncompletos, true);
                            } else {
                              BlocProvider.of<UserBloc>(context, listen: false)
                                  .add(UserLoginEmailEvent(
                                      _emailController.text,
                                      _passwordController.text));
                            }
                          });
                    }),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          endIndent: 10,
                          color: bordergrey,
                        ),
                      ),
                      Text(
                        S.current.OiongresaCon,
                        style: const TextStyle(color: Color(0xFF555555)),
                      ),
                      const Expanded(
                        child: Divider(
                          indent: 10,
                          color: bordergrey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),

                IconButton(
                    constraints: const BoxConstraints(
                        maxHeight: 50,
                        maxWidth: 200,
                        minHeight: 50,
                        minWidth: 200),
                    onPressed: () {
                      BlocProvider.of<UserBloc>(context, listen: false)
                          .add(UserLoginWalletEvent(context));
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/near_logo_complete.svg',
                      color: const Color(0xFF555555),
                      height: MediaQuery.of(context).size.height * 0.030,
                      width: MediaQuery.of(context).size.height * 0.090,
                    )),
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
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: password,
        ),
      ],
    );
  }
}
