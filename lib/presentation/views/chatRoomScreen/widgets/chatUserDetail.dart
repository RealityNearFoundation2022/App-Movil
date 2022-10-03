import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/generated/l10n.dart';

class chatUserDetail extends StatelessWidget {
  //Variables
  static String routeName = "/chatUserDetailScreen";
  const chatUserDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //variables como argumentos
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: greenPrimary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          margin: const EdgeInsets.only(right: 10),
          alignment: Alignment.centerRight,
          child: Text(
            S.current.InfoDelContacto,
            style: GoogleFonts.sourceSansPro(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(args['photo']),
            ),
            const SizedBox(height: 20),
            Text(
              args['name'],
              style: GoogleFonts.sourceSansPro(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            onlineState(true, context),
            options(context),
          ],
        ),
      ),
    );
  }

  Widget onlineState(bool state, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.only(left: 15, bottom: 10, top: 10),
      width: ScreenWH(context).width * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        state ? S.current.Disponible : S.current.Desconectado,
        textAlign: TextAlign.center,
        style: GoogleFonts.sourceSansPro(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: state ? greenPrimary : Colors.red,
        ),
      ),
    );
  }

  Widget options(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.only(left: 15, bottom: 10, top: 10),
      width: ScreenWH(context).width * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.current.VaciarChat,
            style: GoogleFonts.sourceSansPro(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black45,
            ),
          ),
          Text(
            S.current.Bloquear,
            style: GoogleFonts.sourceSansPro(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
          Text(
            S.current.Reportar,
            style: GoogleFonts.sourceSansPro(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
