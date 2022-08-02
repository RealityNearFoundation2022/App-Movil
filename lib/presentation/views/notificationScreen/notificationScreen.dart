import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/models/notificationModel.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNotificatonHis();
  }

  @override
  void dispose() {
    super.dispose();
    _readNotifications();
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
    ReadNotifications(_notifications).call().then((value) =>
        value.fold((l) => print('Error: ${l.toString()}'), (r) => {}));
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
          onPressed: () => Navigator.pushNamed(context, "/home"),
        ),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          width: ScreenWH(context).width,
          height: ScreenWH(context).height,
          child: _notifications.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  itemCount: _notifications.length,
                  itemBuilder: (context, index) {
                    return _notificationWidget(_notifications[index]);
                  },
                  separatorBuilder: (context, index) => const Divider(),
                )
              : const Center(child: CircularProgressIndicator())),
    );
  }

  _notificationWidget(NotificationModel notification) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: const NetworkImage(
            "https://source.unsplash.com/random/200x200?sig=1"),
        radius: ScreenWH(context).width * 0.08,
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
