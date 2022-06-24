import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/presentation/bloc/user/user_bloc.dart';

class InfoDialog extends StatelessWidget {
  final String title, message;
  const InfoDialog({Key key, this.title, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.sourceSansPro(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: txtPrimary),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        message,
                        style: GoogleFonts.sourceSansPro(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: txtPrimary),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //creamos un evento en el bloc
                        BlocProvider.of<UserBloc>(context, listen: false)
                            .add(UserLoginAgainEvent());
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Continuar',
                        style: GoogleFonts.sourceSansPro(
                            color: greenPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // const Positioned(
            //     top: -0,
            //     child: CircleAvatar(
            //       backgroundColor: Colors.redAccent,
            //       radius: 50,
            //       child: Icon(
            //         Icons.close,
            //         color: Colors.white,
            //         size: 70,
            //       ),
            //     )),
          ],
        ));
  }
}
