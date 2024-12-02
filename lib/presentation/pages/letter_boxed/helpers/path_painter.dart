import 'package:flutter/material.dart';
import 'path_controller.dart';

class PathPainter extends CustomPainter {
  final PathController controller;

  PathPainter(this.controller);

  @override
  void paint(Canvas canvas, Size size) {
    final currentWordPaint = Paint()
      ..color = const Color.fromARGB(130, 233, 30, 98)
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;
    final historyPaint = Paint()
      ..color = const Color.fromARGB(180, 255, 255, 255)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    final touchLinePaint = Paint()
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    // history word
    for (var word in controller.currentSolution) {
      for (int i = 0; i < word.length - 1; i++) {
        canvas.drawLine(
          controller.letterPosition(word[i]),
          controller.letterPosition(word[i + 1]),
          historyPaint,
        );
      }
    }
    // current word
    final path = controller.currentWord;
    for (int i = 0; i < path.length - 1; i++) {
      canvas.drawLine(
        controller.letterPosition(path[i]),
        controller.letterPosition(path[i + 1]),
        currentWordPaint,
      );
    }

    // touch line
    if (controller.touchStart != null && controller.touchPoint != Offset.zero) {
      canvas.drawLine(
          controller.touchStart!, controller.touchPoint, touchLinePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
