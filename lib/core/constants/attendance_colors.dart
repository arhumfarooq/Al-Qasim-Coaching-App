// // Attendance Design Constants
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AttendanceColors {
//   // Main colors from login screen
//   static const Color primaryOrange = Color(0xFFF39C12);
//   static const Color secondaryOrange = Color(0xFFE67E22);
//   static const Color darkOrange = Color(0xFFD35400);
//   static const Color backgroundWhite = Color(0xFFFFFFFF);
//   static const Color warmWhite = Color(0xFFFFF9E6);
//   static const Color lightOrangeTint = Color(0xFFFFF3E0);
//   static const Color darkText = Color(0xFF2C3E50);
//   static const Color lightText = Color(0xFF7F8C8D);
  
//   // Attendance-specific colors
//   static const Color presentColor = Color(0xFF2ECC71); // Green
//   static const Color absentColor = Color(0xFFE74C3C); // Red
//   static const Color holidayColor = Color(0xFF3498DB); // Blue
//   static const Color pendingColor = Color(0xFFF1C40F); // Yellow
  
//   static const LinearGradient primaryGradient = LinearGradient(
//     colors: [Color(0xFFF39C12), Color(0xFFE67E22)],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );
// }




// class AttendanceTypography {
//   static TextStyle headlineLarge(BuildContext context) {
//     return GoogleFonts.poppins(
//       fontSize: 28.sp,
//       fontWeight: FontWeight.w800,
//       color: AttendanceColors.darkText,
//       letterSpacing: -0.5,
//     );
//   }
  
//   static TextStyle headlineMedium(BuildContext context) {
//     return GoogleFonts.poppins(
//       fontSize: 22.sp,
//       fontWeight: FontWeight.w700,
//       color: AttendanceColors.darkText,
//     );
//   }
  
//   static TextStyle bodyLarge(BuildContext context) {
//     return GoogleFonts.poppins(
//       fontSize: 16.sp,
//       fontWeight: FontWeight.w500,
//       color: AttendanceColors.darkText,
//     );
//   }
  
//   static TextStyle bodyMedium(BuildContext context) {
//     return GoogleFonts.poppins(
//       fontSize: 14.sp,
//       fontWeight: FontWeight.w400,
//       color: AttendanceColors.lightText,
//     );
//   }
  
//   static TextStyle caption(BuildContext context) {
//     return GoogleFonts.poppins(
//       fontSize: 12.sp,
//       fontWeight: FontWeight.w400,
//       color: AttendanceColors.lightText,
//     );
//   }
// }

// Attendance Design Constants

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendanceColors {
  // Main Colors
  static const Color primaryOrange = Color(0xFFF39C12);
  static const Color secondaryOrange = Color(0xFFE67E22);
  static const Color darkOrange = Color(0xFFD35400);

  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color warmWhite = Color(0xFFFFF9E6);
  static const Color lightOrangeTint = Color(0xFFFFF3E0);

  static const Color darkText = Color(0xFF2C3E50);
  static const Color lightText = Color(0xFF7F8C8D);

  // Attendance Colors
  static const Color presentColor = Color(0xFF2ECC71);
  static const Color absentColor = Color(0xFFE74C3C);
  static const Color holidayColor = Color(0xFF3498DB);
  static const Color pendingColor = Color(0xFFF1C40F);
  static const Color notMarkedColor = Color(0xFFB0B0B0);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFFF39C12),
      Color(0xFFE67E22),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // =========================
  // ATTENDANCE STATUS COLORS
  // =========================

  static Color getAttendanceStatusColor(
    String status,
  ) {
    switch (status.toLowerCase()) {

      case 'present':
        return presentColor;

      case 'absent':
        return absentColor;

      case 'holiday':
        return holidayColor;

      case 'not_marked':
        return notMarkedColor;

      default:
        return Colors.grey;
    }
  }
}

class AttendanceTypography {

  static TextStyle headlineLarge(
    BuildContext context,
  ) {
    return GoogleFonts.poppins(
      fontSize: 28.sp,
      fontWeight: FontWeight.w800,
      color: AttendanceColors.darkText,
      letterSpacing: -0.5,
    );
  }

  static TextStyle headlineMedium(
    BuildContext context,
  ) {
    return GoogleFonts.poppins(
      fontSize: 22.sp,
      fontWeight: FontWeight.w700,
      color: AttendanceColors.darkText,
    );
  }

  static TextStyle bodyLarge(
    BuildContext context,
  ) {
    return GoogleFonts.poppins(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: AttendanceColors.darkText,
    );
  }

  static TextStyle bodyMedium(
    BuildContext context,
  ) {
    return GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: AttendanceColors.lightText,
    );
  }

  static TextStyle caption(
    BuildContext context,
  ) {
    return GoogleFonts.poppins(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: AttendanceColors.lightText,
    );
  }
}