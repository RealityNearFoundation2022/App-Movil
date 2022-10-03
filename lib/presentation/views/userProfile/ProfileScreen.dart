import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/repository/userRepository.dart';
import 'package:reality_near/domain/entities/user.dart';
import 'package:reality_near/domain/usecases/contacts/getContacts.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/userProfile/chatUserProfile.dart';
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

  Future<void> getContacts() async {
    var response = await GetContactsUseCase().call();
    setState(() {
      lstContacts = response;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    getContacts();
  }

  getUserData() {
    UserRepository().getMyData().then((value) => value.fold(
          (failure) => print(failure),
          (success) => {
            setState(() {
              user = success;
              avatarSelect[pathAvatarSelected
                  .indexWhere((element) => element == user.avatar)] = true;
            }),
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Container(
            margin: const EdgeInsets.only(right: 10),
            alignment: Alignment.centerRight,
            child: Text(
              "Perfil",
              style: GoogleFonts.sourceSansPro(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: greenPrimary,
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: greenPrimary, size: 35),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: user.id == null
            ? loadScreen()
            : Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: ScreenWH(context).width * 0.15,
                      child: Image.asset(
                        user.avatar,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.only(right: 20.0),
                      width: ScreenWH(context).width * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            user.fullName,
                            style: GoogleFonts.sourceSansPro(
                                fontSize: 20,
                                color: greenPrimary,
                                fontWeight: FontWeight.bold),
                          ),
                          editNameAndAvatar()
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "321 Amigos",
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 16,
                        color: txtPrimary,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  editUsrData(Icons.mail_outline, user.email, false),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          S.current.Amigos,
                          style: GoogleFonts.sourceSansPro(
                              fontSize: 20,
                              color: greenPrimary,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          "ver mas",
                          style: GoogleFonts.sourceSansPro(
                              fontSize: 16,
                              color: txtPrimary,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(child: chatList())
                ],
              ));
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
              if (val == 1)
                {
                  Navigator.of(context)
                      .pushNamed(UserProfile.routeName, arguments: {
                    'photo': photo,
                    'name': name,
                    'walletId': walletId,
                  })
                }
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
