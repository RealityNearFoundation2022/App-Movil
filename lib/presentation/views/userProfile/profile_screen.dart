import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/data/datasource/API/user_datasource.dart';
import 'package:reality_near/domain/entities/user.dart';
import 'package:reality_near/domain/usecases/user/user_data.dart';
import 'package:reality_near/generated/l10n.dart';
import 'package:reality_near/presentation/views/userProfile/widgets/avatar_select.dart';
import 'package:reality_near/presentation/widgets/buttons/default_button.dart';
import 'package:reality_near/presentation/widgets/dialogs/errorAlertDialog.dart';
import 'package:reality_near/presentation/widgets/dialogs/info_dialog.dart';
import 'package:reality_near/presentation/widgets/forms/textForm.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);
  static String routeName = "/ProfileScreen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User user = User();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    UserData(context).get().then((value) => setState(() {
          user = value;
          loading = false;
        })); // getContacts();
  }

  bool loading = true;

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
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  editData()
                  // buildCategory(S.current.Coleccionables, greenPrimary,
                  //     MediaQuery.of(context).size, () {}),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.02,
                  // ),
                  // buildCategory(S.current.MisPosts, greenPrimary,
                  //     MediaQuery.of(context).size, () {
                  //   Navigator.pushNamed(context, '/MyPosts');
                  // }),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.02,
                  // ),
                  // const SocialGrid(numElements: 5),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.02,
                  // ),
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
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.04,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       _iconWithData(FontAwesomeIcons.userGroup, '100'),
        //       const SizedBox(
        //         width: 20,
        //       ),
        //       _iconWithData(FontAwesomeIcons.rankingStar, '100'),
        //       const SizedBox(
        //         width: 20,
        //       ),
        //       _iconWithData(FontAwesomeIcons.ticket, '100'),
        //     ],
        //   ),
        // )
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

  editData() {
    //text-Form-Password
    TxtForm _txtFormUserName = TxtForm(
      placeholder: user.fullName ?? 'Ingresa tu nombre',
      controller: _userNameController,
      inputType: InputType.Default,
      txtColor: txtPrimary,
      prefixIcon: const Icon(Icons.person),
      errorMessage: S.current.Obligatorio,
      title: S.current.UserName,
    );
    TxtForm _txtFormEmail = TxtForm(
      placeholder: user.email ?? 'Ingresa tu correo',
      controller: _emailController,
      inputType: InputType.Email,
      txtColor: txtPrimary,
      prefixIcon: const Icon(Icons.mail),
      errorMessage: S.current.Obligatorio,
      title: S.current.Email,
    );
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          _txtFormUserName, //AVATAR
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          _txtFormEmail,
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Avatar',
              style: GoogleFonts.sourceSansPro(
                  fontSize: getResponsiveText(context, 19),
                  color: greenPrimary,
                  fontWeight: FontWeight.w800),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          AvatarSelect(userAvatar: user.avatar),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          AppButton(
            label: 'Guardar',
            onPressed: () {
              final username = _userNameController.text.isNotEmpty
                  ? _userNameController.text
                  : user.fullName;
              final email = _emailController.text.isNotEmpty
                  ? _emailController.text
                  : user.email;
              final avatar = const AvatarSelect().getAvatar() ?? user.avatar;
              editUserData(avatar, username, email);
            },
            width: MediaQuery.of(context).size.width * 0.8,
          ),
        ],
      ),
    );
  }

  editUserData(String avatar, String username, String email) {
    UserRemoteDataSourceImpl service = UserRemoteDataSourceImpl();
    service.editUserData(avatar, username, email).then((value) => {
          if (value)
            {
              UserData(context).refresh(),
            },
          //see dialog to confirm or not
          showDialog(
            context: context,
            builder: (context) => value
                ? InfoDialog(
                    onPressed: () {
                      Navigator.pushNamed(context, "/home");
                    },
                    icon: SizedBox(
                        child: Icon(
                      Icons.check_circle_outline_rounded,
                      color: greenPrimary,
                      size: MediaQuery.of(context).size.height * 0.25,
                    )),
                    message: '',
                    title: 'Datos editados correctamente',
                  )
                : const ErrorAlertDialog(
                    errorMessage: 'Error al editar los datos'),
          ),
        });
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
