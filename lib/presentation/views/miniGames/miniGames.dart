import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/presentation/views/miniGames/widgets/gamesUnity.dart';

class MiniGames extends StatefulWidget {
  static String routeName = '/miniGames';
  const MiniGames({Key key}) : super(key: key);

  @override
  State<MiniGames> createState() => _MiniGamesState();
}

class _MiniGamesState extends State<MiniGames> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalApppBar(context, 'Mini Games'),
      body: _body(),
    );
  }

  _body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          // ticketzone(),
          const SizedBox(
            height: 20,
          ),
          gameBanner('Dinasour Game', 'image', "DinoGame"),
          // gameContainer('Dinasour Game', 'Pon a tu destreza en este juego.',
          //     'assets/imgs/imgAlfaTest.png', () {
          //   Navigator.of(context).push(PageRouteBuilder(
          //     transitionDuration: const Duration(milliseconds: 300),
          //     pageBuilder: (context, animation, secondaryAnimation) =>
          //         SlideTransition(
          //       position: Tween<Offset>(
          //         begin: const Offset(-1.0, 0.0),
          //         end: Offset.zero,
          //       ).animate(animation),
          //       child: const GameUnity(
          //         scene: "DinoGame",
          //       ),
          //     ),
          //   ));
          // })
        ],
      ),
    );
  }

  gameBanner(String name, String image, String nameUnity) {
    Size size = MediaQuery.of(context).size;
    double width = size.width * 0.95;
    double height = size.width * 0.95 / 2;
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      child: InkWell(
        onTap: () async {
          Navigator.of(context).push(PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (context, animation, secondaryAnimation) =>
                SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: GameUnity(
                scene: nameUnity,
              ),
            ),
          ));
          ;
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              // child: Image.asset(
              //   'assets/imgs/cirecle_test.jpeg',
              //   fit: BoxFit.cover,
              //   alignment: Alignment.center,
              // ),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                width: width,
                height: height,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: height,
                    width: width,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  );
                },
              ),
            ),
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  alignment: Alignment.center,
                  height: height,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.black.withOpacity(0.5),
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sourceSansPro(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  ticketzone() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: greenPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: SvgPicture.asset(
              'assets/icons/ticket_icon.svg',
              height: 35,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '1000',
            style: GoogleFonts.sourceSansPro(
              color: Colors.white,
              fontSize: getResponsiveText(context, 18),
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Usted tiene 1000 tickets',
            style: GoogleFonts.sourceSansPro(
              color: Colors.white,
              fontSize: getResponsiveText(context, 18),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'Comprar',
                style: GoogleFonts.sourceSansPro(
                  color: greenPrimary,
                  fontSize: getResponsiveText(context, 16),
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  gameContainer(String name, String description, String img, Function onTap) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            // game image
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: AssetImage(img),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.08,
              color: greenPrimary,
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [
                  Positioned(
                    left: 10,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        name,
                        style: GoogleFonts.sourceSansPro(
                          color: Colors.white,
                          fontSize: getResponsiveText(context, 18),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '10',
                            style: GoogleFonts.sourceSansPro(
                              color: greenPrimary,
                              fontSize: getResponsiveText(context, 18),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/icons/tickets_icon.svg',
                            height: getResponsiveText(context, 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  Text(
                    description,
                    style: GoogleFonts.sourceSansPro(
                      color: txtPrimary,
                      fontSize: getResponsiveText(context, 14),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: greenPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        fixedSize: Size(MediaQuery.of(context).size.width * 0.4,
                            MediaQuery.of(context).size.height * 0.05),
                      ),
                      onPressed: () {
                        onTap();
                      },
                      child: Text(
                        'Jugar',
                        style: GoogleFonts.sourceSansPro(
                          color: Colors.white,
                          fontSize: getResponsiveText(context, 16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
