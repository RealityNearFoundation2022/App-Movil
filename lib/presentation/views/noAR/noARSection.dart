import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/noAR/widgets/bid_widget.dart';
import 'package:reality_near/presentation/views/noAR/widgets/category.dart';
import 'package:reality_near/presentation/views/noAR/widgets/trending_nft.dart';
import 'package:sizer/sizer.dart';

class NoArSection extends StatelessWidget {
  const NoArSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SingleChildScrollView(
        child: Column(
          children: [
            // const SizedBox(height: 130),

            // Container(
            //   alignment: Alignment.center,
            //   margin: const EdgeInsets.symmetric(vertical: 10),
            //   child: Text(
            //     'Juan Alvarez',
            //     style: GoogleFonts.sourceSansPro(
            //         fontSize: 20.sp,
            //         color: greenPrimary3,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            // const SizedBox(height: 10),
            // Text(
            //   '1554 Realities',
            //   style: GoogleFonts.sourceSansPro(
            //       fontSize: 15.sp,
            //       color: greenPrimary3,
            //       fontWeight: FontWeight.w600),
            // ),
            // const SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Buttons('Transferir', greenPrimary),
            //     Buttons('Recibir', Colors.black45),
            //   ],
            // ),
            SizedBox(height: 20),
            userSection(context,
                "https://source.unsplash.com/random/200x200?sig=${Random().nextInt(100)}"),
            SizedBox(height: 25),
            eventsCarrousel(context),
            SizedBox(height: 15),
            NFTArrivals(context)
          ],
        ),
      );
    });
  }

  Widget userSection(BuildContext context, String photo) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        CircleAvatar(
          radius: 50.0,
          backgroundImage: NetworkImage(photo),
        ),
        const SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.Bienvenido,
              style: GoogleFonts.sourceSansPro(
                  fontSize: 15.sp,
                  // color: txtPrimary,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'Juan Alvarez',
              style: GoogleFonts.sourceSansPro(
                  fontSize: 20.sp,
                  color: greenPrimary3,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '1554 Realities',
              style: GoogleFonts.sourceSansPro(
                  fontSize: 12.sp,
                  color: greenPrimary3,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Buttons(S.current.Transferir, greenPrimary),
                const SizedBox(width: 10),
                Buttons(S.current.Recibir, Colors.black45),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget Buttons(String text, Color color) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 100,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(30), color: color),
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Center(
          child: Text(text,
              style: GoogleFonts.sourceSansPro(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600))),
    );
  }

  // Widget listConectedFriends() {
  //   return ListView.builder(
  //     itemCount: 10,
  //     padding: const EdgeInsets.symmetric(vertical: 5),
  //     itemBuilder: (context, index) {
  //       return pendientesCard();
  //     },
  //   );
  // }

  // Widget pendientesCard() {
  //   return ListTile(
  //     leading: CircleAvatar(
  //       backgroundImage: NetworkImage(
  //         "https://source.unsplash.com/random/200x200?sig=${Random().nextInt(100)}",
  //       ),
  //     ),
  //     title: Text(
  //       getRandomName(),
  //       style: GoogleFonts.sourceSansPro(),
  //     ),
  //     subtitle: Text("Conectado",
  //         style: GoogleFonts.sourceSansPro(color: greenPrimary)),
  //   );
  // }

  Widget eventsCarrousel(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        buildCategory(S.current.Eventos, greenPrimary2, size),
        SizedBox(height: 10),
        SizedBox(
          width: size.width,
          height: size.height * 0.25,
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, i) {
              //! example bids
              if (i == 0) {
                return EventWidget(
                  title: 'DeerGOG',
                  eventImg:
                      "https://source.unsplash.com/random/200x200?sig=${Random().nextInt(100)}",
                );
              } else if (i == 1) {
                return EventWidget(
                  title: 'Nature',
                  eventImg:
                      "https://source.unsplash.com/random/200x200?sig=${Random().nextInt(100)}",
                );
              } else {
                return EventWidget(
                  title: 'Blue and Red',
                  eventImg:
                      "https://source.unsplash.com/random/200x200?sig=${Random().nextInt(100)}",
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget NFTArrivals(BuildContext context) {
    return Column(
      children: [
        buildCategory(
            S.current.NuevosNFts, greenPrimary2, MediaQuery.of(context).size),
        const TrendingNft(),
      ],
    );
  }
}
