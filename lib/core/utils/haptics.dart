import 'package:flutter/services.dart';

class QrHapticFeedback {
static Future<void> onScanDetected() async {
    try {
      // Light, subtle vibration for scan detection
      await HapticFeedback.selectionClick();
    } catch (e) {
      // Silently fail if haptics aren't available
      // This can happen on web, desktop, or devices without vibration
    }
  }
  
  static Future<void> onSuccess() async {
    try {
      // Medium vibration for positive feedback
      await HapticFeedback.mediumImpact();
    } catch (e) {
      // Fallback - no vibration
    }
  }
  
  static Future<void> onError() async {
    try {
      // Stronger vibration for error states
      await HapticFeedback.heavyImpact();
    } catch (e) {
      // Fallback - no vibration
    }
  }
  
  static Future<void> onAlreadyDistributed() async {
    try {
      // Patterned vibration for warning/info states
      await HapticFeedback.lightImpact();
      await Future.delayed(const Duration(milliseconds: 100));
      await HapticFeedback.lightImpact();
    } catch (e) {
      // Fallback - no vibration
    }
  }
  
  static Future<void> onProcessing() async {
    try {
      // Very light feedback for processing start
      await HapticFeedback.lightImpact();
    } catch (e) {
      // Fallback - no vibration
    }
  }
}

