import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/generated/l10n.dart';

class chatSoonScreen extends StatelessWidget {
  static String routeName = "/ChatSoonScreen";

  const chatSoonScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          margin:  const EdgeInsets.only(right: 10),
          alignment: Alignment.center,
          child: Image.asset('assets/imgs/logoSolo.png', height: 50,),
        ),
        iconTheme: const IconThemeData(color: greenPrimary, size: 35),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/imgs/PersonaChateando.png'),
          const SizedBox(height: 20),
          Text(
            'Próximamente podrás chatear con tus amigos',
            textAlign: TextAlign.center,
            style: GoogleFonts.sourceSansPro(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: txtPrimary,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(greenPrimary),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0))),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 50)),
            ),
            child: Text(
              S.current.Volver,
              textAlign: TextAlign.center,
              style: GoogleFonts.sourceSansPro(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
