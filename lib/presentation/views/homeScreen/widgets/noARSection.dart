import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:sizer/sizer.dart';

class NoArSection extends StatelessWidget {
  const NoArSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Column(
        children: [
          const SizedBox(height: 130),
          const CircleAvatar(
            radius: 60.0,
            backgroundImage:
                NetworkImage('https://picsum.photos/700/400?random'),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Juan Alvarez',
              style: GoogleFonts.sourceSansPro(
                  fontSize: 20.sp,
                  color: greenPrimary3,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '1554 Realities',
            style: GoogleFonts.sourceSansPro(
                fontSize: 15.sp,
                color: greenPrimary3,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Buttons('Transferir', greenPrimary),
              Buttons('Recibir', Colors.black45),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Text(
                    'Amigos',
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 20.sp,
                        color: greenPrimary3,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: listConectedFriends()),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget Buttons(String text, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 130,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(30), color: color),
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      child: Center(
          child: Text(text,
              style: GoogleFonts.sourceSansPro(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600))),
    );
  }

  Widget listConectedFriends() {
    return ListView.builder(
      itemCount: 10,
      padding: const EdgeInsets.symmetric(vertical: 5),
      itemBuilder: (context, index) {
        return pendientesCard();
      },
    );
  }

  Widget pendientesCard() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          "https://source.unsplash.com/random/200x200?sig=${Random().nextInt(100)}",
        ),
      ),
      title: Text(
        getRandomName(),
        style: GoogleFonts.sourceSansPro(),
      ),
      subtitle: Text("Conectado",
          style: GoogleFonts.sourceSansPro(color: greenPrimary)),
    );
  }
}
