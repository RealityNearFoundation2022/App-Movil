import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:reality_near/data/datasource/nearRPC/contracts.dart';
import 'package:reality_near/data/models/news_model.dart';
import 'package:reality_near/data/repository/userRepository.dart';
import 'package:reality_near/domain/entities/user.dart';
import 'package:reality_near/domain/usecases/news/get_news.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/noAR/widgets/news_widget.dart';
import 'package:reality_near/presentation/views/noAR/widgets/category.dart';
import 'package:reality_near/presentation/views/noAR/widgets/details_page.dart';
import 'package:reality_near/presentation/views/userProfile/ProfileScreen.dart';
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
  List<NewsModel> news = [];
  List<String> eventTitles = [
    "Bienvenido a Reality Near",
    "ALFA TESTING",
    "INKA FC 35"
  ];
  List<String> eventContent = [
    "Esta aplicación combina la realidad con el metaverso generando una experiencia completamente inmersiva y valiosa. Desde la cámara de tu teléfono podrás interactuar con contenido en realidad aumentada por distintas partes del mundo. Vive esta experiencia donde podrás realizar misiones, capturar tesoros, ganar recompensas, participar de eventos, hacer amigos, entre muchas otras cosas más! ",
    "¡Ya salió el Alfa Testing de Reality Near! Anímate a probar esta versión demo donde podrás ser parte de esta primera experiencia entre mundos. Conoce y familiarízate con las utilidades y funciones de nuestra aplicación, coméntanos qué es lo que más te gustó y qué deberías mejorar. Ayúdanos a crecer y crear un mejor experiencia para ti, ¡tu opinión es muy importante!",
    "El mundo real se fusiona con el virtual en una búsqueda de tesoros que pondrá a prueba todas tus habilidades. La búsqueda y atención serán primordiales para aumentar las posibilidades de ganar diversos premios. En el evento, se encontrarán figuras en realidad aumentada dispersas por todo el lugar. Los usuarios, a través de la cámara de su celular, podrán visualizar, interactuar e incluso capturar las figuras. Con estas podrás canjear premios tales como: descuentos en la academia, entradas para próximos campeonatos, merchandising, entre otros. "
  ];
  List<String> eventImgs = [
    "assets/imgs/imgAlfaTest.png",
    "assets/imgs/imgBienvenida.png",
    "assets/imgs/flyerInkaFC.png"
  ];
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getWalletData();
    getUserData();
    getNews();
  }

  getWalletData() async {
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
  }

  getUserData() {
    UserRepository().getMyData().then((value) => value.fold(
          (failure) => print(failure),
          (success) => {
            persistData('username', success.fullName),
            persistData('userId', success.id.toString()),
            setState(() {
              user = success;
            }),
            persistData('usAvatar', user.avatar)
          },
        ));
  }

  getNews() async {
    await GetNews().call().then((value) => setState(() {
          news = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: userSection(context),
          ),
          const SizedBox(height: 25),
          eventsSection(context),
          // newsCarrousel(context),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        ],
      );
    });
  }

  Widget userSection(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProfileScreen.routeName);
          },
          child: CircleAvatar(
            radius: (ScreenWH(context).width * 0.25) / 2,
            child: user.path != null
                ? Image.asset(
                    user.avatar,
                    fit: BoxFit.cover,
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
          ),
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
                        builder: (context) => SyncWalletDialog(
                              onLogin: () {
                                Navigator.pop(context);
                              },
                            )),
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
        SizedBox(
          width: size.width,
          height: size.height * 0.23,
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: news.length,
            itemBuilder: (context, i) {
              return NewsWidget(news: news[i]);
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
                    eventTitles[i], eventImgs[i], eventContent[i], context);
              }),
        ],
      ),
    );
  }

  Widget eventContainer(
      String title, String imgURL, String content, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EventDetailsPage(
                title: title, eventImg: imgURL, eventContent: content),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: MediaQuery.of(context).size.height * 0.16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: AssetImage(imgURL),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.darken))),
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
