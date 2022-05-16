import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/presentation/bloc/menu/menu_bloc.dart';
import 'package:reality_near/presentation/views/bugScreen/bugScreen.dart';
import 'package:reality_near/presentation/views/informationScreen/infoScreen.dart';
import 'package:reality_near/presentation/views/menuScreen/widgets/optionsSection.dart';
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
      double openWidth = 0;
      double openHeight = 0;

      //Definimos ancho y alto del menu depende del estado donde se encuentre
      switch (state.runtimeType) {
        case MenuPrincipalState:
          openWidth = ScreenWH(context).width * 0.5;
          openHeight = ScreenWH(context).height * 0.42;
          break;
        case MenuConfiguracionState:
          openWidth = ScreenWH(context).width * 0.99;
          openHeight = ScreenWH(context).height * 0.95;
          wait(600);
          titleScreen = 'Configuración';
          toBack = MenuOpenInitEvent();
          break;
        case MenuInformacionState:
          openWidth = ScreenWH(context).width * 0.99;
          openHeight = ScreenWH(context).height * 0.95;
          wait(600);
          titleScreen = 'Información';
          toBack = MenuOpenCongifEvent();
          break;
        case MenuBugState:
          openWidth = ScreenWH(context).width * 0.99;
          openHeight = ScreenWH(context).height * 0.95;
          wait(600);
          titleScreen = 'Reporte un Bug';
          toBack = MenuOpenInfoEvent();
          break;
        default:
          openWidth = ScreenWH(context).width * 0.2;
          openHeight = ScreenWH(context).height * 0.11;
          break;
      }
      ;

      return state is MenuMapaState
          ? SizedBox()
          : AnimatedContainer(
              duration: Duration(milliseconds: animatedDuration),
              onEnd: () {
                setState(() {
                  seeContent = isOpen;
                });
              },
              width: openWidth,
              height: openHeight,
              decoration: BoxDecoration(
                  color: isOpen ? greenPrimary : Colors.transparent,
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
                        child: topTitle(state),
                        onTap: () {
                          _handleOnPressed(state);
                        },
                      ),
                    ),
//Contenido dentro del container desplegable
                    contenido(state)
                  ],
                ),
              ),
            );
    }));
  }

  Widget topTitle(MenuState state) {
    return (state is MenuInitialState || state is MenuPrincipalState)
        ? AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animationController,
            size: 40,
            color: isOpen ? Colors.white : greenPrimary,
          )
        : Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 35,
                ),
                seeConfig
                    ? Text(
                        titleScreen,
                        style: GoogleFonts.sourceCodePro(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                      )
                    : Container(),
              ],
            ),
          );
  }

  Widget contenido(MenuState state) {
    if (seeContent || seeConfig) {
      switch (state.runtimeType) {
        case MenuConfiguracionState:
          return const Expanded(
            child: OptionSection(),
          );
        case MenuInformacionState:
          return const Expanded(
            child: InfoScreen(),
          );
        case MenuBugState:
          return const Expanded(
            child: BugScreen(),
          );

        default:
          return const Expanded(
            child: MenuPrincSection(),
          );
      }
    } else {
      return Container();
    }
  }

//Funcion al momento de presionar el boton para hacer efectos y cambio de pantalla
  Future<void> _handleOnPressed(MenuState state) async {
    setState(() {
      seeContent = false;
      seeConfig = false;
    });
    setState(() {
      if (state is MenuInitialState || state is MenuPrincipalState) {
        isOpen = !isOpen;
      }
      isOpen ? _animationController.forward() : _animationController.reverse();
    });

    if (isOpen) {
      //creamos un evento en el bloc
      BlocProvider.of<MenuBloc>(context, listen: false).add(toBack);
    } else {
      //creamos un evento en el bloc
      BlocProvider.of<MenuBloc>(context, listen: false).add(MenuCloseEvent());
    }
  }

  //Funcion espera cambio de menu config
  void wait(double mlseconds) {
    Future.delayed(Duration(milliseconds: (mlseconds).toInt()), () {
      setState(() {
        seeConfig = true;
      });
    });
  }
}
