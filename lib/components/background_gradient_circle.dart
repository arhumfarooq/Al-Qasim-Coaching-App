import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner/core/constants/attendance_Colors.dart';

class BackgroundGradientCircle extends StatelessWidget {
  const BackgroundGradientCircle({super.key});

  @override
  Widget build(BuildContext context) {
  return  Stack(
      children: [
        Positioned(
          top: -100,
          left: -80,
          child: Container(
            width: 240.w,
            height: 240.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AttendanceColors.darkOrange.withOpacity(0.03),
                  AttendanceColors.darkOrange.withOpacity(0.01),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}