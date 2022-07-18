import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/repository/userRepository.dart';
import 'package:reality_near/domain/entities/user.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/widgets/forms/searchBar.dart';

class FriendsSolicitudesDialog extends StatefulWidget {
  FriendsSolicitudesDialog({Key key}) : super(key: key);

  @override
  State<FriendsSolicitudesDialog> createState() =>
      _FriendsSolicitudesDialogState();
}

class _FriendsSolicitudesDialogState extends State<FriendsSolicitudesDialog> {
  final TextEditingController searchUserController = TextEditingController();

  List<User> lstUsers = [];

  List<User> lstUsersFiltered = [];

  @override
  void initState() {
    super.initState();
    //obtenemos lista de usuarios
    UserRepository().getUsers().then((value) => value.fold(
          (failure) => print(failure),
          (success) => {
            setState(() {
              lstUsers = success;
            })
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(tabs: [
                Tab(
                  text: S.current.Pendientes,
                ),
                Tab(
                  text: S.current.Solicitudes,
                ),
              ]),
              Expanded(
                child: TabBarView(children: [
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      buildSearch(),
                      Expanded(
                        child: ListView.builder(
                          itemCount: searchUserController.text.isEmpty
                              ? 10
                              : lstUsersFiltered.length,
                          itemBuilder: (context, index) {
                            final username = searchUserController.text.isEmpty
                                ? getRandomName()
                                : lstUsersFiltered[index].fullName ??
                                    'username';
                            return pendientesCard(username);
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return solicitudesCard(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //crea widget de barra de busqueda
  Widget buildSearch() => Searchbar(
      placeholder: S.current.BuscarUsuario,
      controller: searchUserController,
      onChanged: searchUser);

  //funcion que filtra la lista segun lo que se escribe en la barra de busqueda
  void searchUser(String query) {
    final users = lstUsers.where((user) {
      final username = (user.fullName ?? '').toLowerCase();
      final searchLower = searchUserController.text.toLowerCase();

      return username.contains(searchLower);
    }).toList();

    setState(() {
      lstUsersFiltered = users;
    });
  }

//Widget de card de solicitud de amistad enviadas
  Widget pendientesCard(String username) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: NetworkImage(
          "https://picsum.photos/700/400?random",
        ),
      ),
      title: Text(username),
      subtitle: Text(S.current.CancelarSolicitud,
          style: const TextStyle(color: greenPrimary)),
    );
  }

//Widget de card de solicitud de amistad pendientes
  Widget solicitudesCard(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: NetworkImage(
          "https://picsum.photos/700/400?random",
        ),
      ),
      title: Text(getRandomName()),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            S.current.amigosEnComun(Random().nextInt(50)),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: btnsolicitud(
                    S.current.Aceptar, () {}, context, greenPrimary),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: btnsolicitud(
                    S.current.Rechazar, () {}, context, Colors.black26),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget btnsolicitud(
      String title, Function onPerss, BuildContext context, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: color,
      ),
      width: ScreenWH(context).width * 0.16,
      height: 25,
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.sourceSansPro(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
