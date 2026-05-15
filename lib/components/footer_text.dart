import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FooterText extends StatelessWidget {
  const FooterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Secure access to token management',
      style: GoogleFonts.poppins(
        fontSize: 12.sp,
        color: const Color(0xFF95A5A6),
      ),
    ).animate().fadeIn(delay: 800.ms);
  }
}
