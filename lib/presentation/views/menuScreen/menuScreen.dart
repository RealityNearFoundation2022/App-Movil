import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/presentation/bloc/menu/menu_bloc.dart';
import 'package:reality_near/presentation/views/bugScreen/bugScreen.dart';
import 'package:reality_near/presentation/views/informationScreen/infoScreen.dart';
import 'package:reality_near/presentation/views/menuScreen/widgets/menuPrincSection.dart';

class MenuContainer extends StatefulWidget {
  const MenuContainer({Key? key}) : super(key: key);

  @override
  State<MenuContainer> createState() => _MenuContainerState();
}

class _MenuContainerState extends State<MenuContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
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
          : AnimatedContainer(
              duration: Duration(milliseconds: animatedDuration),
              onEnd: () {
                setState(() {
                  seeContent = isOpen;
                });
              },
              width: ScreenWH(context).width * (isOpen ? 0.5 : 0.2),
              height: ScreenWH(context).height * (isOpen ? 0.45 : 0.11),
              decoration: BoxDecoration(
                  color: isOpen ? backgroundWhite : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                  )),
              child: Container(
                alignment: isOpen ? Alignment.topLeft : null,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        child: AnimatedIcon(
                          icon: AnimatedIcons.menu_close,
                          progress: _animationController,
                          size: 40,
                          color: isOpen ? greenPrimary3 : greenPrimary,
                        ),
                        onTap: () {
                          _handleOnPressed(state);
                        },
                      ),
                    ),
                    Expanded(
                        child: seeContent
                            ? const MenuPrincSection()
                            : const SizedBox())
                  ],
                ),
              ),
            );
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
