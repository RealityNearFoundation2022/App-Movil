import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';

class EventDetailsPage extends StatelessWidget {
  final String title;
  final String eventImg;
  final String eventContent;
  const EventDetailsPage(
      {Key key, this.title, this.eventImg, this.eventContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: ScreenWH(context).width,
                height: ScreenWH(context).height * 0.35,
                child: ClipRRect(
                  child: Image.asset(
                    eventImg,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.sourceSansPro(
                        color: greenPrimary,
                        fontSize: ScreenWH(context).width * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "by Reality Near Foundation",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.sourceSansPro(
                            fontSize: ScreenWH(context).width * 0.04,
                            fontWeight: FontWeight.bold,
                            color: txtPrimary),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: title != "INKA FC 35"
                    ? Text(
                        eventContent,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.sourceSansPro(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: txtPrimary),
                      )
                    : _contentLuta(),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: _footter(context),
    );
  }

  _contentLuta() {
    return Column(
      children: [
        Text(
          "¡No te pierdas el siguiente Inka FC y gana una entrada con Reality Near! Sé parte de los 10 ganadores de entradas para el siguiente Inka FC.",
          textAlign: TextAlign.left,
          style: GoogleFonts.sourceSansPro(
              fontSize: 16, fontWeight: FontWeight.w400, color: txtPrimary),
        ),
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text("Para competir sigue los siguientes pasos:",
            textAlign: TextAlign.left,
            style: GoogleFonts.sourceSansPro(
                fontSize: 16, fontWeight: FontWeight.w400, color: txtPrimary),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: Text.rich(
            TextSpan(
                text: "1. Durante el Inka FC 35, ingresa al aplicativo de Reality Near y ",
                style: GoogleFonts.sourceSansPro(
                    fontSize: 16, fontWeight: FontWeight.w400, color: txtPrimary),
                children: [
                  TextSpan(
                    text: 'activa el botón de la cámara',
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 16, fontWeight: FontWeight.bold, color: txtPrimary),
                  ),
                  TextSpan(
                    text: ' situado en la esquina superior derecha de la pantalla de inicio.',
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 16, fontWeight: FontWeight.w400, color: txtPrimary),
                  )
                ]
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text.rich(
            TextSpan(
                text: "2. Deberás ",
                style: GoogleFonts.sourceSansPro(
                    fontSize: 16, fontWeight: FontWeight.w400, color: txtPrimary),
                children: [
                  TextSpan(
                    text: 'buscar con tu cámara el cinturón',
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 16, fontWeight: FontWeight.bold, color: txtPrimary),
                  ),
                  TextSpan(
                    text: ', el cual estará habilitado para reclamar en distintas horas del día, así que no te duermas.',
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 16, fontWeight: FontWeight.w400, color: txtPrimary),
                  )
                ]
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text.rich(
            TextSpan(
                text: "3. Una vez encontrado el cinturón, presionalo, y dale al ",
                style: GoogleFonts.sourceSansPro(
                    fontSize: 16, fontWeight: FontWeight.w400, color: txtPrimary),
                children: [
                  TextSpan(
                    text: 'botón de canjear',
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 16, fontWeight: FontWeight.bold, color: txtPrimary),
                  ),
                  TextSpan(
                    text: '. Después de presionarlo, si no está activo el premio, te saldrá un mensaje para seguir participando. Pero, si tienes suerte, y el premio está activo en ese momento, ¡ganaste una de las ',
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 16, fontWeight: FontWeight.w400, color: txtPrimary),
                  ),
                  TextSpan(
                    text: '10 entradas',
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 16, fontWeight: FontWeight.bold, color: txtPrimary),
                  ),
                  TextSpan(
                    text: ' para el',
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 16, fontWeight: FontWeight.w400, color: txtPrimary),
                  ),
                  TextSpan(
                    text: ' Inka FC 36!',
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 16, fontWeight: FontWeight.bold, color: txtPrimary),
                  ),
                ]
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text.rich(
          TextSpan(
            text: "Si eres uno de los afortunados ganadores, verás el mensaje correspondiente y, si no, uno que indica que el premio no está disponible. Pero no te desanimes, ",
            style: GoogleFonts.sourceSansPro(
                fontSize: 16, fontWeight: FontWeight.w400, color: txtPrimary),
              children: <InlineSpan>[
                TextSpan(
                  text: '¡sigue peleando!',
                  style: GoogleFonts.sourceSansPro(
                      fontSize: 16, fontWeight: FontWeight.bold, color: txtPrimary),
                )
              ]
          ),
        ),

        // Text(
        //   "¡Muchas suerte!",
        //   textAlign: TextAlign.left,
        //   style: GoogleFonts.sourceSansPro(
        //       fontSize: 16, fontWeight: FontWeight.w400, color: txtPrimary),
        // ),
      ],
    );
  }

  _footter(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon:
                const Icon(Icons.arrow_back_ios, color: greenPrimary, size: 35),
            onPressed: () => Navigator.of(context).pop(),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     // Respond to button press
          //   },
          //   style: ButtonStyle(
          //     backgroundColor:
          //     MaterialStateProperty.all<Color>(greenPrimary),
          //     shape: MaterialStateProperty.all(RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(20.0))),
          //     padding: MaterialStateProperty.all<EdgeInsets>(
          //         const EdgeInsets.symmetric(horizontal: 30)),
          //   ),
          //   child: Text(
          //     "!Vamos¡",
          //     textAlign: TextAlign.center,
          //     style: GoogleFonts.sourceSansPro(
          //       color: Colors.white,
          //       fontSize: 16,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          // IconButton(
          //   icon: const Icon(Icons.share_outlined,
          //       color: icongrey, size: 35),
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
        ],
      ),
    );
  }
}
