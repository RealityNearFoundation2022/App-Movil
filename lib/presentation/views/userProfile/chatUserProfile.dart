import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:sizer/sizer.dart';

class UserProfile extends StatelessWidget {
  UserProfile({Key key}) : super(key: key);
  static String routeName = "/userProfile";

  @override
  Widget build(BuildContext context) {
    //arguments
    final Map<String, dynamic> arg = ModalRoute.of(context).settings.arguments;
    return Sizer(builder: (context, orientation, deviceType) {
      Widget IconText(Icon icon, String txt) {
        return Column(
          children: [
            icon,
            SizedBox(height: 5),
            Text(
              txt,
              style: GoogleFonts.sourceSansPro(
                fontSize: 13.sp,
                color: Colors.black,
              ),
            )
          ],
        );
      }

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
                  color: greenPrimary,
                ),
              ),
            ),
            iconTheme: const IconThemeData(color: greenPrimary, size: 35),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: (ScreenWH(context).width * 0.35) / 2,
                  backgroundImage: NetworkImage(arg['photo']),
                ),
              ),
              Text(
                arg['name'],
                style: GoogleFonts.sourceSansPro(
                    fontSize: 20.sp,
                    color: txtPrimary,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                arg['walletId'],
                style: GoogleFonts.sourceSansPro(
                    fontSize: 16.sp,
                    color: txtPrimary,
                    fontWeight: FontWeight.w500),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconText(
                      const Icon(
                        Icons.chat,
                        color: greenPrimary,
                        size: 30,
                      ),
                      'Chat',
                    ),
                    IconText(
                      Icon(
                        Icons.notifications_off_outlined,
                        color: txtPrimary.withOpacity(0.6),
                        size: 30,
                      ),
                      'Silenciar',
                    ),
                    IconText(
                      const Icon(
                        Icons.block,
                        color: Colors.red,
                        size: 30,
                      ),
                      'Bloquear',
                    ),
                    IconText(
                      const Icon(
                        Icons.report_problem_outlined,
                        color: Colors.red,
                        size: 30,
                      ),
                      'Reportar',
                    ),
                  ],
                ),
              )
            ],
          ));
    });
  }
}
