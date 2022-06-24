import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:sizer/sizer.dart';

class EventDetailsPage extends StatelessWidget {
  final String title;
  final String eventImg;
  const EventDetailsPage({
    Key key,
    this.title,
    this.eventImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //check the size of device
    var brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon:
      //         const Icon(Icons.arrow_back_ios, color: greenPrimary, size: 30),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   title: Image.asset(
      //     'assets/imgs/Logo_sin_fondo.png',
      //     fit: BoxFit.contain,
      //     height: 70,
      //   ),
      //   centerTitle: true,
      //   elevation: 0,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                height: size.height * 0.35,
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
                        fontSize: size.width * 0.065,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "by Reality Near Foundation",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.sourceSansPro(
                            fontSize: size.width * 0.04,
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
                  loremIpsum,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.sourceSansPro(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: txtPrimary),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios,
                          color: greenPrimary, size: 35),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Respond to button press
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(greenPrimary),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(horizontal: 30)),
                      ),
                      child: Text(
                        "!Vamos¡",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sourceSansPro(
                          color: Colors.white,
                          fontSize: 14.5.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.share_outlined,
                          color: icongrey, size: 35),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
