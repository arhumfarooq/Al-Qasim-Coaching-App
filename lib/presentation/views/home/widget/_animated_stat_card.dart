import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/core/constants/attendance_Colors.dart';
import 'package:qr_code_scanner/data/models/stat_item.dart';

class AnimatedStatCard extends StatelessWidget {
  final StatItem item;

  const AnimatedStatCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: item.color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon, color: item.color, size: 20.sp),
          const Spacer(),
          Text(
            item.value,
            style: GoogleFonts.poppins(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: AttendanceColors.darkText,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            item.title,
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AttendanceColors.lightText,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            item.change,
            style: GoogleFonts.poppins(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: item.color,
            ),
          ),
        ],
      ),
    )
        .animate(delay: item.delay)
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.2, end: 0);
  }
}
