import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/bugScreen/bugScreen.dart';
import 'package:sizer/sizer.dart';

class userScreen extends StatelessWidget {
  //Variables
  static String routeName = "/userScreen";
  const userScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          margin: const EdgeInsets.only(right: 10),
          alignment: Alignment.centerRight,
          child: Text(
            S.current.Usuario,
            style: GoogleFonts.sourceSansPro(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: greenPrimary2,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: greenPrimary2, size: 35),
        leading: IconButton(
          padding: const EdgeInsets.only(left: 35),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(right: 20, bottom: 10),
            child: const CircleAvatar(
              backgroundImage:
                  NetworkImage("https://picsum.photos/700/400?random"),
              radius: 60,
            ),
          ),
          GestureDetector(
              onTap: (() {
                Navigator.of(context).pushNamed(BugScreen.routeName);
              }),
              child: textAndIcon('Nickname')),
          textAndIcon('Avatar'),
          textAndIcon(S.current.VincularEmail),
          Expanded(
              child: Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.only(bottom: 30, right: 20),
            child: Text(
              'Logout',
              style: GoogleFonts.sourceCodePro(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: greenPrimary2,
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget textAndIcon(String text) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              text,
              style: GoogleFonts.sourceSansPro(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: greenPrimary2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Icon(
                Icons.mode_edit_outline_outlined,
                size: 20.sp,
                color: greenPrimary2,
              ),
            ),
          ],
        ),
      );
    });
  }
}
