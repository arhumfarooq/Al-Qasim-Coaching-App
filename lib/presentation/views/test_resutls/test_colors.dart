// Test Results Design Constants (Matches your admin screen aesthetic)
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TestColors {
  // Main colors from admin screen
  static const Color primaryGreen = Color(0xFF4CAF50);
  static const Color darkBlue = Color(0xFF1A237E);
  static const Color lightBlue = Color(0xFFF5F7FB);
  static const Color darkText = Color(0xFF2C3E50);
  static const Color lightText = Color(0xFF6B7280);
  
  // Performance colors
  static const Color excellentColor = Color(0xFF4CAF50); // Green
  static const Color goodColor = Color(0xFF2196F3); // Blue
  static const Color averageColor = Color(0xFFFF9800); // Orange
  static const Color needsImprovementColor = Color(0xFFF44336); // Red
  
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class TestTypography {
  static TextStyle headlineLarge(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 28.sp,
      fontWeight: FontWeight.w800,
      color: TestColors.darkBlue,
      letterSpacing: -0.5,
    );
  }
  
  static TextStyle headlineMedium(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 22.sp,
      fontWeight: FontWeight.w700,
      color: TestColors.darkBlue,
    );
  }
  
  static TextStyle bodyLarge(BuildContext context) {
    return GoogleFonts.inter(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: TestColors.darkText,
    );
  }
  
  static TextStyle bodyMedium(BuildContext context) {
    return GoogleFonts.inter(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: TestColors.lightText,
    );
  }
  
  static TextStyle scoreLarge(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 32.sp,
      fontWeight: FontWeight.w800,
      color: TestColors.darkBlue,
    );
  }
}