import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/presentation/bloc/menu/menu_bloc.dart';
import 'package:reality_near/presentation/views/menuScreen/widgets/menuPrincSection.dart';
import 'package:showcaseview/showcaseview.dart';

class MenuContainer extends StatefulWidget {
  const MenuContainer({Key key, this.showCaseKey}) : super(key: key);
  final GlobalKey<State<StatefulWidget>> showCaseKey;

  @override
  State<MenuContainer> createState() => _MenuContainerState();
}

class _MenuContainerState extends State<MenuContainer>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool isOpen = false;
  bool seeContent = false;
  bool seeConfig = false;
  int animatedDuration = 500;
  MenuEvent toBack = MenuOpenInitEvent();
  String titleScreen = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: animatedDuration));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(builder: ((context, state) {
      return state is MenuMapaState
          ? const SizedBox()
          : Showcase(
              key: widget.showCaseKey,
              overlayPadding: const EdgeInsets.all(12),
              radius: BorderRadius.circular(100),
              contentPadding: const EdgeInsets.all(15),
              title: 'Menu',
              description:
                  "En esta sección ingresar al chat, a tu lista de contactos, configurar tus preferencias y administrar tu NEAR wallet",
              showcaseBackgroundColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
              titleTextStyle: GoogleFonts.sourceSansPro(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              descTextStyle: GoogleFonts.sourceSansPro(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              shapeBorder: const CircleBorder(),
              child: AnimatedContainer(
                duration: Duration(milliseconds: animatedDuration),
                onEnd: () {
                  setState(() {
                    seeContent = isOpen;
                  });
                },
                width: ScreenWH(context).width * (isOpen ? 0.5 : 0.16),
                height: ScreenWH(context).height * (isOpen ? 0.45 : 0.09),
                decoration: BoxDecoration(
                    color: isOpen ? backgroundWhite : Colors.transparent,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                    )),
                child: Container(
                  alignment: isOpen ? Alignment.topLeft : null,
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 20),
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          child: AnimatedIcon(
                            icon: AnimatedIcons.menu_close,
                            progress: _animationController,
                            size: 40,
                            color: greenPrimary,
                          ),
                          onTap: () {
                            _handleOnPressed(state);
                          },
                        ),
                      ),
                      seeContent ? const MenuPrincSection() : const SizedBox()
                    ],
                  ),
                ),
              ));
    }));
  }

//Funcion al momento de presionar el boton para hacer efectos y cambio de pantalla
  Future<void> _handleOnPressed(MenuState state) async {
    setState(() {
      seeContent = false;
      seeConfig = false;
    });
    setState(() {
      isOpen = !isOpen;
      isOpen ? _animationController.forward() : _animationController.reverse();
    });

    if (isOpen) {
      //creamos un evento en el bloc
      BlocProvider.of<MenuBloc>(context, listen: false)
          .add(MenuOpenInitEvent());
    } else {
      //creamos un evento en el bloc
      BlocProvider.of<MenuBloc>(context, listen: false).add(MenuCloseEvent());
    }
  }
}
