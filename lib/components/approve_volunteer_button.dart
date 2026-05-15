import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:qr_code_scanner/presentation/viewmodels/volunteer_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../presentation/views/volunteer_approvals_screen.dart';

class ApproveVolunteerButton extends StatelessWidget {
  final VolunteerController controller;
  final VoidCallback? onTap;
  final String title;
  final String subtitle;
  final String description;
  final double width;
  final double height;

  const ApproveVolunteerButton({
    super.key,
    required this.controller,
    this.onTap,
    this.title = 'APPROVE VOLUNTEER',
    this.subtitle = 'Manage volunteer requests',
    this.description = 'Review and approve new volunteer applications',
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
              gradient: AppColors.approveVolunteerGradient, // Use AppColors
              borderRadius: BorderRadius.circular(18.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.approveVolunteerShadow,
                  blurRadius: 12.r,
                  spreadRadius: 2.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: onTap ??
                  () {
                    Get.to(() => VolunteerApprovalsScreen());
                  },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
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
                  _buildIconWithBadge(controller),
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
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: 9.sp,
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: false))
     .shimmer(delay: NumDurationExtensions(2).seconds, duration: 1500.ms, color: Colors.white24),

          SizedBox(height: 10.h),
          Text(
            description,
            style: GoogleFonts.poppins(
              color: AppColors.textSecondary,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }


Widget _buildIconWithBadge(VolunteerController controller) {
  return Obx(() {
    final count = controller.listCount.value;


    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            LucideIcons.userCheck,
            size: 24.sp,
          ),
        ),

        // Floating badge only when count > 0
        if (count > 0)
          Positioned(
            top: -6.h,
            right: -6.w,
            child: _buildFloatingBadge(count),
          ),
      ],
    );
  });
}


Widget _buildFloatingBadge(int count) {
  final displayCount = count > 99 ? '99+' : count.toString();
  final isDoubleDigit = count > 9;

  return AnimatedSwitcher(
    duration: const Duration(milliseconds: 300),
    switchInCurve: Curves.easeOutBack,
    switchOutCurve: Curves.easeIn,
    transitionBuilder: (child, animation) {
      return ScaleTransition(
        scale: animation,
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
    child: Container(
      key: ValueKey<int>(count), // Animates when count changes
      constraints: BoxConstraints(
        minWidth: isDoubleDigit ? 24.h : 20.h,
        minHeight: 20.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDoubleDigit ? 6.w : 4.w,
        vertical: 2.h,
      ),
      decoration: BoxDecoration(
        // color: AppColors.getBadgeColor(count),
        color: Color(0xFFD32F2F),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4.r,
            offset: Offset(0, 2.h),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 1.r,
            offset: Offset(0, -1.h),
            spreadRadius: 0.5.r,
          ),
        ],
      ),
      child: Center(
        child: Text(
          displayCount,
          style: GoogleFonts.poppins(
            fontSize: 10.sp,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.0,
            letterSpacing: -0.2,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

}