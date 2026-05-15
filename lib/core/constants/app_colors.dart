// lib/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Background Colors
  static const Color scaffoldBackground = Color(0xFFF8F9FA);
  static const Color primaryBackground = Color(0xFFF8F9FA);
  
  // Primary Colors
  static const Color primary = Color(0xFF1E88E5);
  static const Color primaryDark = Color(0xFF1565C0);
  static const Color primaryLight = Color(0xFF64B5F6);
  
  // Secondary Colors
  static const Color secondary = Color(0xFF4CAF50);
  static const Color secondaryDark = Color(0xFF388E3C);
  static const Color secondaryLight = Color(0xFF81C784);
  
  // // Success Colors (Green)
  static const Color success = Color(0xFF27AE60); 
  static const Color successDark = Color(0xFF229954);
  static const Color successLight = Color(0xFF7DCEA0);
  static const Color successExtraLight = Color(0xFFE8F8EF);
  
  // Warning Colors (Orange/Yellow)
  static const Color warning = Color(0xFFF39C12);
  static const Color warningDark = Color(0xFFE67E22);
  static const Color warningDarker = Color(0xFFD35400);
  static const Color warningLight = Color(0xFFF8C471);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color textLight = Color(0xFFBDC3C7);
  static const Color textWhite = Colors.white;
  
  // Neutral Colors
  static const Color neutralDark = Color(0xFF2C3E50);
  static const Color neutralMedium = Color(0xFF7F8C8D);
  static const Color neutralLight = Color(0xFFBDC3C7);
  static const Color neutralExtraLight = Color(0xFFECF0F1);
  
  // Gradient Colors
  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFF1E88E5), Color(0xFF4CAF50)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
    static LinearGradient approveVolunteerGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [

      success,

      successDark,
    ],
  );

  static Color approveVolunteerShadow = successDark.withOpacity(0.4);

  static const Gradient successGradient = LinearGradient(
    colors: [Color(0xFF2ECC71), Color(0xFF27AE60)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Gradient warningGradient = LinearGradient(
    colors: [Color(0xFFF39C12), Color(0xFFE67E22), Color(0xFFD35400)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
  );
  
  static const Gradient scanButtonGradient = LinearGradient(
    colors: [warning, warningDark, warningDarker],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
  );
  
  static const Gradient pendingTokensGradient = LinearGradient(
    colors: [warning, warningDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Gradient completedTokensGradient = LinearGradient(
    colors: [success, successDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Background Gradients
  static Gradient pendingTokensBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [success.withOpacity(0.05), warning.withOpacity(0.05)],
  );
  
  static Gradient completedTokensBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [success.withOpacity(0.1), success.withOpacity(0.05)],
  );
  
  // Border Colors
  static const Color borderLight = Color(0xFFE8F8EF);
  static const Color borderMedium = Color(0xFFBDC3C7);
  static const Color borderDark = Color(0xFF95A5A6);
  
  // Shadow Colors
  static Color shadowLight = Colors.black.withOpacity(0.1);
  static Color shadowMedium = Colors.black.withOpacity(0.2);
  static Color shadowDark = Colors.black.withOpacity(0.3);
  
  // Specific Component Colors
  static Color pendingTokensShadow = warning.withOpacity(0.3);
  static Color completedTokensShadow = success.withOpacity(0.3);
  static Color scanButtonShadow = warningDark.withOpacity(0.4);
  
  // Status Colors
  static const Color error = Color(0xFFE74C3C);
  static const Color info = Color(0xFF3498DB);
  static const Color disabled = Color(0xFFBDC3C7);
  
  // Transparent Colors
  static const Color transparent = Colors.transparent;
  
  // Helper method to get opacity variants
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }


  // 6. Dynamic badge color based on urgency
static Color getBadgeColor(int count) {
  if (count > 20) {
    return Color(0xFFD32F2F); // Red - High urgency
  } else if (count > 10) {
    return Color(0xFFF57C00); // Orange - Medium urgency
  } else if (count > 5) {
    return Color(0xFFFFB300); // Amber - Elevated attention
  } else {
    return Color(0xFF2196F3); // Blue - Standard pending
  }
}


static Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'verified':
      return AppColors.success;
    case 'pending':
      return AppColors.warningDark;
    case 'approved':
      return AppColors.secondaryDark;
    case 'access denied':
      return const Color(0xFFDC2626);
    default:
      return const Color(0xFF64748B);
  }
}



}