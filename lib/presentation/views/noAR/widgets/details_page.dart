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
    var brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: ScreenWH(context).width,
                height: ScreenWH(context).height * 0.35,
                child: ClipRRect(
                  child: Image.network(
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
                      overflow: TextOverflow.ellipsis,
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
                child: Text(
                  eventContent,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.sourceSansPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: txtPrimary),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: _footter(context),
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
