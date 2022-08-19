import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/domain/entities/user.dart';
import 'package:reality_near/domain/usecases/contacts/getContacts.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/FriendsScreen/widgets/friendChat.dart';
import 'package:reality_near/presentation/views/FriendsScreen/widgets/friendDialog.dart';
import 'package:reality_near/presentation/views/chatRoomScreen/chatRoomScreen.dart';
import 'package:reality_near/presentation/widgets/forms/searchBar.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({Key key}) : super(key: key);
  //Variables
  static String routeName = "/friendsScreen";

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<User> lstContacts = [];
  bool _loading = true;

  Future<void> _getContacts() async {
    var response = await GetContactsUseCase().call();
    setState(() {
      lstContacts = response;
      _loading = false;
    });
  }

  @override
  initState() {
    super.initState();
    _getContacts();
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
              S.current.Amigos,
              style: GoogleFonts.sourceSansPro(
                fontSize: 35,
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
        body: _loading
            ? loading()
            : Column(
                children: [
                  //Barra de busqueda
                  searchSection(),
                  //Lista de amigos conectados
                  lstContacts.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          height: 120,
                          child: FriendsConect())
                      : const SizedBox(),
                  //Lista de Chats
                  lstContacts.isNotEmpty
                      ? Expanded(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: chatList()),
                        )
                      : noContact(),
                ],
              ));
  }

  noContact() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      alignment: Alignment.center,
      child: Column(
        children: [
          //IMAGEN DE NO CONTACTOS
          const SizedBox(height: 20),
          Text(
            S.current.NoHayAmigos,
            textAlign: TextAlign.center,
            style: GoogleFonts.sourceSansPro(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: greenPrimary,
            ),
          ),
        ],
      ),
    );
  }

  loading() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LoadingAnimationWidget.dotsTriangle(
            color: greenPrimary,
            size: ScreenWH(context).width * 0.3,
          ),
          const SizedBox(height: 20),
          Text(
            S.current.Cargando,
            style: GoogleFonts.sourceSansPro(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget searchSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: Searchbar(
                placeholder: S.current.BuscarChat,
                controller: _searchController),
          ),
          const SizedBox(width: 20),
          circularbtn(() {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) => const FriendsSolicitudesDialog());
          }, Icons.person_add)
        ],
      ),
    );
  }

  Widget chatList() {
    return ListView.builder(
      itemCount: lstContacts.length,
      itemBuilder: (context, index) {
        User contact = lstContacts[index];
        return ChatCard(
          photo: contact.avatar,
          name: contact.fullName,
          message:
              "Habla Juan, estaba jugando un rato por larcomar y no creeras lo que hay por aquí",
          time: "17:46 P.M.",
        );
      },
    );
  }

  Widget FriendsConect() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: lstContacts.length,
        itemBuilder: (BuildContext context, int index) {
          User contact = lstContacts[index];
          return GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, ChatRoomScreen.routeName,
              //     arguments: {
              //       'name': getRandomName(),
              //       'photo':
              //           "https://source.unsplash.com/random/200x200?sig=$index",
              //       'empty': true
              //     });
              Navigator.pushNamed(context, '/ChatSoonScreen');
            },
            child: personCircle(contact),
          );
        });
  }

  Widget personCircle(User contact) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            // backgroundImage: NetworkImage(photo),
            child: Image.asset(
              contact.avatar,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 60,
            height: 35,
            child: Text(
              contact.fullName ?? 'null',
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
    );
  }

  Widget circularbtn(Function onPress, IconData icon) {
    return CircleAvatar(
      backgroundColor: greenPrimary,
      radius: 20,
      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        onPressed: () {
          onPress?.call();
        },
      ),
    );
  }
}
