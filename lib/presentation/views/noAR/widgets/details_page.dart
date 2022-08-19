import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';

class EventDetailsPage extends StatelessWidget {
  final String title;
  final String eventImg;
  final String eventContent;
  const EventDetailsPage({
    Key key,
    this.title,
    this.eventImg,
    this.eventContent
  }) : super(key: key);

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
                    fit: BoxFit.cover,
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
                child: title != "Aniversario de Luta Livre Perú" ? Text(
                  eventContent,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.sourceSansPro(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: txtPrimary),
                ) :  _contentLuta(),
              )
              ,
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

  _contentLuta(){
    return  Column(
      children: [
        Text(
          "¡Sigue disfrutando tu pasión por el deporte !¡Gana una entrada doble para el Inka FC 35!",
          textAlign: TextAlign.left,
          style: GoogleFonts.sourceSansPro(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: txtPrimary),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "A través de tu aplicativo Reality Near, usa la cámara y busca el logo de la asociación de Luta Livre. En determinadas horas del día, se activará la opción de poder capturarlo y podrás ganar 1 de las 10 entradas dobles para el Inka FC 35, el cual se llevará a cabo el 25 de setiembre del 2022.",
          textAlign: TextAlign.left,
          style: GoogleFonts.sourceSansPro(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: txtPrimary),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Si eres uno de los afortunados ganadores, obtendrás en tus notificaciones, un código QR. Deberás mostrar el QR a uno de los encargados y brindarle tus datos. El mismo día del evento, se dará a conocer el nombre de los ganadores y se realizará el registro con los datos personales. Las entradas no son transferibles.",
          textAlign: TextAlign.left,
          style: GoogleFonts.sourceSansPro(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: txtPrimary),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "¡Muchas suerte!",
          textAlign: TextAlign.left,
          style: GoogleFonts.sourceSansPro(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: txtPrimary),
        ),
      ],
    );
  }

  
  _footter(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios,
                color: greenPrimary, size: 35),
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
