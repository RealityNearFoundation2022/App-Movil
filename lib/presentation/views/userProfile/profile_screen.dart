import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/repository/userRepository.dart';
import 'package:reality_near/domain/entities/user.dart';
import 'package:reality_near/domain/usecases/contacts/getContacts.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/homeScreen/widgets/category.dart';
import 'package:reality_near/presentation/views/login/no_avatar_screen.dart';
import 'package:reality_near/presentation/views/social/widget/social_grid.dart';
import 'package:reality_near/presentation/widgets/forms/textForm.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);
  static String routeName = "/ProfileScreen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User user = User();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  List<bool> avatarSelect = [false, false, false];

  String pathSelectedAvatar = "";
  // bool loadSaveData = false;
  List<String> pathAvatarSelected = [
    "assets/gift/MEN_SELECTED.gif",
    "assets/gift/WOMEN_SELECT.gif",
    "assets/gift/MONSTER_SELECT.gif"
  ];
  List<String> pathAvatarNoSelect = [
    "assets/gift/MEN_WAITING.gif",
    "assets/gift/WOMEN_WAITING.gif",
    "assets/gift/MONSTER_WAITING.gif"
  ];

  List<User> lstContacts = [];

  // Future<void> getContacts() async {
  //   var response = await GetContactsUseCase().call();
  //   setState(() {
  //     lstContacts = response;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    getUserData().then((value) => setState(() {}));
    // getContacts();
  }

  bool loading = true;

  getUserData() async {
    bool _CurrentUserComplete = await getPreference('username') != null &&
        await getPreference('usAvatar') != null &&
        await getPreference('userId') != null;
    if (_CurrentUserComplete) {
      String _fullName = await getPreference('username');
      String _avatar = await getPreference('usAvatar');
      int _id = int.parse(await getPreference('userId'));

      user = User(
        id: _id,
        fullName: _fullName,
        avatar: _avatar,
      );
      loading = false;
    } else {
      await UserRepository().getMyData().then((value) => value.fold(
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
                      user = success,
                      setPreference('usAvatar', user.avatar),
                      loading = false
                    }
            },
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(
          S.current.perfil,
        ),
        body: _body());
  }

  _body() {
    return loading
        ? loadScreen()
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  _userSection(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  buildCategory(S.current.Coleccionables, greenPrimary,
                      MediaQuery.of(context).size, () {}),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  buildCategory(S.current.MisPosts, greenPrimary,
                      MediaQuery.of(context).size, () {
                    Navigator.pushNamed(context, '/MyPosts');
                  }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  const SocialGrid(numElements: 5),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                ],
              ),
            ),
          );
  }

  _userSection() {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.width * 0.45,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: greenPrimary.withOpacity(0.2),
          ),
          child: loading
              ? LoadingAnimationWidget.dotsTriangle(
                  color: greenPrimary,
                  size: ScreenWH(context).width * 0.2,
                )
              : Image.asset(user.avatar),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: Text(
            user.fullName,
            style: GoogleFonts.sourceSansPro(
                fontSize: getResponsiveText(context, 19),
                color: txtPrimary,
                fontWeight: FontWeight.w800),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _iconWithData(FontAwesomeIcons.userGroup, '100'),
              const SizedBox(
                width: 20,
              ),
              _iconWithData(FontAwesomeIcons.rankingStar, '100'),
              const SizedBox(
                width: 20,
              ),
              _iconWithData(FontAwesomeIcons.ticket, '100'),
            ],
          ),
        )
      ],
    );
  }

  _iconWithData(IconData icon, String data) {
    return Row(
      children: [
        Icon(
          icon,
          color: greenPrimary,
          size: getResponsiveText(context, 15),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          data,
          style: GoogleFonts.sourceSansPro(
            fontSize: getResponsiveText(context, 15),
            color: txtPrimary,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
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

  Widget chatList() {
    return ListView.builder(
      itemCount: lstContacts.length > 5 ? 5 : lstContacts.length,
      itemBuilder: (context, index) {
        User contact = lstContacts[index];
        return Contact(contact.avatar, contact.fullName, "", context);
      },
    );
  }

  Widget Contact(
      String photo, String name, String walletId, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // goToTransferDeatil(photo, name, walletId, context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: ScreenWH(context).width * 0.075,
              child: Image.asset(
                user.avatar,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    walletId,
                    style: GoogleFonts.sourceSansPro(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            options(context, photo, name, walletId),
          ],
        ),
      ),
    );
  }

  Widget options(
    BuildContext context,
    String photo,
    String name,
    String walletId,
  ) {
    return PopupMenuButton(
        icon: const Icon(Icons.more_horiz),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onSelected: (val) => {
              print('value $val'),
              // if (val == 1)
              //   {
              //     Navigator.of(context)
              //         .pushNamed(UserProfile.routeName, arguments: {
              //       'photo': photo,
              //       'name': name,
              //       'walletId': walletId,
              //     })
              //   }
            },
        itemBuilder: (context) => const [
              PopupMenuItem(
                child: Text('Ver Perfil'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Favorito'),
                value: 2,
              ),
              PopupMenuItem(
                child: Text('Eliminar'),
                value: 3,
              ),
            ]);
  }

  editUsrData(IconData icon, String data, bool password) {
    //text-Form-Password
    TxtForm _txtFormPassword = TxtForm(
      placeholder: S.current.Password,
      controller: _passwordController,
      inputType: InputType.Password,
      txtColor: txtPrimary,
      prefixIcon: const Icon(Icons.lock),
      errorMessage: S.current.PasswordOblig,
    );
//text-Form-mail
    TxtForm _txtFormEmail = TxtForm(
      placeholder: user.email,
      controller: _emailController,
      inputType: InputType.Email,
      txtColor: txtPrimary,
      prefixIcon: const Icon(Icons.mail),
      errorMessage: S.current.Obligatorio,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: greenPrimary,
          ),
          const SizedBox(width: 10),
          Text(data,
              style: GoogleFonts.sourceSansPro(
                  fontSize: 16,
                  color: txtPrimary,
                  fontWeight: FontWeight.w500)),
          const Spacer(),
          //EditButton
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.grey),
            onPressed: () {
              showDialog(
                  useSafeArea: true,
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        child: FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    S.current.editar,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.sourceSansPro(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20,
                                        color: greenPrimary),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                    height: 60,
                                    width: ScreenWH(context).width * 0.6,
                                    child: password
                                        ? _txtFormPassword
                                        : _txtFormEmail),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      button(S.current.Guardar, () {},
                                          greenPrimary),
                                      button(
                                          S.current.Volver, () {}, Colors.grey),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                  });
            },
          )
        ],
      ),
    );
  }

  editNameAndAvatar() {
    //text-Form-Password
    TxtForm _txtFormUserName = TxtForm(
      placeholder: user.fullName,
      controller: _userNameController,
      inputType: InputType.Default,
      txtColor: txtPrimary,
      prefixIcon: const Icon(Icons.person),
      errorMessage: S.current.Obligatorio,
    );
    return IconButton(
      icon: const Icon(Icons.edit_outlined, color: Colors.grey),
      onPressed: () {
        showDialog(
            useSafeArea: true,
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              S.current.editar,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.sourceSansPro(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                  color: greenPrimary),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 60,
                            width: ScreenWH(context).width * 0.8,
                            child: _txtFormUserName,
                          ), //AVATAR
                          const SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            alignment: Alignment.centerLeft,
                            child: Text("Edita tú avatar",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.sourceSansPro(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: greenPrimary,
                                    decoration: TextDecoration.none)),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                              height: ScreenWH(context).height * 0.28,
                              width: ScreenWH(context).width * 0.72,
                              child: selectAvatar()),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                button(S.current.Guardar, () {}, greenPrimary),
                                button(S.current.Volver, () {}, Colors.grey),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
            });
      },
    );
  }

  Widget button(String text, Function press, Color color) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        primary: Colors.white,
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 30),
      ),
      child: Text(
        text,
        style: GoogleFonts.notoSansJavanese(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      onPressed: () async {
        press();
      },
    );
  }

  Widget avatar(String name, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          for (int i = 0; i < avatarSelect.length; i++) {
            avatarSelect[i] = index == i ? !avatarSelect[i] : false;
          }
          if (avatarSelect.contains(true)) {
            pathSelectedAvatar = pathAvatarSelected[index];
          }
        });
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                  color: avatarSelect[index] ? greenPrimary : Colors.grey,
                  width: avatarSelect[index] ? 3 : 2),
            ),
            child: Image.asset(
                avatarSelect[index]
                    ? pathAvatarSelected[index]
                    : pathAvatarNoSelect[index],
                height: ScreenWH(context).height * 0.20,
                width: ScreenWH(context).width * 0.22),
          ),
        ],
      ),
    );
  }

  Widget selectAvatar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        avatar("Male", 0),
        avatar("Female", 1),
        avatar("Monster", 2),
      ],
    );
  }

  loadScreen() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LoadingAnimationWidget.dotsTriangle(
            color: greenPrimary,
            size: ScreenWH(context).width * 0.3,
          ),
          const SizedBox(height: 20),
          Text(
            S.current.Cargando,
            style: GoogleFonts.sourceSansPro(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
