import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/datasource/firebase/fs_news_service.dart';
import 'package:reality_near/data/models/fb_news_model.dart';
import 'package:reality_near/data/models/news_model.dart';
import 'package:reality_near/domain/entities/user.dart';
import 'package:reality_near/domain/usecases/news/get_news.dart';
import 'package:reality_near/domain/usecases/user/user_data.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/AR/arview.dart';
import 'package:reality_near/presentation/views/homeScreen/widgets/carrousel.dart';
import 'package:reality_near/presentation/views/homeScreen/widgets/category.dart';
import 'package:reality_near/presentation/views/homeScreen/widgets/news_widget.dart';
import 'package:reality_near/presentation/views/homeScreen/widgets/lateral_drawer.dart';
import 'package:reality_near/presentation/views/mapScreen/map_halfscreen.dart';
import 'package:reality_near/presentation/views/userProfile/profile_screen.dart';
import 'package:reality_near/presentation/widgets/dialogs/update_dialog.dart';

import '../../bloc/menu/menu_bloc.dart';

class HomeScreenV2 extends StatefulWidget {
  static String routeName = "/home";
  const HomeScreenV2({Key key}) : super(key: key);

  @override
  State<HomeScreenV2> createState() => _HomeScreenV2State();
}

class _HomeScreenV2State extends State<HomeScreenV2> {
  // List<NewsModel> news = [];
  List<fsNewsModel> news = [];
  List<fsNewsModel> carrousselNews = [];
  User user;
  bool load_user = true;
  //Scaffold key
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  void initState() {
    getUserData();
    getNews();
    checkUpdate();
    super.initState();
  }

  // getNews() async {
  //   await GetNews().call().then((value) => setState(() {
  //         news =
  //             value.where((element) => element.planners != 'Banners').toList();
  //       }));
  // }
  getNews() async {
    await FsNewsService().getNews().then((value) => setState(() {
          carrousselNews = value.where((element) => element.pinned).toList();
          news = value;
        }));
  }

  checkUpdate() async {
    var lastVersion = await getPreference("last_version") ?? 0;
    var version = await getPreference("current_version") ?? 0;
    var minVersion = await getPreference("min_version") ?? 0;

    int lastVersionInt = int.parse(lastVersion.toString().replaceAll('.', ''));
    int versionInt = int.parse(version.toString().replaceAll('.', ''));
    int minVersionInt = int.parse(minVersion.toString().replaceAll('.', ''));

    if (version != 0) {
      if (lastVersionInt > versionInt) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: ((context) => UpdateDialog(
                  requiredUpdate: minVersionInt > versionInt,
                )));
      }
    }
  }

  getUserData() async {
    UserData(context).get().then((value) => setState(() {
          user = value;
          load_user = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const LateralDrawer(),
      drawerEnableOpenDragGesture: false,
      backgroundColor: Colors.white,
      appBar: _header(),
      body: _body(),
    );
  }

  _body() {
    return GestureDetector(
        dragStartBehavior: DragStartBehavior.start,
        onHorizontalDragStart: (details) {
          if (details.localPosition.dx <
                  MediaQuery.of(context).size.width / 2 &&
              details.localPosition.dy >
                  MediaQuery.of(context).size.height * 0.25) {
            gotoAR();
          } else if (details.localPosition.dx <
                  MediaQuery.of(context).size.width / 3 &&
              details.localPosition.dy <
                  MediaQuery.of(context).size.height * 0.25) {
            //Open drawer
            _key.currentState.openDrawer();
          }
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SectionCarousel(newsCarrousel: carrousselNews),
                  const SizedBox(height: 10),
                  //button
                  noticias(),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12 -
                          MediaQuery.of(context).viewPadding.bottom +
                          10),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _bottomBar(),
            )
          ],
        ));
  }

  noticias() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          buildCategory(S.current.Novedades, greenPrimary, size, () {}),
          const SizedBox(height: 10),
          SizedBox(
            width: size.width,
            // height: size.height * 0.23,
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: news.length,
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    NewsWidget(news: news[i]),
                    const SizedBox(height: 10),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _header() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: MediaQuery.of(context).size.height * 0.11,
      leading: Builder(builder: (context) {
        return Container(
          margin: const EdgeInsets.only(left: 10, top: 8),
          child: IconButton(
            iconSize: MediaQuery.of(context).size.height * 0.058,
            icon: SizedBox(
              height: MediaQuery.of(context).size.height * 0.058,
              width: MediaQuery.of(context).size.height * 0.058,
              child: Icon(
                Icons.menu_rounded,
                color: greenPrimary,
                size: MediaQuery.of(context).size.height * 0.05,
              ),
            ),
            onPressed: () =>
                Scaffold.of(context).openDrawer(), // <-- Opens drawer.
          ),
        );
      }),
      title: Image.asset(
        'assets/imgs/Logo_sin_fondo.png',
        height: MediaQuery.of(context).size.height * 0.09,
      ),
      centerTitle: true,
      actions: [
        _notificatios(0),
      ],
    );
  }

  gotoAR() {
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: const ARSection(
          scene: "Vuforia",
        ),
      ),
    ));
  }

  _bottomBar() {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        return Container(
          height: state is MenuMapaState
              ? MediaQuery.of(context).size.height * 0.5
              : MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.width,
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 12, top: 10),
          decoration: BoxDecoration(
            color: state is MenuMapaState ? Colors.transparent : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 10,
                blurRadius: 15,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state is MenuMapaState
                  ? const SizedBox()
                  : IconButton(
                      padding: const EdgeInsets.only(top: 10),
                      iconSize: MediaQuery.of(context).size.height * 0.04,
                      icon: const Icon(
                        FontAwesomeIcons.camera,
                        color: greenPrimary,
                      ),
                      onPressed: () {
                        // navigate to CameraScreen
                        gotoAR();
                      },
                    ),
              state is MenuMapaState
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: GestureDetector(
                        onTap: () {
                          // navigate to ProfileScreen
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ProfileScreen()));
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: greenPrimary.withOpacity(0.1),
                          child: load_user
                              ? Center(
                                  child: LoadingAnimationWidget.dotsTriangle(
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Image.asset(
                                    user.avatar,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    ),
              // const MapContainer(),
              IconButton(
                padding: const EdgeInsets.only(top: 10),
                iconSize: MediaQuery.of(context).size.height * 0.055,
                icon: const Icon(
                  Icons.map_rounded,
                  color: greenPrimary,
                ),
                onPressed: () {
                  // show modal bottom sheet
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: false,
                    //border
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    builder: (context) => const MapBoxScreen(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _notificatios(int numNotifications) {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, "/notifications");
      },
      iconSize: MediaQuery.of(context).size.height * 0.053,
      icon: SizedBox(
        height: MediaQuery.of(context).size.height * 0.053,
        width: MediaQuery.of(context).size.height * 0.053,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Icon(
              Icons.notifications,
              color: greenPrimary,
              size: MediaQuery.of(context).size.height * 0.045,
            ),
            numNotifications > 0
                ? Positioned(
                    top: 1.5,
                    right: 2,
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
      ),
    );
  }
}
