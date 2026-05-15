import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredGradientBackground extends StatelessWidget {
  const BlurredGradientBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF39C12),
            Color(0xFFE67E22),
            Color(0xFFD35400),
          ],
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
    );
  }
}

