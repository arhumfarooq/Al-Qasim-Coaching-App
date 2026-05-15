import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';

class AppToast {
  static void success(String description, {String? title}) {
    toastification.show(
      title: Text(title ?? 'Success', style: const TextStyle(fontWeight: FontWeight.bold)),
      description: Text(description),
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      
showIcon: false,
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  static void error(String description, {String? title}) {
    toastification.show(
      title: Text(title ?? 'Error', style: const TextStyle(fontWeight: FontWeight.bold)),
      description: Text(description),
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,

showIcon: false,
      autoCloseDuration: const Duration(seconds: 4),
    );
  }

  static void warning(String description, {String? title}) {
    toastification.show(
      title: Text(title ?? 'Warning', style: const TextStyle(fontWeight: FontWeight.bold)),
      description: Text(description),
      type: ToastificationType.warning,
      style: ToastificationStyle.flatColored,

showIcon: false,
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  static void info(String description, {String? title}) {
    toastification.show(
      title: Text(title ?? 'Info', style: const TextStyle(fontWeight: FontWeight.bold)),
      description: Text(description),
      type: ToastificationType.info,
      style: ToastificationStyle.flatColored,

showIcon: false,
      autoCloseDuration: const Duration(seconds: 3),
    );
  }
}
