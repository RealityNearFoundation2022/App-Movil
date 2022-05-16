import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/presentation/bloc/menu/menu_bloc.dart';
import 'package:sizer/sizer.dart';

class OptionSection extends StatefulWidget {
  const OptionSection({Key? key}) : super(key: key);

  @override
  State<OptionSection> createState() => _OptionSectionState();
}

class _OptionSectionState extends State<OptionSection> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpansionMenu(context),
        textAndIcon('Permisos', Icons.keyboard_arrow_right_rounded),
        GestureDetector(
          onTap: () {
            BlocProvider.of<MenuBloc>(context, listen: false)
                .add(MenuOpenInfoEvent());
          },
          child: textAndIcon('Información', Icons.keyboard_arrow_right_rounded),
        ),
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

  Widget ExpansionMenu(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: ScreenWH(context).width * 0.4,
          child: Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              collapsedTextColor: Colors.white,
              textColor: Colors.white,
              onExpansionChanged: (bool value) {
                setState(() {
                  isExpanded = value;
                });
              },
              trailing: Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_right_rounded,
                color: Colors.white,
                size: 35,
              ),
              childrenPadding: const EdgeInsets.only(right: 15),
              title: Text(
                "Cuenta",
                style: GoogleFonts.sourceCodePro(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              children: <Widget>[
                txtSubMenu('Usuario'),
                txtSubMenu('Wallet'),
                txtSubMenu('Amigos'),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget txtSubMenu(String txt) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.all(5.0),
      child: Text(
        txt,
        style: GoogleFonts.sourceCodePro(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
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
