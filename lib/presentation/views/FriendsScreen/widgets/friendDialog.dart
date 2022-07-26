import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/domain/entities/user.dart';
import 'package:reality_near/domain/usecases/contacts/DeclineRequest.dart';
import 'package:reality_near/domain/usecases/contacts/addContact.dart';
import 'package:reality_near/domain/usecases/contacts/getPending.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/widgets/forms/searchBar.dart';
import 'package:reality_near/presentation/widgets/others/snackBar.dart';

import '../../../../domain/usecases/contacts/acceptRequest.dart';
import '../../../../domain/usecases/contacts/getRequests.dart';

class FriendsSolicitudesDialog extends StatefulWidget {
  const FriendsSolicitudesDialog({Key key}) : super(key: key);

  @override
  State<FriendsSolicitudesDialog> createState() =>
      _FriendsSolicitudesDialogState();
}

class _FriendsSolicitudesDialogState extends State<FriendsSolicitudesDialog> {
  final TextEditingController searchUserController = TextEditingController();

  List<User> lstUsers = [];
  List<User> lstUsersFiltered = [];
  List<User> lstUsersRequest = [];

  Future<void> _requestRefresh() async {
    var response = await GetRequestsUseCase().call();
    setState(() {
      lstUsersRequest = response;
    });
  }

  Future<void> _pendingRefresh() async {
    var response = await GetPendingUseCase().call();
    setState(() {
      lstUsers = response;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Dialog(
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
                              child:FutureBuilder(
                                  future: GetPendingUseCase().call(),
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData) {
                                      lstUsers = snapshot.data;

                                      //Lista Filtrada de a quienes les enviamos solicitud
                                      List<User> lstSendRequest = lstUsers
                                          .where((us) => us.infContact!=null).toList();

                                      return (lstSendRequest.isNotEmpty || searchUserController.text.isNotEmpty) ? RefreshIndicator(
                                          onRefresh: _pendingRefresh,
                                          child: ListView.builder(
                                            itemCount: searchUserController.text.isEmpty
                                                      ? lstSendRequest.length
                                                      : lstUsersFiltered.length,
                                            itemBuilder: (context, index) {
                                              User user = searchUserController.text.isEmpty
                                                  ? lstSendRequest[index] : lstUsersFiltered[index];
                                              return pendientesCard(user);
                                            },
                                          )
                                      ) : ListView(
                                        children: [
                                          const SizedBox(height: 30),
                                            Center(
                                              child: Text(S.current.NoSolicitudes),
                                            ),
                                          ],
                                        );
                                    }
                                    else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            Expanded(
                              child:FutureBuilder(
                                  future: GetRequestsUseCase().call(),
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData) {
                                      lstUsersRequest = snapshot.data;
                                      return RefreshIndicator(
                                          onRefresh: _requestRefresh,
                                          child: lstUsersRequest.isNotEmpty ?
                                          ListView.builder(
                                            itemCount: lstUsersRequest.length,
                                            itemBuilder: (context, index) {
                                              User user = lstUsersRequest[index];
                                              return solicitudesCard(user,context);
                                            },
                                          ): ListView(
                                            children: [
                                              const SizedBox(height: 30),
                                              Center(
                                                child: Text(S.current.NoSolicitudes),
                                              ),
                                            ],
                                          )
                                      ) ;
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }
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
          ),
          Positioned(
            top: 10,
            right: 25,
            child: Container(
              decoration: const BoxDecoration(
                color: greenPrimary,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: IconButton(
                icon: const Icon(Icons.close, size: 30,color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
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
  Widget pendientesCard(User user) {
    bool sendRequest = user.infContact != null;
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: NetworkImage(
          "https://picsum.photos/700/400?random",
        ),
      ),
      title: Text(user.fullName ?? 'NotUsername'),
      subtitle: GestureDetector(
        onTap: () async {
          //Mostramos snackbar para avisar al cliente el resultado de la peticion y refrescamos la lista que se ve en pantalla
          sendRequest ?
            await DeclineRequestUseCase(user.infContact.id.toString()).call().then((value) => value.fold(
                  (failure) => showSnackBar(context, failure.message, true),
                  (success) =>
              {
                showSnackBar(context, 'Solicitud Denegada', false),
                sendRequest = !sendRequest
              },
            ))
          : await AddContactUseCase(user.id.toString()).call().then((value) => value.fold(
                (failure) => showSnackBar(context, failure.message, true),
                (success) =>
            {
              showSnackBar(context, 'Solicitud Enviada', false),
                sendRequest = !sendRequest
            },
            ),
          );
          _pendingRefresh();
        },
        child: Text( sendRequest ? S.current.CancelarSolicitud : S.current.EnviarSolicitud,
            style: const TextStyle(color: greenPrimary)),
      ),
    );
  }

//Widget de card de solicitud de amistad pendientes
  Widget solicitudesCard(User user,BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(
          "https://picsum.photos/700/400?random",
        ),
      ),
      title: Text(user.fullName ?? 'noUsername'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 2),
          Text(
            S.current.amigosEnComun(Random().nextInt(50)),
          ),

          const SizedBox(height: 2),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: btnsolicitud(
                    S.current.Aceptar, () async {
                      print('click en aceptar');
                      //Mostramos snackbar para avisar al cliente el resultado de la peticion y refrescamos la lista que se ve en pantalla
                      await AcceptRequestUseCase(user.infContact.id.toString()).call().then((value) => value.fold(
                            (failure) => showSnackBar(context, failure.message, true),
                            (success) =>
                            {
                                _requestRefresh(),
                                  showSnackBar(context, 'Solicitud aceptada', false)
                                },
                          ));
                }, context, greenPrimary),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: btnsolicitud(
                    S.current.Rechazar, () async {
                  print('click en rechazar');
                  //Mostramos snackbar para avisar al cliente el resultado de la peticion y refrescamos la lista que se ve en pantalla
                  await DeclineRequestUseCase(user.infContact.id.toString()).call().then((value) => value.fold(
                        (failure) => showSnackBar(context, failure.message, true),
                        (success) =>
                        {
                          _requestRefresh(),
                          showSnackBar(context, 'Solicitud Denegada', false)
                        },
                      ));
                }, context, Colors.black26),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget btnsolicitud(
      String title, Function onPerss, BuildContext context, Color color) {
    return GestureDetector(
      onTap: onPerss,
      child: Container(
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
      ),
    );
  }
}
