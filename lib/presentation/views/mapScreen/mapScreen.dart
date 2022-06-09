import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/presentation/bloc/menu/menu_bloc.dart';
import 'package:reality_near/presentation/views/mapScreen/widgets/map.dart';

class MapContainer extends StatefulWidget {
  const MapContainer({Key key}) : super(key: key);

  @override
  State<MapContainer> createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool isOpen = false;
  bool seeContent = false;
  int animatedDuration = 500;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: animatedDuration));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(builder: ((context, state) {
      return (state is MenuMapaState || state is MenuInitialState)
          ? AnimatedContainer(
              duration: Duration(milliseconds: animatedDuration),
              width: ScreenWH(context).width * (isOpen ? 0.8 : 0.1),
              height: ScreenWH(context).height * (isOpen ? 0.5 : 0.09),
              decoration: BoxDecoration(
                  color: isOpen ? greenPrimary : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                  )),
              child: Container(
                alignment: isOpen ? Alignment.topLeft : null,
                child: Stack(
                  children: [
                    seeContent ? const MapSection() : const SizedBox(),
                    Container(
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          child: Icon(
                            isOpen
                                ? Icons.arrow_back_ios_new
                                : Icons.map_rounded,
                            size: 40,
                            color: greenPrimary,
                          ),
                          onTap: () {
                            _handleOnPressed();
                          },
                        ))
                  ],
                ),
              ),
            )
          : const SizedBox();
    }));
  }

  Future<void> _handleOnPressed() async {
    setState(() {
      isOpen = !isOpen;
      isOpen ? _animationController.forward() : _animationController.reverse();
    });
    if (isOpen) {
      //creamos un evento en el bloc
      BlocProvider.of<MenuBloc>(context, listen: false).add(MenuOpenMapEvent());
      await Future.delayed(Duration(milliseconds: animatedDuration + 10));
      setState(() {
        seeContent = isOpen;
      });
    } else {
      //creamos un evento en el bloc
      BlocProvider.of<MenuBloc>(context, listen: false).add(MenuCloseEvent());
      seeContent = isOpen;
    }
  }
}
