import 'package:flutter/material.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/repository/user_repository.dart';
import 'package:reality_near/data/models/user_model.dart';
import 'package:reality_near/presentation/views/login/no_avatar_screen.dart';

class UserData {
  BuildContext context;
  UserData(this.context);

  final UserRepository repository = UserRepository();
  Future<UserModel> get() async {
    var userjson = await getPreference('user');
    var user = UserModel().userModelFromJson(userjson);
    // bool currentUserComplete = await getPreference('username') != null &&
    //     await getPreference('usAvatar') != null &&
    //     await getPreference('userId') != null;
    // if (!currentUserComplete) {
    //   await repository.getMyData().then((value) => value.fold(
    //         (failure) => print(failure),
    //         (success) => success.avatar.isEmpty
    //             ? Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (context) => NoAvatarScreen(
    //                           user: success,
    //                         )),
    //               )
    //             : {
    //                 setPreference('username', success.username),
    //                 setPreference('userId', success.id.toString()),
    //                 setPreference('usAvatar', success.avatar),
    //                 setPreference('superUser', success.isSuperuser),
    //               },
    //       ));
    // }
    // String _fullName = await getPreference('username');
    // String _avatar = await getPreference('usAvatar');
    // int _id = int.parse(await getPreference('userId'));
    // bool isSuperUser = await getPreference('superUser');

    return user;
  }

  // refresh() async {
  //   await repository.getMyData().then((value) => value.fold(
  //         (failure) => print(failure),
  //         (success) => success.avatar.isEmpty
  //             ? Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => NoAvatarScreen(
  //                           user: success,
  //                         )),
  //               )
  //             : {
  //                 setPreference('username', success.username),
  //                 setPreference('userId', success.id.toString()),
  //                 setPreference('usAvatar', success.avatar),
  //               },
  //       ));
  // }
}
