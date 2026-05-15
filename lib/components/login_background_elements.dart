
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackgroundElements extends StatelessWidget {
  const BackgroundElements({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Large decorative circles
        Positioned(
          top: -80.h,
          right: -60.w,
          child: _decorativeCircle(200.w, 0.05),
        ),
        Positioned(
          bottom: -100.h,
          left: -80.w,
          child: _decorativeCircle(240.w, 0.03),
        ),
        // Floating particles
        ..._floatingParticles(count: 13),
      ],
    );
  }

  Widget _decorativeCircle(double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF39C12).withOpacity(opacity),
            const Color(0xFFF39C12).withOpacity(opacity / 2),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms);
  }

  List<Widget> _floatingParticles({int count = 20}) {
    final Random random = Random();
    List<Widget> particles = [];

    for (int i = 0; i < count; i++) {
      // Top half particles vs Bottom half particles
      bool topZone = i < count / 2;

      final double size = 2.w + random.nextDouble() * 4.w; // 2-6
   final double? top = topZone
    ? random.nextDouble() * 200.h // top zone: 0 - 200
    : null;
final double? bottom = !topZone
    ? random.nextDouble() * 150.h // bottom zone: 0 - 150 from bottom
    : null;

      final double left = random.nextDouble() * 300.w; // horizontal
      final double opacity = 0.1 + random.nextDouble() * 0.2; // 0.1-0.3
      final int durationSec = 2 + random.nextInt(3); // 2-4 sec float
      final double moveDistance = 6.h + random.nextDouble() * 12.h;

      particles.add(Positioned(
        top: top,
        bottom: bottom,
        left: left,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: const Color(0xFFF39C12).withOpacity(opacity),
            shape: BoxShape.circle,
          ),
        ).animate(
          delay: (i * 100).ms,
          onPlay: (controller) => controller.repeat(reverse: true),
        ).moveY(
          begin: 0,
          end: -moveDistance,
          duration: Duration(seconds: durationSec),
        ),
      ));
    }

    return particles;
  }
}
