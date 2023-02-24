import 'package:flutter/material.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/repository/user_repository.dart';
import 'package:reality_near/domain/entities/user.dart';
import 'package:reality_near/presentation/views/login/no_avatar_screen.dart';

class UserData {
  BuildContext context;
  UserData(this.context);

  final UserRepository repository = UserRepository();
  get() async {
    bool currentUserComplete = await getPreference('username') != null &&
        await getPreference('usAvatar') != null &&
        await getPreference('userId') != null;
    if (currentUserComplete) {
      String _fullName = await getPreference('username');
      String _avatar = await getPreference('usAvatar');
      int _id = int.parse(await getPreference('userId'));

      return User(
        id: _id,
        fullName: _fullName,
        avatar: _avatar,
      );
    } else {
      await repository.getMyData().then((value) => value.fold(
            (failure) => print(failure),
            (success) => {
              success.avatar.isEmpty
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NoAvatarScreen(
                                user: success,
                              )),
                    )
                  : {
                      setPreference('username', success.fullName),
                      setPreference('userId', success.id.toString()),
                      setPreference('usAvatar', success.avatar),
                    }
            },
          ));
    }
  }

  refresh() async {
    await repository.getMyData().then((value) => value.fold(
          (failure) => print(failure),
          (success) => {
            success.avatar.isEmpty
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NoAvatarScreen(
                              user: success,
                            )),
                  )
                : {
                    setPreference('username', success.fullName),
                    setPreference('userId', success.id.toString()),
                    setPreference('usAvatar', success.avatar),
                  }
          },
        ));
  }
}
