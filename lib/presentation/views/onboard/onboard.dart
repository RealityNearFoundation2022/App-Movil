import 'package:flutter/material.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/domain/entities/onboard_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
  static String routeName = "/onBoard";
}

class _OnBoardState extends State<OnBoard> {
  int currentIndex = 0;
  late PageController _pageController;
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      img: 'assets/imgs/img-1.png',
      text: "Belajar Dengan Metode Learning by Doing",
      desc:
          "Sebuah metode belajar yang terbuktiampuh dalam meningkatkan produktifitas belajar, Learning by Doing",
      bg: Colors.white,
      button: greenPrimary,
    ),
    OnboardModel(
      img: 'assets/imgs/img-2.png',
      text: "Dapatkan Kemudahan Akses Kapanpun dan Dimanapun",
      desc:
          "Tidak peduli dimanapun kamu, semua kursus yang telah kamu ikuti bias kamu akses sepenuhnya",
      bg: greenPrimary,
      button: Colors.white,
    ),
    OnboardModel(
      img: 'assets/imgs/img-3.png',
      text: "Gunakan Fitur Kolaborasi Untuk Pengalaman Lebih",
      desc:
          "Tersedia fitur Kolaborasi dengan tujuan untuk mengasah skill lebih dalam karena bias belajar bersama",
      bg: Colors.white,
      button: greenPrimary,
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentIndex % 2 == 0 ? Colors.white : greenPrimary,
      appBar: AppBar(
        backgroundColor: currentIndex % 2 == 0 ? Colors.white : greenPrimary,
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              _storeOnboardInfo();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', ModalRoute.withName('/'));
            },
            child: Text(
              "Saltar",
              style: TextStyle(
                color: currentIndex % 2 == 0 ? Colors.black : Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: PageView.builder(
            itemCount: screens.length,
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(screens[index].img),
                  Text(
                    screens[index].text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: index % 2 == 0 ? Colors.black : Colors.white,
                    ),
                  ),
                  Text(
                    screens[index].desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Montserrat',
                      color: index % 2 == 0 ? Colors.black : Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                    child: ListView.builder(
                      itemCount: screens.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                width: currentIndex == index ? 25 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: currentIndex == index
                                      ? Colors.black26
                                      : Colors.black12,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ]);
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      print(index);
                      if (index == screens.length - 1) {
                        await _storeOnboardInfo();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/home', ModalRoute.withName('/'));
                      }

                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.bounceIn,
                      );
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            color: index % 2 == 0 ? greenPrimary : Colors.white,
                            borderRadius: BorderRadius.circular(50.0)),
                        child: Icon(
                          Icons.arrow_forward_sharp,
                          color: index % 2 == 0 ? Colors.white : greenPrimary,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
