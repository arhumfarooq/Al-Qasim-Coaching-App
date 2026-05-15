import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome Back',
          style: GoogleFonts.poppins(
            fontSize: 26.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2C3E50),
          ),
        ).animate().fadeIn(duration: 600.ms),

        SizedBox(height: 8.h),

        Text(
          'Sign in to continue',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: const Color(0xFF7F8C8D),
          ),
        ).animate().fadeIn(delay: 200.ms),
      ],
    );
  }
}
