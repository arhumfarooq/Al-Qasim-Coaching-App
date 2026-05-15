import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/core/constants/attendance_Colors.dart';
import 'package:qr_code_scanner/core/constants/enums.dart';

class AttendanceCalendarView extends StatelessWidget {
  final int totalDays;
  final int startOffset; // number of empty cells before day 1
  final CalendarDayStatus Function(int day) getDayStatus;

  const AttendanceCalendarView({
    super.key,
    required this.totalDays,
    required this.startOffset,
    required this.getDayStatus,
  });

  @override
  Widget build(BuildContext context) {
    const weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

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
      child: Column(
        children: [
          /// Week days header
          Row(
            children: List.generate(
              7,
              (index) => Expanded(
                child: Center(
                  child: Text(
                    weekDays[index],
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AttendanceColors.darkText,
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 16.h),

          /// Calendar grid
          SizedBox(
            height: 200.h,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 8.h,
                crossAxisSpacing: 8.w,
              ),
              itemCount: totalDays + startOffset,
              itemBuilder: (_, index) {
                if (index < startOffset) {
                  return const SizedBox.shrink();
                }

                final day = index - startOffset + 1;
                final status = getDayStatus(day);
                final color = _statusColor(status);

                return _CalendarDayCell(
                  day: day,
                  color: color,
                );
              },
            ),
          ),
        ],
      ),
    )
        .animate(delay: 400.ms)
        .fadeIn()
        .scale(begin: const Offset(0.95, 0.95));
  }
  

  Color _statusColor(CalendarDayStatus status) {
    switch (status) {
      case CalendarDayStatus.present:
        return AttendanceColors.presentColor;
      case CalendarDayStatus.absent:
        return AttendanceColors.absentColor;
      case CalendarDayStatus.holiday:
        return AttendanceColors.holidayColor;
      case CalendarDayStatus.none:
      default:
        return AttendanceColors.lightText;
    }
  }
}



class _CalendarDayCell extends StatelessWidget {
  final int day;
  final Color color;

  const _CalendarDayCell({
    required this.day,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2.w,
        ),
      ),
      child: Center(
        child: Text(
          day.toString(),
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ),
    );
  }
}
