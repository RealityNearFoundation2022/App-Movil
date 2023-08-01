import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/presentation/views/miniGames/wheelGame/Preguntas.dart';
import 'package:reality_near/presentation/widgets/dialogs/info_dialog.dart';

class TriviaGame extends StatefulWidget {
  const TriviaGame({Key key}) : super(key: key);

  @override
  State<TriviaGame> createState() => _TriviaGameState();
}

class _TriviaGameState extends State<TriviaGame> {
  StreamController<int> controller = StreamController<int>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalApppBar(context, 'Trivia Game'),
      body: _body(),
    );
  }

  _body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.9,
            child: FortuneWheel(
              selected: controller.stream,
              hapticImpact: HapticImpact.medium,
              duration: Fortune.randomDuration(
                  const Duration(seconds: 1), const Duration(seconds: 7)),
              onFling: () => controller.add(
                  Fortune.randomInt(0, 3)), // generate random int from 0 to 5
              animateFirst: false,
              onAnimationEnd: () => showDialog(
                  context: context,
                  builder: (context) => InfoDialog(
                        title: 'Trivia Game',
                        message: 'Categoría : Deportes',
                        closeOption: false,
                        icon: const Icon(
                          Icons.question_mark_rounded,
                          color: greenPrimary,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 300),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(-1.0, 0.0),
                                          end: Offset.zero,
                                        ).animate(animation),
                                        child: const PreguntasTriviaGame()),
                          ));
                        },
                      )),
              items: const [
                FortuneItem(child: Text('Deportes')),
                FortuneItem(child: Text('Historia')),
                FortuneItem(child: Text('Cine')),
                FortuneItem(child: Text('Geografía')),
                FortuneItem(child: Text('Series')),
                FortuneItem(child: Text('Música')),
              ],
            ),
          )
        ],
      ),
    );
  }
}
