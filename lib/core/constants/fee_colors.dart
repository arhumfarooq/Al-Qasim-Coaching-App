// Fee Design Constants (Extends your existing color system)
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FeeColors {
  // Main colors from existing design system
  static const Color primaryOrange = Color(0xFFF39C12);
  static const Color secondaryOrange = Color(0xFFE67E22);
  static const Color darkOrange = Color(0xFFD35400);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color warmWhite = Color(0xFFFFF9E6);
  static const Color lightOrangeTint = Color(0xFFFFF3E0);
  static const Color darkText = Color(0xFF2C3E50);
  static const Color lightText = Color(0xFF7F8C8D);
  
  // Fee-specific colors (using same palette principles)
  static const Color paidColor = Color(0xFF2ECC71); // Green
  static const Color pendingColor = Color(0xFFF1C40F); // Yellow
  static const Color overdueColor = Color(0xFFE74C3C); // Red
  static const Color upcomingColor = Color(0xFF3498DB); // Blue
  
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFF39C12), Color(0xFFE67E22)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient paidGradient = LinearGradient(
    colors: [Color(0xFF2ECC71), Color(0xFF27AE60)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient pendingGradient = LinearGradient(
    colors: [Color(0xFFF1C40F), Color(0xFFF39C12)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient overdueGradient = LinearGradient(
    colors: [Color(0xFFE74C3C), Color(0xFFC0392B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class FeeTypography {
  static TextStyle headlineLarge(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 28.sp,
      fontWeight: FontWeight.w800,
      color: FeeColors.darkText,
      letterSpacing: -0.5,
    );
  }
  
  static TextStyle headlineMedium(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 22.sp,
      fontWeight: FontWeight.w700,
      color: FeeColors.darkText,
    );
  }
  
  static TextStyle bodyLarge(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: FeeColors.darkText,
    );
  }
  
  static TextStyle bodyMedium(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: FeeColors.lightText,
    );
  }
  
  static TextStyle caption(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: FeeColors.lightText,
    );
  }
  
  static TextStyle amount(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      color: FeeColors.darkText,
    );
  }
}