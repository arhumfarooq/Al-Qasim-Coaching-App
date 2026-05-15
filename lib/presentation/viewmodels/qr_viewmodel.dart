
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/core/utils/haptics.dart';
import '../../domain/repositories/qr_repository.dart';

enum QrStatus { idle, loading, success, error }

class QrViewModel extends GetxController {
  final QrRepository repository;
final AudioPlayer _audioPlayer = AudioPlayer();

  // 🔹 Track last scan to debounce
  DateTime _lastScanTime = DateTime.now().subtract(const Duration(seconds: 1));

  QrViewModel(this.repository);

  final status = QrStatus.idle.obs;
  final message = ''.obs;

  bool isProcessing = false;

  Future<void> processQr(String code) async {
    if (isProcessing) return;

    isProcessing = true;

    try {
      status.value = QrStatus.loading;

      final response = await repository.submitQr(code);
      // ✅ Use API message
      message.value = response.message ?? "Success";

      // API status handling
      if (response.statusAPI == 1) {
        
        status.value = QrStatus.success;
        await QrHapticFeedback.onSuccess();

      } else {
        status.value = QrStatus.error;
      }
    } catch (e) {
      status.value = QrStatus.error;
      message.value = "Submission failed";
    } finally {
      isProcessing = false;
    }
  }

   Future<void> playScanSound() async {
    final now = DateTime.now();
    if (now.difference(_lastScanTime) < const Duration(milliseconds: 500)) return;
    _lastScanTime = now;

    // Play scan sound
    await _audioPlayer.play(AssetSource('sounds/scan.mp3'));

    // Optional haptic feedback
    HapticFeedback.lightImpact();
  }
}

