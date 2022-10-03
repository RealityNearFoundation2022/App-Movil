import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/models/cuponModel.dart';
import 'package:reality_near/data/models/notificationModel.dart';
import 'package:reality_near/domain/usecases/cuppons/getCuponsFromUser.dart';
import 'package:reality_near/domain/usecases/notifications/getNotificationsHistory.dart';
import 'package:reality_near/domain/usecases/notifications/readNotifications.dart';
import 'package:reality_near/generated/l10n.dart';

class NotificationScreen extends StatefulWidget {
  static String routeName = "/notifications";
  const NotificationScreen({Key key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _loadingNotifications = true;
  List<NotificationModel> _notifications = [];
  List<CuponModel> _cupones = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNotificatonHis();
    _getCupons();
  }

  _getNotificatonHis() async {
    await GetNotificationsHistory().call().then((value) => value.fold(
        (l) => print('Error: ${l.toString()}'),
        (r) => setState(() {
              _loadingNotifications = false;
              _notifications = r;
            })));
  }

  _readNotifications() async {
    print('READ NOTIFICATIONS');
    await ReadNotifications(_notifications).call().then((value) =>
        value.fold((l) => print('Error: ${l.toString()}'), (r) => {}));
  }

  _getCupons() async {
    await GetCuponsFromUserUseCase().call().then((value) => setState(() {
          _cupones = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _readNotifications();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Container(
            margin: const EdgeInsets.only(right: 10),
            alignment: Alignment.centerRight,
            child: Text(
              S.current.Notificaciones,
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
            onPressed: () => {
              _readNotifications(),
              Navigator.pushNamed(context, "/home")},
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              width: ScreenWH(context).width,
              height: ScreenWH(context).height,
              child: Column(
                children: [
                  _cuponSection(),
                  const Divider(),
                  _loadingNotifications
                      ? const Center(child: CircularProgressIndicator())
                      : _notifications.isEmpty
                          ? _sinNotificaciones()
                          : ListView.separated(
                              shrinkWrap: true,
                              itemCount: _notifications.length,
                              itemBuilder: (context, index) {
                                return _notificationWidget(_notifications[index]);
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                            ),
                ],
              )),
        ),
      ),
    );
  }

  _sinNotificaciones() {
    return Center(
        child: Text(
      S.current.NoTinesNotificaciones,
      style: GoogleFonts.sourceSansPro(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: txtPrimary,
      ),
    ));
  }

  _cuponSection() {
    return _cupones.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: _cupones.length,
            itemBuilder: (context, index) {
              return _notificationQRWidget(_cupones[index]);
            })
        : Container();
  }

  _notificationQRWidget(CuponModel cupon) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, "/qrViewScreen",
            arguments: <String, Object>{
              "cuponId": cupon.id,
            });
      },
      leading: CircleAvatar(
        backgroundColor: greenPrimary,
        radius: ScreenWH(context).width * 0.08,
        child: Icon(
          Icons.qr_code,
          color: Colors.white,
          size: ScreenWH(context).width * 0.08,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cupon.name,
                  style: GoogleFonts.sourceSansPro(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: greenPrimary,
                  )),
              Text(
                'Reality Near Org.',
                style: GoogleFonts.sourceSansPro(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: greenPrimary2,
                ),
              ),
            ],
          ),
          const CircleAvatar(
            backgroundColor: greenPrimary,
            radius: 5,
          )
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            convertDateTimeToString(cupon.expiration),
            style: GoogleFonts.sourceSansPro(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  _notificationWidget(NotificationModel notification) {
    return ListTile(
      leading: CircleAvatar(
        radius: ScreenWH(context).width * 0.08,
        child: Icon(
          Icons.person,
          color: Colors.white,
          size: ScreenWH(context).width * 0.08,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(notification.type,
                  style: GoogleFonts.sourceSansPro(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: greenPrimary,
                  )),
              Text(
                notification.data.username,
                style: GoogleFonts.sourceSansPro(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: greenPrimary2,
                ),
              ),
            ],
          ),
          notification.read == 0
              ? const CircleAvatar(
                  backgroundColor: greenPrimary,
                  radius: 5,
                )
              : const SizedBox()
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '31/05/2022 09:52',
            style: GoogleFonts.sourceSansPro(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
