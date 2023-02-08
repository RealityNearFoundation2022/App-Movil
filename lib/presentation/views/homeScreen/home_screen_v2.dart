import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/data/models/news_model.dart';
import 'package:reality_near/domain/usecases/news/get_news.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/AR/arview.dart';
import 'package:reality_near/presentation/views/homeScreen/widgets/carrousel.dart';
import 'package:reality_near/presentation/views/homeScreen/widgets/category.dart';
import 'package:reality_near/presentation/views/homeScreen/widgets/news_widget.dart';
import 'package:reality_near/presentation/views/homeScreen/widgets/social_grid.dart';
import 'package:reality_near/presentation/views/lateralBar/lateral_drawer.dart';
import 'package:reality_near/presentation/views/mapScreen/map_button.dart';
import 'package:reality_near/presentation/views/mapScreen/new_map.dart';

import '../../bloc/menu/menu_bloc.dart';

class HomeScreenV2 extends StatefulWidget {
  static String routeName = "/home";
  const HomeScreenV2({Key key}) : super(key: key);

  @override
  State<HomeScreenV2> createState() => _HomeScreenV2State();
}

class _HomeScreenV2State extends State<HomeScreenV2> {
  List<NewsModel> news = [];
  //Scaffold key
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    await GetNews().call().then((value) => setState(() {
          news = value;
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
      // bottomNavigationBar: _bottomBar()
    );
  }

  _body() {
    return GestureDetector(
        onHorizontalDragStart: (details) {
          if (details.globalPosition.dy > 200) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ARSection()));
          } else {
            //open drawer with scaffold key
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
                  const SectionCarousel(),
                  const SizedBox(height: 10),
                  novedadesCarrousel(),
                  const SizedBox(height: 10),
                  social(),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1 + 10),
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

  novedadesCarrousel() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          buildCategory(S.current.Novedades, greenPrimary, size),
          SizedBox(
            width: size.width,
            height: size.height * 0.23,
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: news.length,
              itemBuilder: (context, i) {
                return NewsWidget(news: news[i]);
              },
            ),
          ),
        ],
      ),
    );
  }

  social() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          buildCategory('Reality Social', greenPrimary, size),
          const SizedBox(height: 10),
          const SocialGrid()
        ],
      ),
    );
  }

  _header() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      leading: Builder(builder: (context) {
        return IconButton(
          iconSize: MediaQuery.of(context).size.height * 0.05,
          icon: const Icon(
            Icons.menu_rounded,
            color: greenPrimary,
          ),
          onPressed: () =>
              Scaffold.of(context).openDrawer(), // <-- Opens drawer.
        );
      }),
      title: Image.asset(
        'assets/imgs/Logo_sin_fondo.png',
        height: MediaQuery.of(context).size.height * 0.111,
      ),
      centerTitle: true,
      actions: [
        _notificatios(0),
      ],
    );
  }

  _bottomBar() {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        return Container(
          height: state is MenuMapaState
              ? MediaQuery.of(context).size.height * 0.5
              : MediaQuery.of(context).size.height * 0.09,
          width: MediaQuery.of(context).size.width,
          color: state is MenuMapaState ? Colors.transparent : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              state is MenuMapaState
                  ? const SizedBox()
                  : IconButton(
                      iconSize: MediaQuery.of(context).size.height * 0.04,
                      icon: const Icon(
                        FontAwesomeIcons.camera,
                        color: greenPrimary,
                      ),
                      onPressed: () {
                        // navigate to CameraScreen
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ARSection()));
                      },
                    ),
              state is MenuMapaState
                  ? const SizedBox()
                  : IconButton(
                      iconSize: MediaQuery.of(context).size.height * 0.07,
                      icon: CircleAvatar(
                        radius: 40,
                        backgroundColor: greenPrimary.withOpacity(0.2),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset(
                            "assets/gift/MEN_SELECTED.gif",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      onPressed: () {},
                    ),
              // const MapContainer(),
              IconButton(
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
      iconSize: MediaQuery.of(context).size.height * 0.058,
      icon: SizedBox(
        height: MediaQuery.of(context).size.height * 0.058,
        width: MediaQuery.of(context).size.height * 0.058,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Icon(
              Icons.notifications,
              color: greenPrimary,
              size: MediaQuery.of(context).size.height * 0.05,
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
