import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/presentation/bloc/user/user_bloc.dart';

class ErrorAlertDialog extends StatelessWidget {
  final String errorMessage;
  const ErrorAlertDialog({Key? key, required this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
                child: Column(
                  children: [
                    Text(
                      'Error',
                      style: GoogleFonts.sourceSansPro(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      errorMessage,
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 15, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          //creamos un evento en el bloc
                          BlocProvider.of<UserBloc>(context, listen: false)
                              .add(UserLoginAgainEvent());
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Intentarlo de nuevo',
                          style: GoogleFonts.sourceSansPro(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Positioned(
                top: -50,
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 50,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 70,
                  ),
                )),
          ],
        ));
  }
}
