

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            width: 250.w,
            height: 400.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF39C12).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
          )
        ),
        Positioned(
          bottom: -50,
          right: -50,
          child: Container(
            width: 200.w,
            height: 200.h,
            decoration: BoxDecoration(
              color: const Color(0xFF27AE60).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
          )
        ),
      ],
    );
  }
}