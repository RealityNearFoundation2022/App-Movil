import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/presentation/widgets/buttons/radio_buttons.dart';

void main() {
  runApp(const MaterialApp(
    home: PreguntasTriviaGame(),
  ));
}

class PreguntasTriviaGame extends StatefulWidget {
  const PreguntasTriviaGame({Key key}) : super(key: key);

  @override
  State<PreguntasTriviaGame> createState() => _PreguntasTriviaGameState();
}

class _PreguntasTriviaGameState extends State<PreguntasTriviaGame>
    with TickerProviderStateMixin {
  StreamController<int> controller = StreamController<int>();
  int countdown = 10;

  AnimationController _controller;
  Animation<double> _animation;
  double _animationValue = 1.0;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: countdown),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    _controller.forward();
    _animation.addListener(() {
      setState(() {
        _animationValue = 1.0 - _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        timer.cancel();
        // Aquí puedes agregar la lógica para manejar el final del tiempo.
      }
    });
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
          const SizedBox(
            height: 20,
          ),
          //Contador
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.15,
            child: CustomPaint(
              foregroundPainter: CircleTimerPainter(
                strokeWidth: 6,
                color: greenPrimary, // Use el color que desees aquí
                backgroundColor: Colors.grey, // Use el color que desees aquí
                percentage: _animationValue, // Usar el valor de animación aquí
              ),
              child: Center(
                child: Text(
                  '$countdown',
                  style: GoogleFonts.sourceSansPro(
                    color: Colors.black54, // Use el color que desees aquí
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 60,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.3,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: Text(
                '¿Donde se jugo la última final de la UEFA Champions League?',
                textAlign: TextAlign.center,
                style: GoogleFonts.sourceSansPro(
                  color: greenPrimary, // Use el color que desees aquí
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: CustomRadioButtons(
                isVertical: true,
                options: const [
                  'Estambul',
                  'Madrid',
                  'Lisboa',
                  'Milan',
                ],
                onChanged: (value) {
                  print(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Painter para el contador circular
class CircleTimerPainter extends CustomPainter {
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;
  final double percentage;

  CircleTimerPainter({
    this.color = Colors.red,
    this.backgroundColor = Colors.grey,
    this.strokeWidth = 8,
    this.percentage = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - strokeWidth / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, backgroundPaint);

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * percentage,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
