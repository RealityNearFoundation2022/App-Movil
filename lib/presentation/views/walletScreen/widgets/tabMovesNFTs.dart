import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/datasource/nearRPC/contracts.dart';
import 'package:reality_near/data/models/nftModel.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/widgets/forms/searchBar.dart';

class TabMovesNFTs extends StatefulWidget {
  const TabMovesNFTs({Key key}) : super(key: key);

  @override
  State<TabMovesNFTs> createState() => _TabMovesNFTsState();
}

class _TabMovesNFTsState extends State<TabMovesNFTs> {
  TextEditingController searchMovesController = TextEditingController();

  TextEditingController searchNFTController = TextEditingController();

  List<NftModel> lstNFTs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //obtener NFTs de wallet
    ContractRemoteDataSourceImpl().getMyNFTs().then((value) => setState(() {
      lstNFTs = value;
    }));
  }

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
                          SizedBox(height: ScreenWH(context).height * 0.06),
                          Image.asset('assets/imgs/transferSoon.png'),
                          const SizedBox(height: 20),
                          Text(
                            'Aquí podras ver todos tus movimientos de Realities',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: txtPrimary,
                            ),
                          ),
                          // const SizedBox(height: 10),
                          // Searchbar(
                          //     placeholder: S.current.BuscarMovimientos,
                          //     controller: searchMovesController),
                          // Expanded(
                          //   child: ListView.builder(
                          //     itemCount: 10,
                          //     itemBuilder: (context, index) {
                          //       return movimientos(
                          //           'Movimiento 1',
                          //           '10/10/2022',
                          //           (Random().nextDouble() * 2123)
                          //               .roundToDouble()
                          //               .toStringAsFixed(4),
                          //           "https://source.unsplash.com/random/200x200?sig=$index");
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(height: ScreenWH(context).height * 0.06),
                          Image.asset('assets/imgs/nftSoon.png'),
                          const SizedBox(height: 20),
                          Text(
                            'Aquí podras ver todas las NFTs que tengas en tu wallet',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: txtPrimary,
                            ),
                          ),
                          // Searchbar(
                          //     placeholder: S.current.BuscarNFTs,
                          //     controller: searchNFTController),
                          // const SizedBox(height: 10),
                          // Expanded(
                          //   child: GridView.builder(
                          //     shrinkWrap: true,
                          //     itemCount: lstNFTs.length,
                          //     gridDelegate:
                          //         const SliverGridDelegateWithFixedCrossAxisCount(
                          //             crossAxisCount: 2,
                          //             childAspectRatio: 0.56),
                          //     itemBuilder: (context, index) {
                          //       return Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 8.0),
                          //         child: nftCard(lstNFTs[index]),
                          //       );
                          //     },
                          //   ),
                          // ),
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

  Widget nftCard(NftModel nft) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                nft.metadata.media,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          nft.metadata.title,
          style: GoogleFonts.sourceSansPro(
              fontSize: 16, fontWeight: FontWeight.w600, color: txtPrimary),
        ),
        Text(
          nft.tokenId,
          style: GoogleFonts.sourceSansPro(
              fontSize: 16, fontWeight: FontWeight.w400, color: txtPrimary),
        ),
      ],
    );
  }
}
