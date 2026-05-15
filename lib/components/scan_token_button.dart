import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:qr_code_scanner/core/constants/app_colors.dart';
import 'package:qr_code_scanner/presentation/viewmodels/auth_controller.dart';

class ScanTokenButton extends StatelessWidget {
  const ScanTokenButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Obx(() {
      final isLoading = authController.isScanningPermission.value;

      return Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          onTap: isLoading
              ? null
              : authController.checkScanPermissionAndNavigate,
          borderRadius: BorderRadius.circular(12.r),
          child: AnimatedOpacity(
            duration: 200.ms,
            opacity: isLoading ? 0.7 : 1,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFFF39C12).withOpacity(0.3),
                  width: 1.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: AnimatedSwitcher(
                duration: 250.ms,
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                  );
                },
                child: isLoading
                    ? Row(
                        key: const ValueKey('loading'),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoadingAnimationWidget.threeRotatingDots(
                            color: AppColors.warningDark,
                            size: 18.sp,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'Checking permission...',
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.warningDark,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        key: const ValueKey('normal'),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            LucideIcons.qrCode,
                            size: 18.sp,
                            color: const Color(0xFFF39C12),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'Scan Token',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFF39C12),
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ).animate(delay: 1000.ms).fadeIn(duration: 600.ms);
    });
  }
}
