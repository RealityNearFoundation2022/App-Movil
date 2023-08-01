import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';

class CirclePainter extends CustomPainter {
  final double radius;
  final double progress;
  final Color color;

  CirclePainter({
    this.radius,
    this.progress,
    this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const strokeWidth = 2.0;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    const startAngle = -math.pi / 2;
    final sweepAngle = math.pi * 2 * progress;
    canvas.drawArc(
      Rect.fromCenter(center: center, width: radius * 2, height: radius * 2),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class CustomRadioButtons extends StatefulWidget {
  final List<String> options;
  final bool isVertical;
  final void Function(String) onChanged;

  const CustomRadioButtons({
    Key key,
    this.options,
    this.isVertical = true,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomRadioButtonsState createState() => _CustomRadioButtonsState();
}

class _CustomRadioButtonsState extends State<CustomRadioButtons>
    with SingleTickerProviderStateMixin {
  String _selectedOption;
  AnimationController _controller;
  final Color _fillColor = greenPrimary;
  final Color _borderColor = greenPrimary;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isVertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildRadioButtons(),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildRadioButtons(),
          );
  }

  List<Widget> _buildRadioButtons() {
    return widget.options.map((option) {
      bool isSelected = option == _selectedOption;
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedOption = option;
          });
          if (widget.onChanged != null) {
            widget.onChanged(option);
          }
          _controller.reset();
          _controller.forward();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Colors.transparent : greenPrimary,
                      width: 2.0,
                    ),
                    color: isSelected ? _fillColor : Colors.transparent,
                  ),
                  child: isSelected
                      ? const Center(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 18,
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 15),
              Text(
                option,
                style: GoogleFonts.sourceSansPro(
                  color: Colors.black, // Use el color que desees aquí
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 15),
            ],
          ),
        ),
      );
    }).toList();
  }
}
