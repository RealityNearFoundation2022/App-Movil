import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/widgets/forms/searchBar.dart';

class FriendsSolicitudesDialog extends StatelessWidget {
  FriendsSolicitudesDialog({Key key}) : super(key: key);

  TextEditingController searchUserController = TextEditingController();

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
                      Searchbar(
                          placeholder: S.current.BuscarUsuario,
                          controller: searchUserController),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return pendientesCard();
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      Searchbar(
                          placeholder: S.current.BuscarUsuario,
                          controller: searchUserController),
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

  Widget pendientesCard() {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: NetworkImage(
          "https://picsum.photos/700/400?random",
        ),
      ),
      title: Text(getRandomName()),
      subtitle: Text(S.current.CancelarSolicitud,
          style: const TextStyle(color: greenPrimary)),
    );
  }

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
                    S.current.Aceptar, () {}, context, greenPrimary2),
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
