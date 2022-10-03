import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/presentation/bloc/user/user_bloc.dart';

class ButtonWithStates extends StatefulWidget {
  final String text;
  final Function press;
  const ButtonWithStates({Key key, this.text, this.press}) : super(key: key);

  @override
  State<ButtonWithStates> createState() => _ButtonWithStatesState();
}

class _ButtonWithStatesState extends State<ButtonWithStates> {
//Variables
  bool passOrFail = true;

  // ButtonState state = ButtonState.init;

  @override
  Widget build(BuildContext context) {
    var userState = BlocProvider.of<UserBloc>(context).state;
    final isStreched = userState is UserInitialState;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: userState is UserInitialState ? ScreenWH(context).width * 0.5 : 70,
      child: isStreched ? button() : smallButton(),
    );
  }

  Widget button() {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        primary: Colors.white,
        backgroundColor: greenPrimary,
      ),
      child: Text(
        widget.text,
        style: GoogleFonts.notoSansJavanese(
          fontSize: 22,
          color: Colors.white,
        ),
      ),
      onPressed: () async {
        widget.press();
      },
    );
  }

  Widget smallButton() {
    return BlocBuilder<UserBloc, UserState>(builder: (_, state) {
      passOrFail = true;
      if (state is UserLoggedInState) {
        passOrFail = state.isLoggedIn;
      }
      final icon = passOrFail ? Icons.check : Icons.close;
      final color = passOrFail ? greenPrimary : Colors.red;
      return Container(
          margin: const EdgeInsets.all(7),
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          child: Center(
            child: state is UserLoggedInState
                ? Icon(icon, size: 35, color: Colors.white)
                : const SizedBox(
                    width: 35,
                    height: 35,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
          ));
    });
  }
}

// enum ButtonState { init, loading, done }
