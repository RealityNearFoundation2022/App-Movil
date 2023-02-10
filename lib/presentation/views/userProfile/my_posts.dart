import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/social/widget/social_grid.dart';

class MyPostsScreen extends StatefulWidget {
  static String routeName = "/MyPosts";

  const MyPostsScreen({Key key}) : super(key: key);

  @override
  State<MyPostsScreen> createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(S.current.MisPosts),
      body: _body(),
    );
  }

  _body() {
    return const SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Expanded(
              child: SocialGrid(
            numElements: 5,
          ))),
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
}
