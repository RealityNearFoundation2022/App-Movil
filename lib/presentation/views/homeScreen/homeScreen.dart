import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/domain/usecases/notifications/getNotifications.dart';
import 'package:reality_near/presentation/bloc/menu/menu_bloc.dart';
import 'package:reality_near/presentation/views/noAR/no_ar_section.dart';
import 'package:reality_near/presentation/views/mapScreen/mapScreen.dart';
import 'package:reality_near/presentation/views/menuScreen/menuScreen.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:upgrader/upgrader.dart';
import '../../../data/repository/userRepository.dart';
import '../../../domain/entities/user.dart';
import '../../widgets/dialogs/permissions_dialog.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool status = false;
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final GlobalKey _three = GlobalKey();
  bool passInitGuide;
  int notifications = 0;

  User user = User();

  _viewGuide() async {
    (await getPersistData('passInitGuide') == null &&
            await getPersistData('userToken') != null)
        ? WidgetsBinding.instance.addPostFrameCallback(
            (_) =>
                ShowCaseWidget.of(context).startShowCase([_one, _two, _three]),
          )
        : null;
  }

  _getNewNotifications() async {
    await GetNotifications().call().then((value) => value.fold(
        (l) => print('Error: ${l.toString()}'),
        (r) => setState(() => notifications = r)));
  }

  _getUserData() {
    UserRepository().getMyData().then((value) => value.fold(
          // ignore: avoid_print
          (failure) => print(failure),
          (success) => {
            setState(() {
              user = success;
            }),
          },
        ));
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      status = false;
    });
    BlocProvider.of<MenuBloc>(context, listen: false).add(MenuCloseEvent());
    _viewGuide();
    _getNewNotifications();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(builder: ((context, state) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: UpgradeAlert(
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      bottom: 20, top: ScreenWH(context).height * 0.13),
                  height: ScreenWH(context).height * 0.95,
                  width: ScreenWH(context).width,
                  child: const NoArSection(),
                ),
                //Header
                header(),
                // bottomBar(),
                //Map-Button
                Positioned(
                    bottom: MediaQuery.of(context).viewPadding.bottom,
                    left: MediaQuery.of(context).viewPadding.left,
                    child: MapContainer(
                      showCaseKey: _two,
                    )),
                //Camera-Button
                Positioned(
                    //centers
                    bottom: MediaQuery.of(context).viewPadding.bottom + 20,
                    left: MediaQuery.of(context).size.width * 0.5 -
                        ScreenWH(context).height * 0.04,
                    child: cameraBtn()),
                //Menu-Button
                Positioned(
                    bottom: MediaQuery.of(context).viewPadding.bottom,
                    right: MediaQuery.of(context).viewPadding.right,
                    child: MenuContainer(
                      showCaseKey: _one,
                    )),
                //Notifications
                Positioned(
                    top: MediaQuery.of(context).viewPadding.top + 10,
                    right: MediaQuery.of(context).viewPadding.right + 15,
                    child: _notificatios(notifications)),
                //Scanner QR
                user.isSuperuser ?? false
                    ? Positioned(
                        top: MediaQuery.of(context).viewPadding.top,
                        left: MediaQuery.of(context).size.height * 0.03,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/qrScannScreen');
                          },
                          icon: Icon(
                            Icons.qr_code_scanner_outlined,
                            color: greenPrimary,
                            size: ScreenWH(context).height * 0.04,
                          ),
                        ))
                    : Container(),
              ],
            ),
          ),
        ),
      );
    }));
  }

  cameraBtn() {
    return BlocBuilder<MenuBloc, MenuState>(builder: ((context, state) {
      return state is MenuPrincipalState || state is MenuMapaState
          ? const SizedBox()
          : Showcase(
              key: _three,
              overlayPadding: const EdgeInsets.all(12),
              radius: BorderRadius.circular(100),
              contentPadding: const EdgeInsets.all(15),
              title: 'AR Switch',
              description:
                  "Al seleccionar esta opcion, podras entrar en contacto con los objetos de realidad aumentada que forman parte de los eventos y actividades",
              showcaseBackgroundColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
              titleTextStyle: GoogleFonts.sourceSansPro(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              descTextStyle: GoogleFonts.sourceSansPro(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              shapeBorder: const CircleBorder(),
              child: GestureDetector(
                onTap: () async {
                  (await Permission.location.isGranted &&
                          await Permission.camera.isGranted)
                      ? Navigator.pushNamed(context, "/arView")
                      : showDialog(
                          context: context,
                          builder: (context) => const PermissionsDialog());
                },
                child: Container(
                  height: ScreenWH(context).height * 0.08,
                  width: ScreenWH(context).height * 0.08,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 5),
                      ),
                    ],
                    color: greenPrimary,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: ScreenWH(context).height * 0.05,
                  ),
                ),
              ),
            );
    }));
  }

  _notificatios(int numNotifications) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/notifications");
      },
      child: Stack(
        children: [
          Icon(
            Icons.notifications,
            color: greenPrimary,
            size: ScreenWH(context).height * 0.05,
          ),
          numNotifications > 0
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10,
                    child: Text(
                      numNotifications.toString(),
                      style: GoogleFonts.sourceSansPro(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget header() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      width: double.infinity,
      child: Column(
        children: [
          // const SizedBox(height: 10,),
          Image.asset(
            "assets/imgs/Logo_sin_fondo.png",
            width: ScreenWH(context).width * 0.45,
            height: ScreenWH(context).height * 0.12,
          ),
        ],
      ),
    );
  }
}
