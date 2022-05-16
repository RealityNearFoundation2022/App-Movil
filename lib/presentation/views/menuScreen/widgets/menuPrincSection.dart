import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../bloc/menu/menu_bloc.dart';

class MenuPrincSection extends StatelessWidget {
  const MenuPrincSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [topSection(), bottomSection(context)]);
    });
  }

  Widget topSection() {
    return Column(children: [
      const Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.person, color: Colors.white, size: 80)),
      Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Usuario',
          style: GoogleFonts.sourceSansPro(
              fontSize: 35.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Text(
          'ID: Usuario',
          style: GoogleFonts.sourceSansPro(
              fontSize: 30.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500),
        ),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Text(
          '1548 Realities',
          style: GoogleFonts.sourceSansPro(
              fontSize: 30.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500),
        ),
      ),
    ]);
  }

  Widget bottomSection(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap: () {
              BlocProvider.of<MenuBloc>(context, listen: false)
                  .add(MenuOpenCongifEvent());
            },
            child: const Icon(Icons.settings, color: Colors.white, size: 35)),
        Align(
          alignment: Alignment.centerRight,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Text(
                  'Logout',
                  style: GoogleFonts.sourceCodePro(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 30.sp),
                ),
              ),
              Text(
                'v. 1.0.0',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 25.sp),
              )
            ],
          ),
        )
      ],
    );
  }
}
