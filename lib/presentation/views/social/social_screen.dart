import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/social/widget/social_grid.dart';

class SocialScreen extends StatefulWidget {
  static String routeName = "/RealitySocial";

  const SocialScreen({Key key}) : super(key: key);

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar('Social'),
      body: _body(),
    );
  }

  _appBar(String title) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 30,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: greenPrimary,
          size: 30,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        title,
        style: GoogleFonts.sourceSansPro(
          color: greenPrimary,
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SvgPicture.asset(
            'assets/icons/logo.svg',
            color: greenPrimary,
            height: 35,
          ),
        )
      ],
    );
  }

  _body() {
    // tab General and friends
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  unselectedLabelColor: txtGrey,
                  labelColor: Colors.white,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50), // Creates border
                      color: greenPrimary),
                  tabs: [
                    Tab(
                      child: Text(
                        S.current.Amigos,
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "General",
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const Expanded(
                  child: TabBarView(children: [
                    SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: SocialGrid(numElements: 20)),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: SocialGrid(numElements: 13)),
                    ),
                  ]),
                ),
              ],
            )),
      ),
    );
  }
}