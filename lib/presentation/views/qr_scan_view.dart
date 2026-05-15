import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner/core/constants/qr_colors.dart';
import 'package:qr_code_scanner/presentation/viewmodels/tokens_controller.dart';
import '../viewmodels/qr_viewmodel.dart';
class QrScanView extends StatefulWidget {
  const QrScanView({super.key});

  @override
  State<QrScanView> createState() => _QrScanViewState();
}

class _QrScanViewState extends State<QrScanView> {
  final QrViewModel controller = Get.find<QrViewModel>();


  @override
  void dispose() {
    super.dispose();
    Get.find<PendingTokensController>().loadTokens( true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        
        title: const Text("Scan QR Code"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        return Stack(
          children: [
            // Scanner View (Full Screen)
            _buildScannerView(),
            
            // Overlay UI Elements
            _buildScannerOverlay(context),
            
            // Processing Overlay
            if (controller.status.value == QrStatus.loading)
              _buildProcessingOverlay(),
            
            // Status Message (Positioned at top with smooth entrance)
            if (controller.status.value != QrStatus.idle)
              _buildStatusBanner(),
          ],
        );
      }),
    );
  }

  Widget _buildScannerView() {
    return MobileScanner(
      controller: MobileScannerController(
        detectionSpeed: DetectionSpeed.noDuplicates,
        facing: CameraFacing.back,
        torchEnabled: false,
      ),
      onDetect: (barcodeCapture) async{
        if (controller.isProcessing) return;

        final barcode = barcodeCapture.barcodes.firstOrNull;
        final code = barcode?.rawValue;
        if (code == null) return;

        try {
          final uri = Uri.parse(code);
          final id = uri.queryParameters['id'];

          if (id != null) {
                await controller.playScanSound(); // ✅ Play sound only on successful scan
            controller.processQr(id);
          } else {
            controller.message.value = "Invalid QR: No ID found";
            controller.status.value = QrStatus.error;
          }
        } catch (e) {
          controller.message.value = "Invalid QR code format";
          controller.status.value = QrStatus.error;
        }
      },
    );
  }

  Widget _buildScannerOverlay(BuildContext context) {
    return Container(
      // Remove margin to make gradient fully attached to screen borders
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.7),
            Colors.black.withOpacity(0.5),
            Colors.transparent,
            Colors.transparent,
            Colors.black.withOpacity(0.5),
            Colors.black.withOpacity(0.7),
          ],
          stops: const [0.0, 0.15, 0.25, 0.75, 0.85, 1.0],
        ),
      ),
      child: Column(
        children: [
          // Top Guide - Centered content
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Icon(
                      Icons.qr_code_scanner,
                      size: 36,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Align QR code within frame",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Scanner Frame
          Container(
            width: 240,
            height: 240,
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Stack(
              children: [
                // Dotted border for scanner frame
                _buildDottedBorder(),
                
                // Scanner box with solid border (for structure)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                ),
                
                // Animated scanning line
                _buildScanningLine(context),
                
                // Corner indicators
                ..._buildCornerIndicators(),
              ],
            ),
          ),
          
          // Bottom Guide - Centered content
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Scan QR code to view message",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildDottedBorder() {
    return AnimatedContainer(
      duration: 2.seconds,
      child: DottedBorder(
        child: Container(
          width: 240,
          height: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget _buildScanningLine(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 2000),
        curve: Curves.easeInOut,
        height: 2,
        margin: EdgeInsets.only(
          top: (controller.status.value == QrStatus.idle) 
              ? 0 
              : 240, // Use fixed height instead of screen height
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              QrColors.primary.withOpacity(0.8),
              Colors.transparent,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: QrColors.primary.withOpacity(0.4),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        onEnd: () {
          if (controller.status.value == QrStatus.idle) {
            // Restart animation when idle
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (controller.status.value == QrStatus.idle) {
                // Trigger rebuild to restart animation
                controller.update();
              }
            });
          }
        },
      ),
    );
  }

  List<Widget> _buildCornerIndicators() {
    return [
      // Top-left corner
      Positioned(
        top: 0,
        left: 0,
        child: _buildAnimatedCorner(Alignment.topLeft),
      ),
      // Top-right corner
      Positioned(
        top: 0,
        right: 0,
        child: _buildAnimatedCorner(Alignment.topRight),
      ),
      // Bottom-left corner
      Positioned(
        bottom: 0,
        left: 0,
        child: _buildAnimatedCorner(Alignment.bottomLeft),
      ),
      // Bottom-right corner
      Positioned(
        bottom: 0,
        right: 0,
        child: _buildAnimatedCorner(Alignment.bottomRight),
      ),
    ];
  }

  Widget _buildAnimatedCorner(Alignment alignment) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.5, end: 1.0),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            width: 24,
            height: 24,
            alignment: alignment,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    QrColors.primary.withOpacity(value * 0.8),
                    QrColors.primary.withOpacity(value),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusBanner() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Semantics(
        liveRegion: true,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _getBgColor(),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _getTextColor().withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Status icon with semantic label
              Semantics(
                label: _getStatusLabel(),
                child: Icon(
                  _getStatusIcon(),
                  color: _getTextColor(),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  controller.message.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: _getTextColor(),
                    height: 1.3,
                  ),
                  semanticsLabel: "${_getStatusLabel()}: ${controller.message.value}",
                ),
              ),
              // Optional close button for persistent messages
              if (controller.status.value == QrStatus.error || 
                  controller.status.value == QrStatus.success)
                IconButton(
                  icon: Icon(Icons.close, size: 18, color: _getTextColor()),
                  onPressed: () => controller.status.value = QrStatus.idle,
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 36,
                    minHeight: 36,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProcessingOverlay() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Pulsing processing indicator
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.8, end: 1.2),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: QrColors.primary.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.qr_code_scanner,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            Text(
              "Processing QR code...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Please wait",
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBgColor() {
    if (controller.message.value == "Already distributed") {
      return QrColors.warningBg;
    }

    switch (controller.status.value) {
      case QrStatus.success:
        return QrColors.successBg;
      case QrStatus.error:
        return QrColors.errorBg;
      case QrStatus.loading:
        return QrColors.loadingBg;
      default:
        return Colors.transparent;
    }
  }

  Color _getTextColor() {
    if (controller.message.value == "Already distributed") {
      return QrColors.success;
    }

    switch (controller.status.value) {
      case QrStatus.success:
        return QrColors.success;
      case QrStatus.error:
        return QrColors.error;
      case QrStatus.loading:
        return QrColors.primary;
      default:
        return QrColors.onSurface;
    }
  }

  String _getStatusLabel() {
    switch (controller.status.value) {
      case QrStatus.success: return "Success";
      case QrStatus.error: return "Error";
      case QrStatus.loading: return "Loading";
      default: return "Information";
    }
  }

  IconData _getStatusIcon() {
    if (controller.message.value == "Already distributed") {
      return Icons.info_outline;
    }
    switch (controller.status.value) {
      case QrStatus.success: return Icons.check_circle;
      case QrStatus.error: return Icons.error_outline;
      case QrStatus.loading: return Icons.hourglass_top;
      default: return Icons.info_outline;
    }
  }
}

// Custom painter for dotted border effect
class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(12),
      ));

    // Create dashed/dotted effect
    final dashWidth = 8.0;
    final dashSpace = 4.0;
    final pathMetrics = path.computeMetrics();
    
    for (final pathMetric in pathMetrics) {
      var distance = 0.0;
      while (distance < pathMetric.length) {
        canvas.drawPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Extension for null safety
extension FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}