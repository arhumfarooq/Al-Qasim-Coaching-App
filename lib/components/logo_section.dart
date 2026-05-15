

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoSection extends StatelessWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 400.w, 
        ),
        child: Column(
          children: [
            Container(
              width: 100.w,
              height: 100.w, 
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFF39C12).withOpacity(0.15),
                    blurRadius: 30.r,
                    spreadRadius: 5.r,
                  ),
                ],
                border: Border.all(
                  color: const Color(0xFFF39C12).withOpacity(0.4),
                  width: 2.w,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Image.asset(
                  "assets/app_logo.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                '"Serving with Compassion, Nourishing with Care"',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFF2C3E50),
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

