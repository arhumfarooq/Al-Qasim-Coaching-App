import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/core/constants/attendance_Colors.dart';
import 'package:qr_code_scanner/data/models/month_summary_item.dart';

class MonthSummaryWidget extends StatelessWidget {
  final List<MonthSummaryItem> items;

  const MonthSummaryWidget({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: List.generate(
          items.length * 2 - 1,
          (index) {
            if (index.isOdd) {
              return Container(
                width: 1.w,
                height: 40.h,
                color: Colors.grey.shade200,
              );
            }
            final itemIndex = index ~/ 2;
            return Expanded(
              child: _buildSummaryItem(
                value: items[itemIndex].value,
                label: items[itemIndex].label,
                color: items[itemIndex].color,
              ),
            );
          },
        ),
      ),
    )
        .animate(delay: 200.ms)
        .fadeIn()
        .slideY(begin: 0.2, end: 0);
  }
}

 
  Widget _buildSummaryItem({required String value, required String label, required Color color}) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AttendanceColors.lightText,
          ),
        ),
      ],
    );
  }