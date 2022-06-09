import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/presentation/widgets/forms/searchBar.dart';

class TabMovesNFTs extends StatelessWidget {
  TabMovesNFTs({Key key}) : super(key: key);

  TextEditingController searchMovesController = TextEditingController();
  TextEditingController searchNFTController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  unselectedLabelColor: Colors.black54,
                  labelColor: Colors.white,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50), // Creates border
                      color: greenPrimary2),
                  tabs: [
                    Tab(
                      child: Text(
                        "Movimientos",
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
                              placeholder: 'Buscar movimientos ...',
                              controller: searchMovesController),
                          Expanded(
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return movimientos(
                                    'Movimiento 1',
                                    '10/10/2022',
                                    '+1.000',
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
                              placeholder: 'Buscar NFTs ...',
                              controller: searchNFTController),
                          const SizedBox(height: 10),
                          Expanded(
                            child: GridView.builder(
                              itemCount: 10,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, childAspectRatio: 0.9),
                              itemBuilder: (context, index) {
                                return nftCard(
                                    'NFT 1',
                                    '13/10/2022',
                                    (Random().nextDouble() * 270)
                                        .roundToDouble()
                                        .toString(),
                                    "https://source.unsplash.com/random/200x200?sig=$index");
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
            fontSize: 14, fontWeight: FontWeight.bold, color: greenPrimary2),
      ),
      trailing: Text(
        monto + 'R',
        style: GoogleFonts.sourceSansPro(
            fontSize: 18, fontWeight: FontWeight.bold, color: greenPrimary2),
      ),
    );
  }

  Widget nftCard(String nombre, String fecha, String monto, String photo) {
    return Column(
      children: [
        Container(
          height: 120,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          monto + 'R',
          style: GoogleFonts.sourceSansPro(
              fontSize: 18, fontWeight: FontWeight.w600, color: greenPrimary2),
        ),
      ],
    );
  }
}
