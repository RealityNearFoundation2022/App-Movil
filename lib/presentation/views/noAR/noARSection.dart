import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/datasource/nearRPC/contracts.dart';
import 'package:reality_near/data/repository/userRepository.dart';
import 'package:reality_near/domain/entities/user.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/noAR/widgets/bid_widget.dart';
import 'package:reality_near/presentation/views/noAR/widgets/category.dart';
import 'package:reality_near/presentation/views/noAR/widgets/details_page.dart';
import 'package:reality_near/presentation/views/walletScreen/receiveScreen.dart';
import 'package:reality_near/presentation/views/walletScreen/transferScreen.dart';
import 'package:reality_near/presentation/widgets/dialogs/syncWalletDialog.dart';
import 'package:sizer/sizer.dart';

class NoArSection extends StatefulWidget {
  const NoArSection({Key key}) : super(key: key);
  @override
  State<NoArSection> createState() => _NoArSectionState();
}

class _NoArSectionState extends State<NoArSection> {
  bool status = false;
  User user = User();
  double walletBalance = 0;
  String walletId = "";

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getPersistData('walletId').then((value) => {
          if (value != null)
            {
              //obtener balance de wallet
              ContractRemoteDataSourceImpl()
                  .getMyBalance()
                  .then((value) => setState(() {
                        walletBalance = value;
                      })),
              setState(() {
                walletId = value;
              })
            }
        });

    UserRepository().getMyData().then((value) => value.fold(
          (failure) => print(failure),
          (success) => {
            persistData('username', success.fullName),
            persistData('userId', success.id.toString()),
            setState(() {
              user = success;
            })
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: userSection(context,
                "https://source.unsplash.com/random/200x200?sig=${Random().nextInt(100)}"),
          ),
          const SizedBox(height: 25),
          newsCarrousel(context),
          eventsSection(context)
        ],
      );
    });
  }

  Widget userSection(BuildContext context, String photo) {
    return Row(
      children: [
        CircleAvatar(
          radius: (ScreenWH(context).width * 0.25) / 2,
          backgroundImage: NetworkImage(photo),
        ),
        const SizedBox(width: 15),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.fullName ?? 'notUsername',
              style: GoogleFonts.sourceSansPro(
                  fontSize: 20.sp,
                  color: txtPrimary,
                  fontWeight: FontWeight.w800),
            ),
            walletId.isNotEmpty ?? false
                ? userWalletOpt()
                : GestureDetector(
                    onTap: () => showDialog(
                        context: context,
                        builder: (context) => const SyncWalletDialog()),
                    child: Container(
                      // margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black45),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      child: Center(
                          child: Text(S.current.SyncWallet,
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: 13.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800))),
                    ),
                  )
          ],
        )
      ],
    );
  }

  Widget userWalletOpt() {
    return Column(
      children: [
        const SizedBox(height: 5),
        Row(
          children: [
            const CircleAvatar(
              radius: 13.0,
              backgroundImage: AssetImage("assets/imgs/RealityIconCircle.png"),
            ),
            const SizedBox(width: 5),
            Text(
              'Realities: ${walletBalance.toStringAsFixed(4) ?? '0.0000'}',
              style: GoogleFonts.sourceSansPro(
                  fontSize: 16.sp,
                  color: txtPrimary,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Buttons(S.current.Transferir, greenPrimary, () {
              Navigator.of(context).pushNamed(TransferScreen.routeName);
            }),
            const SizedBox(width: 10),
            Buttons(S.current.Recibir, Colors.black45, () {
              Navigator.of(context)
                  .pushNamed(ReceiveScreen.routeName, arguments: {
                "walletId": "walletUsuario.near",
              });
            }),
          ],
        )
      ],
    );
  }

  Widget Buttons(String text, Color color, Function funcOnPress) {
    return GestureDetector(
      onTap: funcOnPress,
      child: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 103,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: color),
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Center(
            child: Text(text,
                style: GoogleFonts.sourceSansPro(
                    fontSize: 13.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w800))),
      ),
    );
  }

  Widget newsCarrousel(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: buildCategory(S.current.Novedades, greenPrimary, size)),
        const SizedBox(height: 10),
        SizedBox(
          width: size.width,
          height: size.height * 0.23,
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

  Widget eventsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          buildCategory(
              S.current.Eventos, greenPrimary, MediaQuery.of(context).size),
          const SizedBox(height: 10),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, i) {
                return eventContainer(
                    'Nueva Temporada $i',
                    "https://source.unsplash.com/random/200x200?sig=${Random().nextInt(100)}",
                    context);
              }),
        ],
      ),
    );
  }

  Widget eventContainer(String title, String imgURL, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                EventDetailsPage(title: title, eventImg: imgURL),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(imgURL), fit: BoxFit.cover)),
        child: Center(
          child: Text(title,
              style: GoogleFonts.sourceSansPro(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w800)),
        ),
      ),
    );
  }
}
