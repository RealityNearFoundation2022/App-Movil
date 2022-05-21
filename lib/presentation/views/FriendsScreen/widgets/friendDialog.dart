import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/presentation/widgets/forms/searchBar.dart';

class FriendsSolicitudesDialog extends StatelessWidget {
  FriendsSolicitudesDialog({Key? key}) : super(key: key);

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
              const TabBar(tabs: [
                Tab(
                  text: "Pendientes",
                ),
                Tab(
                  text: "Solicitudes",
                ),
              ]),
              Expanded(
                child: TabBarView(children: [
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      Searchbar(
                          placeholder: 'Buscar usuario ...',
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
                          placeholder: 'Buscar usuario ...',
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
    return const ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          "https://picsum.photos/700/400?random",
        ),
      ),
      title: Text("Amigo"),
      subtitle:
          Text("Cancelar Solicitud", style: TextStyle(color: greenPrimary)),
    );
  }

  Widget solicitudesCard(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: NetworkImage(
          "https://picsum.photos/700/400?random",
        ),
      ),
      title: const Text("Amigo"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("07 amigos en común",
              style: TextStyle(color: Colors.black26)),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: btnsolicitud('Aceptar', () {}, context, greenPrimary2),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: btnsolicitud('Rechazar', () {}, context, Colors.black26),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget btnsolicitud(
      String title, Function? onPerss, BuildContext context, Color? color) {
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
