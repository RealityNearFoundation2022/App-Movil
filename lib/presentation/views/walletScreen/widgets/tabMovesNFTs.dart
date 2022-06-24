import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/widgets/forms/searchBar.dart';
import 'package:sizer/sizer.dart';

class TabMovesNFTs extends StatelessWidget {
  TabMovesNFTs({Key key}) : super(key: key);

  TextEditingController searchMovesController = TextEditingController();
  TextEditingController searchNFTController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  unselectedLabelColor: Colors.black54,
                  labelColor: Colors.white,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50), // Creates border
                      color: greenPrimary),
                  tabs: [
                    Tab(
                      child: Text(
                        S.current.Movimientos,
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "NFTs",
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Searchbar(
                              placeholder: S.current.BuscarMovimientos,
                              controller: searchMovesController),
                          Expanded(
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return movimientos(
                                    'Movimiento 1',
                                    '10/10/2022',
                                    (Random().nextDouble() * 2123)
                                        .roundToDouble()
                                        .toStringAsFixed(4),
                                    "https://source.unsplash.com/random/200x200?sig=$index");
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Searchbar(
                              placeholder: S.current.BuscarNFTs,
                              controller: searchNFTController),
                          const SizedBox(height: 10),
                          Expanded(
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: 10,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.56),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: nftCard(
                                      'NFT 1',
                                      '13/10/2022',
                                      (Random().nextDouble() * 270)
                                          .roundToDouble()
                                          .toString(),
                                      "https://source.unsplash.com/random/200x200?sig=$index"),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            )),
      ),
    );
  }

  Widget movimientos(String nombre, String fecha, String monto, String photo) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          photo,
        ),
      ),
      title: Text(
        nombre,
        style: GoogleFonts.sourceSansPro(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        fecha,
        style: GoogleFonts.sourceSansPro(
            fontSize: 14, fontWeight: FontWeight.bold, color: greenPrimary),
      ),
      trailing: Text(
        monto,
        style: GoogleFonts.sourceSansPro(
            fontSize: 18, fontWeight: FontWeight.bold, color: greenPrimary),
      ),
    );
  }

  Widget nftCard(String nombre, String fecha, String monto, String photo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                photo,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          nombre,
          style: GoogleFonts.sourceSansPro(
              fontSize: 16, fontWeight: FontWeight.w600, color: txtPrimary),
        ),
        Text(
          'Reality Foundation',
          style: GoogleFonts.sourceSansPro(
              fontSize: 16, fontWeight: FontWeight.w400, color: txtPrimary),
        ),
        Row(
          children: [
            const CircleAvatar(
              radius: 12.0,
              backgroundImage: AssetImage("assets/imgs/RealityIconCircle.png"),
            ),
            const SizedBox(width: 5),
            Text(
              monto,
              style: GoogleFonts.sourceSansPro(
                  fontSize: 16, color: txtPrimary, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        Text(
          "\$ 140",
          style: GoogleFonts.sourceSansPro(
              fontSize: 16, color: txtPrimary, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
