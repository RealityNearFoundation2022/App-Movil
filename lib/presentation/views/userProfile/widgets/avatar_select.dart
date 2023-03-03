import "package:flutter/material.dart";
import 'package:reality_near/core/framework/colors.dart';

class AvatarSelect extends StatefulWidget {
  final String userAvatar;
  const AvatarSelect({Key key, this.userAvatar}) : super(key: key);

  @override
  State<AvatarSelect> createState() => _AvatarSelectState();

  //funcion para obtener el avatar seleccionado
  getAvatar() {
    for (var element in avatars) {
      if (element["select"]) {
        return element["selected"];
      }
    }
    return null;
  }
}

List<Map<String, dynamic>> avatars = [
  {
    "selected": "assets/gift/MEN_SELECTED.gif",
    "unSelected": "assets/gift/MEN_WAITING.gif",
    "select": false
  },
  {
    "selected": "assets/gift/WOMEN_SELECT.gif",
    "unSelected": "assets/gift/WOMEN_WAITING.gif",
    "select": false
  },
  {
    "selected": "assets/gift/MONSTER_SELECT.gif",
    "unSelected": "assets/gift/MONSTER_WAITING.gif",
    "select": false
  },
];

class _AvatarSelectState extends State<AvatarSelect> {
  @override
  void initState() {
    super.initState();
    for (var element in avatars) {
      if (element["selected"] == widget.userAvatar) {
        element["select"] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.26,
      child: GridView.builder(
          itemCount: avatars.length,
          padding: const EdgeInsets.only(top: 5),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 15,
              childAspectRatio: 2 / 3.5),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  for (var element in avatars) {
                    element["select"] = false;
                  }
                  avatars[index]["select"] = true;
                });
              },
              child: Container(
                // padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        width: avatars[index]["select"] ? 3 : 2,
                        color: avatars[index]["select"]
                            ? greenPrimary
                            : const Color(0xffABABAB))),
                child: Image.asset(
                  avatars[index]["select"]
                      ? avatars[index]["selected"]
                      : avatars[index]["unSelected"],
                  // fit: BoxFit.fill,
                ),
              ),
            );
          }),
    );
  }
}
