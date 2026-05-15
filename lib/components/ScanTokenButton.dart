import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/constants/app_colors.dart';

class ScanTokenButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String subtitle;
  final IconData icon;
  final double width;
  final double height;

  const ScanTokenButtonWidget({
    super.key,
    required this.onTap,
    this.title = 'SCAN TOKEN',
    this.subtitle = 'Tap to scan QR code',
    this.icon = LucideIcons.qrCode,
    this.width = 200,
    this.height = 64,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.scanButtonGradient,
              borderRadius: BorderRadius.circular(18.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.scanButtonShadow,
                  blurRadius: 12.r,
                  spreadRadius: 2.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.transparent,
                foregroundColor: AppColors.textWhite,
                minimumSize: Size(width.w, height.h),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 14.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.r),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: AppColors.textWhite.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      icon,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.3,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: 9.sp,
                          color: AppColors.textWhite.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          // ).animate().scale(
          //       duration: 600.ms,
          //       curve: Curves.elasticOut,
          //       begin: const Offset(0.92, 0.92),
          //       end: const Offset(1.0, 1.0),
          //     ),
          ).animate(onPlay: (c) => c.repeat(reverse: false))
     .shimmer(delay: NumDurationExtensions(2).seconds, duration: 1500.ms, color: Colors.white24),

          SizedBox(height: 10.h),
          Text(
            'Scan distribution tokens to verify and process',
            style: GoogleFonts.poppins(
              color: AppColors.textSecondary,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
