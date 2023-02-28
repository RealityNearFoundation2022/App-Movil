import 'package:flutter/material.dart';
import 'package:reality_near/core/framework/globals.dart';
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
      appBar: globalApppBar(context, S.current.MisPosts),
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
}
