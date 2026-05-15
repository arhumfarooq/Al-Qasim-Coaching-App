

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginAppLogo extends StatelessWidget {
  const LoginAppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      height: 90.h,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF39C12).withOpacity(0.3),
            blurRadius: 20.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          "assets/app_logo.png",
          width: 50.w,
          height: 50.h,
          fit: BoxFit.contain,
        ),
      ),
    );

  }
}