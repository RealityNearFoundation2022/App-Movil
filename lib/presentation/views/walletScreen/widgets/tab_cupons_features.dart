import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/walletScreen/widgets/cupon_detail.dart';
import 'package:reality_near/presentation/views/walletScreen/widgets/triangle_border.dart';

class TabCuponsFeatures extends StatefulWidget {
  const TabCuponsFeatures({Key key}) : super(key: key);

  @override
  State<TabCuponsFeatures> createState() => _TabCuponsFeaturesState();
}

class _TabCuponsFeaturesState extends State<TabCuponsFeatures> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            alignment: Alignment.centerLeft,
            child: Text(
              S.current.cupones,
              style: GoogleFonts.sourceSansPro(
                color: greenPrimary,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            height: MediaQuery.of(context).size.height * 0.4,
            alignment: Alignment.bottomCenter,
            child: Text(
              'Aún no tienes cupones disponibles',
              style: GoogleFonts.sourceSansPro(
                color: txtGrey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // gridCupons(),
        ],
      ),
      // child: DefaultTabController(
      //     length: 2,
      //     child: Column(
      //       children: [
      //         TabBar(
      //           unselectedLabelColor: Colors.black54,
      //           labelColor: Colors.white,
      //           indicator: BoxDecoration(
      //               borderRadius: BorderRadius.circular(50), // Creates border
      //               color: greenPrimary),
      //           tabs: [
      //             Tab(
      //               child: Text(
      //                 S.current.cupones,
      //                 style: GoogleFonts.sourceSansPro(
      //                   fontSize: 20,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //             ),
      //             Tab(
      //               child: Text(
      //                 S.current.proximamente,
      //                 style: GoogleFonts.sourceSansPro(
      //                   fontSize: 20,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //         Expanded(
      //           child: TabBarView(children: [
      //             Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 0),
      //               child: Column(
      //                 children: [
      //                   const SizedBox(height: 20),
      //                   gridCupons(),
      //                 ],
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 20),
      //               child: Column(
      //                 children: [
      //                   SizedBox(height: ScreenWH(context).height * 0.06),
      //                   Image.asset('assets/imgs/nftSoon.png'),
      //                   const SizedBox(height: 20),
      //                   Text(
      //                     'Aquí podras ver todas las NFTs que tengas en tu wallet',
      //                     textAlign: TextAlign.center,
      //                     style: GoogleFonts.sourceSansPro(
      //                       fontSize: 20,
      //                       fontWeight: FontWeight.w600,
      //                       color: txtPrimary,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ]),
      //         ),
      //       ],
      //     )),
    );
  }

  gridCupons() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3.2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return _cupon('cupon $index');
        },
      ),
    );
  }

  _cupon(String name) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const CuponDetail(
              heroTag: 'cupon',
              backGroungColor: Colors.blue,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            //container with logo, and other with data
            Hero(
              tag: name,
              child: ClipPath(
                clipper: TriangleClipper(),
                child: Container(
                  height: ScreenWH(context).height * 0.3 / 2.1,
                  width: ScreenWH(context).width * 0.4,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/imgs/logoSolo.png',
                      height: ScreenWH(context).height * 0.1,
                    ),
                  ),
                ),
              ),
            ),
            Container(
                // height: ScreenWH(context).height * 0.14,
                width: ScreenWH(context).width * 0.4,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      '10% OFF',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.sourceSansPro(
                        fontSize: getResponsiveText(context, 14),
                        fontWeight: FontWeight.bold,
                        color: txtPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Luta Livre',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.sourceSansPro(
                        fontSize: getResponsiveText(context, 12),
                        fontWeight: FontWeight.w400,
                        color: txtPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '1 ENE - 30 FEB 2023',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.sourceSansPro(
                        fontSize: getResponsiveText(context, 12),
                        fontWeight: FontWeight.w400,
                        color: greenPrimary,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
