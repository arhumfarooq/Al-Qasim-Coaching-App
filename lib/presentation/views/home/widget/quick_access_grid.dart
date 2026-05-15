import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/core/constants/attendance_Colors.dart';
import 'package:qr_code_scanner/data/models/quick_action_item.dart';

class QuickAccessGrid extends StatelessWidget {
  final String title;
  final List<QuickActionItem> actions;
  final int crossAxisCount;

  const QuickAccessGrid({
    super.key,
    required this.title,
    required this.actions,
    this.crossAxisCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: AttendanceColors.darkText,
          ),
        )
            .animate(delay: 1000.ms)
            .fadeIn(duration: 600.ms)
            .slideX(begin: -0.1, end: 0),
        SizedBox(height: 16.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: actions.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            // childAspectRatio: 0.9,

            // childAspectRatio: 0.9,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (_, index) =>
              _QuickAccessItem(item: actions[index], index: index),
        ),
      ],
    );
  }
}

class _QuickAccessItem extends StatelessWidget {
  final QuickActionItem item;
  final int index;

  const _QuickAccessItem({
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        // padding: EdgeInsets.all(12.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: item.color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(item.icon, color: item.color,
            
            //  size: 22.sp
             size: 28.sp
             
             ),
            const Spacer(),
            Expanded(child: SizedBox()),

            Text(
              item.title,
              style: GoogleFonts.poppins(
                // fontSize: 12.sp,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: AttendanceColors.darkText,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              item.subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                // fontSize: 10.sp,
                fontSize: 11.5.sp,
                fontWeight: FontWeight.w500,
                color: AttendanceColors.lightText,
              ),
            ),
          ],
        ),
      )
          .animate(delay: (1100 + index * 100).ms)
          .fadeIn(duration: 500.ms)
          .slideY(begin: 0.2, end: 0),
    );
  }
}
