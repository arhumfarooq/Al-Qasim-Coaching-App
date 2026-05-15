import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:qr_code_scanner/core/constants/attendance_Colors.dart';
import 'package:qr_code_scanner/data/models/stat_item.dart';
import 'package:qr_code_scanner/presentation/views/home/widget/_animated_stat_card.dart';

class AnimatedStatsSection extends StatelessWidget {
  final String title;
  final String filterLabel;
  final IconData filterIcon;
  final Color filterColor;
  final List<StatItem> stats;

  const AnimatedStatsSection({
    super.key,
    required this.title,
    required this.filterLabel,
    required this.stats,
    this.filterIcon = LucideIcons.trendingUp,
    this.filterColor = AttendanceColors.primaryOrange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Header(
            title: title,
            filterLabel: filterLabel,
            filterIcon: filterIcon,
            filterColor: filterColor,
          ),
          SizedBox(height: 20.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: stats.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
            ),
            itemBuilder: (_, index) =>
                AnimatedStatCard(item: stats[index]),
          ),
        ],
      ),
    )
        .animate(delay: 550.ms)
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, end: 0);
  }
}

class Header extends StatelessWidget {
  final String title;
  final String filterLabel;
  final IconData filterIcon;
  final Color filterColor;

  const Header({
    required this.title,
    required this.filterLabel,
    required this.filterIcon,
    required this.filterColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AttendanceColors.darkText,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: filterColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            children: [
              Icon(filterIcon, size: 14.sp, color: filterColor),
              SizedBox(width: 4.w),
              Text(
                filterLabel,
                style: GoogleFonts.poppins(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: filterColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
