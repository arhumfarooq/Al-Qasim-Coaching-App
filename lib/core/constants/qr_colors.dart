
// Color System
import 'package:flutter/material.dart';

class QrColors {
  static const primary = Color(0xFF6366F1); // Indigo for better contrast
  static const success = Color(0xFF10B981); // Accessible green
  static const error = Color(0xFFEF4444); // Accessible red
  static const warning = Color(0xFFF59E0B); // Amber for "Already distributed"
  static const surface = Color(0xFFF8FAFC);
  static const onSurface = Color(0xFF1E293B);
  
  // Semantic background colors with opacity
  static Color get successBg => success.withOpacity(0.12);
  static Color get errorBg => error.withOpacity(0.12);
  static Color get warningBg => warning.withOpacity(0.12);
  static Color get loadingBg => primary.withOpacity(0.12);
}