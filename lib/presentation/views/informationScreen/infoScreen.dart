import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/presentation/bloc/menu/menu_bloc.dart';
import 'package:sizer/sizer.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textAndIcon('Actualizaciones', Icons.keyboard_arrow_right_rounded),
        GestureDetector(
            onTap: (() {
              BlocProvider.of<MenuBloc>(context, listen: false)
                  .add(MenuOpenBugEvent());
            }),
            child: textAndIcon(
                'Reporte de Bug', Icons.keyboard_arrow_right_rounded)),
        textAndIcon(
            'Política de privacidad', Icons.keyboard_arrow_right_rounded),
        textAndIcon(
            'Términos y condiciones', Icons.keyboard_arrow_right_rounded),
        Expanded(
          child: Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.only(
              bottom: 15,
              right: 15,
            ),
            child: const Text(
              'v. 1.0.0',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
          ),
        )
      ],
    );
  }

  Widget textAndIcon(String text, IconData icon) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              text,
              style: GoogleFonts.sourceCodePro(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Icon(
                icon,
                size: 20.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    });
  }
}
