// Custom painter for motion lines
import 'dart:math';

import 'package:flutter/material.dart';

class MotionLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = const Color(0xFFF39C12).withOpacity(0.15)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw radiating lines
    for (int i = 0; i < 8; i++) {
      final angle = (i * 45) * 3.14159 / 180;
      final endX = center.dx + 100 * cos(angle);
      final endY = center.dy + 100 * sin(angle);
      
      final linePaint = Paint()
        ..color = const Color(0xFFF39C12).withOpacity(0.2 - (i * 0.01))
        ..strokeWidth = 1.2
        ..style = PaintingStyle.stroke;

      canvas.drawLine(center, Offset(endX, endY), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

