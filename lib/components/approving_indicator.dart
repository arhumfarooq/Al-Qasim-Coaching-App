import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qr_code_scanner/core/constants/app_colors.dart';

class ApprovingIndicator extends StatelessWidget {
  final String text;
  final Color color;
  final double strokeWidth;
  final double size;

  const ApprovingIndicator({
    super.key,
    this.text = 'Approving...',
    this.color = Colors.green,
    this.strokeWidth = 2.0,
    this.size = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: color.withOpacity(0.25),
          width: 1.w,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size.w,
            height: size.w,
            child:   LoadingAnimationWidget.threeRotatingDots(
                            color: AppColors.success,
                            size: 18.sp,
                          ),
          ),
          SizedBox(width: 8.w),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 200.ms)
        .scale(
          duration: 300.ms,
          curve: Curves.easeOutBack,
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
        );
  }
}
