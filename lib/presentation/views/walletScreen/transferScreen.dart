import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/userProfile/chatUserProfile.dart';
import 'package:reality_near/presentation/views/walletScreen/widgets/transactionDetail.dart';
import 'package:reality_near/presentation/widgets/forms/searchBar.dart';

class TransferScreen extends StatefulWidget {
  TransferScreen({Key key}) : super(key: key);
  static String routeName = "/transfer";

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController _searchController = TextEditingController();

  goToTransferDeatil(
      String img, String name, String walletId, BuildContext context) {
    Navigator.of(context).pushNamed(TransferDetail.routeName, arguments: {
      'img': img,
      'name': name,
      'walletId': walletId,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Container(
            margin: const EdgeInsets.only(right: 10),
            alignment: Alignment.centerRight,
            child: Text(
              S.current.Transferir + ' Realities',
              style: GoogleFonts.sourceSansPro(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: greenPrimary,
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: greenPrimary, size: 35),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        // body: SoonScreen(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                S.current.recientes,
                style: GoogleFonts.sourceSansPro(
                  color: txtPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            //Lista de amigos conectados
            SizedBox(height: 125, child: RecentFriends()),
            //Barra de busqueda
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Searchbar(
                  placeholder: S.current.BuscarUsuario,
                  controller: _searchController),
            ),
            // Lista de Chats
            Expanded(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: chatList()))
          ],
        ));
  }

  SoonScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/imgs/monstruoEsperando.png'),
        const SizedBox(height: 20),
        Text(
          'Próximamente podrás Transferir Realities a tus contactos',
          textAlign: TextAlign.center,
          style: GoogleFonts.sourceSansPro(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: txtPrimary,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(greenPrimary),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0))),
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 50)),
          ),
          child: Text(
            S.current.Volver,
            textAlign: TextAlign.center,
            style: GoogleFonts.sourceSansPro(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  Widget chatList() {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return Contact("https://source.unsplash.com/random/200x200?sig=$index",
            getRandomName(), "userWallet$index.testnet", context);
      },
    );
  }

  Widget Contact(
      String photo, String name, String walletId, BuildContext context) {
    return GestureDetector(
      onTap: () {
        goToTransferDeatil(photo, name, walletId, context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(photo),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    walletId,
                    style: GoogleFonts.sourceSansPro(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            options(context, photo, name, walletId),
          ],
        ),
      ),
    );
  }

  Widget options(
    BuildContext context,
    String photo,
    String name,
    String walletId,
  ) {
    return PopupMenuButton(
        icon: const Icon(Icons.more_horiz),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onSelected: (val) => {
              print('value $val'),
              if (val == 1)
                {
                  Navigator.of(context)
                      .pushNamed(UserProfile.routeName, arguments: {
                    'photo': photo,
                    'name': name,
                    'walletId': walletId,
                  })
                }
            },
        itemBuilder: (context) => const [
              PopupMenuItem(
                child: Text('Ver Perfil'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Favorito'),
                value: 2,
              ),
              PopupMenuItem(
                child: Text('Eliminar'),
                value: 3,
              ),
            ]);
  }

  Widget personCircle(
      String photo, String name, bool favorite, BuildContext context) {
    return GestureDetector(
      onTap: () {
        goToTransferDeatil(photo, name, "userWallet.testnet", context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: 70,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          color: favorite ? greenPrimary : Colors.transparent,
                          width: 2.5),
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(photo),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: favorite
                        ? Container(
                            decoration: BoxDecoration(
                              color: greenPrimary,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 20,
                            ),
                          )
                        : Container(),
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 60,
              height: 35,
              child: Text(
                name,
                style: GoogleFonts.sourceSansPro(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget RecentFriends() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {},
            child: personCircle(
                "https://source.unsplash.com/random/200x200?sig=$index",
                getRandomName(),
                index > 2 ? false : true,
                context),
          );
        });
  }
}
