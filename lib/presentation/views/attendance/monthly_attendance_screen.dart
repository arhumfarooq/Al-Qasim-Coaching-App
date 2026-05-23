

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:qr_code_scanner/components/background_gradient_circle.dart';
import 'package:qr_code_scanner/core/constants/attendance_Colors.dart';
import 'package:qr_code_scanner/core/constants/enums.dart' show CalendarDayStatus;
import 'package:qr_code_scanner/data/models/month_summary_item.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/attendance_controller.dart';
import 'package:qr_code_scanner/presentation/views/attendance/widget/attendance_calendar_view.dart';
import 'package:qr_code_scanner/presentation/views/attendance/widget/attendance_detail_item.dart';
import 'package:qr_code_scanner/presentation/views/attendance/widget/month_summary_widget.dart';
import 'package:qr_code_scanner/presentation/views/home_screen.dart';

// Import your YearlyAttendanceScreen
import 'package:qr_code_scanner/presentation/views/attendance/yearly_attendance_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MonthlyAttendanceScreen extends StatelessWidget {
  final AttendanceController controller = Get.put(AttendanceController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AttendanceColors.backgroundWhite,
              AttendanceColors.warmWhite,
              AttendanceColors.lightOrangeTint,
            ],
          ),
        ),
        child: Stack(
          children: [
            BackgroundGradientCircle(),

            SafeArea(
              child: Column(
                children: [
                  // Header with back and month selector
                  _buildHeader(context),
                  
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                      child: Column(
                        children: [
                        
Obx(() {
 return Skeletonizer(
  enabled: controller.isLoading.value,
  child:   MonthSummaryWidget(
    items: [
      MonthSummaryItem(
        value: controller.presentCount.toString(),
        label: 'Present',
        color: AttendanceColors.presentColor,
      ),
      MonthSummaryItem(
        value: controller.absentCount.toString(),
        label: 'Absent',
        color: AttendanceColors.absentColor,
      ),
      MonthSummaryItem(
        value: controller.percentage,
        label: 'Percentage',
        color: AttendanceColors.primaryOrange,
      ),
    ],
  ),
 )
  ;
  

}),
                          SizedBox(height: 24.h),
                          
                          // Calendar View
                          // AttendanceCalendarView(
                          //   totalDays: 31,
                          //   startOffset: 1,
                          //   getDayStatus: (day) {
                          //     if (day == 5 || day == 12) return CalendarDayStatus.absent;
                          //     if (day == 10) return CalendarDayStatus.holiday;
                          //     return CalendarDayStatus.present;
                          //   },
                          // ),
//                           Obx(() => AttendanceCalendarView(
//   totalDays: controller.totalDays,
//   startOffset: controller.startOffset,
//   getDayStatus: controller.getDayStatus,
// )),
// Obx(() {
//   if (controller.isLoading.value) {
//     return const Center(
//       child: CircularProgressIndicator(),
//     );
//   }

//   return AttendanceCalendarView(
//     totalDays: controller.totalDays,
//     startOffset: controller.startOffset,
//     getDayStatus: controller.getDayStatus,
//   );
// }),
      
      Obx(() {
  return Skeletonizer(
    enabled: controller.isLoading.value,
    child: AttendanceCalendarView(
      totalDays: controller.totalDays,
      startOffset: controller.startOffset,
      getDayStatus: controller.getDayStatus,
    ),
  );
}),
      
                          SizedBox(height: 32.h),
                          
                          // Legend
                          _buildLegend(),
                          SizedBox(height: 32.h),
                          
                          // View Yearly Summary Button
                          _buildYearlySummaryButton(context),
                          SizedBox(height: 32.h),
                          
                          // Detailed List
                          _buildDetailedList(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildYearlySummaryButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AttendanceColors.primaryOrange.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  LucideIcons.calendar,
                  color: AttendanceColors.primaryOrange,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Yearly Attendance Overview',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AttendanceColors.darkText,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'View your complete attendance history across the academic year',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: AttendanceColors.lightText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          InkWell(
            onTap: () => Get.to(() => YearlyAttendanceScreen()),
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
              decoration: BoxDecoration(
                gradient: AttendanceColors.primaryGradient,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: AttendanceColors.primaryOrange.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    LucideIcons.barChart3,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'View Yearly Summary',
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ).animate(
              onPlay: (controller) => controller.repeat(reverse: true),
            ).scale(
              duration: NumDurationExtensions(1.5).seconds,
              begin: Offset(1.0, 1.0),
              end: Offset(1.0, 1.03),
              curve: Curves.easeInOut,
            ),
          ),
        ],
      ),
    ).animate(delay: 700.ms).fadeIn().slideY(begin: 0.2, end: 0);
  }

//   Widget _buildHeader(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             spreadRadius: 1,
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               IconButton(
//                 onPressed: () => Get.back(),
//                 icon: Icon(LucideIcons.chevronLeft, size: 24.sp),
//               ),
//               Expanded(
//                 child: Center(
//                   child: 
//                   // Text(
//                   //   'December 2025',
//                   //   style: AttendanceTypography.headlineLarge(context),
//                   // ).animate().fadeIn(),
//                   Obx(() => Text(
//   '${controller.monthName} ${controller.year}',
//   style: AttendanceTypography.headlineLarge(context),
// ))
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {},
//                 icon: Icon(LucideIcons.calendar, size: 24.sp),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.h),
          
//           // Month Navigation
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 onPressed: () {},
//                 icon: Icon(LucideIcons.chevronLeft, size: 20.sp),
//               ),
//               SizedBox(width: 16.w),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
//                 decoration: BoxDecoration(
//                   gradient: AttendanceColors.primaryGradient,
//                   borderRadius: BorderRadius.circular(20.r),
//                 ),
//                 child: Text(
//                   'December',
//                   style: GoogleFonts.poppins(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               SizedBox(width: 16.w),
//               IconButton(
//                 onPressed: () {},
//                 icon: Icon(LucideIcons.chevronRight, size: 20.sp),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }


 Widget _buildHeader(BuildContext context) {
  return Container(
    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          spreadRadius: 1,
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => Get.back(),
              icon: Icon(LucideIcons.chevronLeft, size: 24.sp),
            ),

            Expanded(
              child: Center(
                child: Obx(() => Text(
                      '${controller.monthName} ${controller.year}',
                      style: AttendanceTypography.headlineLarge(context),
                    )),
              ),
            ),

            IconButton(
              onPressed: controller.refreshAttendance,
              icon: Icon(LucideIcons.calendar, size: 24.sp),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => controller.hasPreviousMonth
                ? IconButton(
                    onPressed: controller.previousMonth,
                    icon: Icon(
                      LucideIcons.chevronLeft,
                      size: 20.sp,
                    ),
                  )
                : SizedBox(width: 48.w)),

            SizedBox(width: 16.w),

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 8.h,
              ),
              decoration: BoxDecoration(
                gradient: AttendanceColors.primaryGradient,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Obx(() => Text(
                    controller.monthName,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  )),
            ),

            SizedBox(width: 16.w),

            Obx(() => controller.hasNextMonth
                ? IconButton(
                    onPressed: controller.nextMonth,
                    icon: Icon(
                      LucideIcons.chevronRight,
                      size: 20.sp,
                    ),
                  )
                : SizedBox(width: 48.w)),
          ],
        ),
      ],
    ),
  );
}



  // Widget _buildLegend() {
  //   return Container(
  //     padding: EdgeInsets.all(16.w),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(16.r),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.03),
  //           blurRadius: 8,
  //           spreadRadius: 1,
  //         ),
  //       ],
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         _buildLegendItem(
  //           color: AttendanceColors.presentColor,
  //           label: 'Present',
  //           icon: LucideIcons.checkCircle,
  //         ),
  //         _buildLegendItem(
  //           color: AttendanceColors.absentColor,
  //           label: 'Absent',
  //           icon: LucideIcons.xCircle,
  //         ),
  //         _buildLegendItem(
  //           color: AttendanceColors.holidayColor,
  //           label: 'Holiday',
  //           icon: LucideIcons.calendar,
  //         ),
  //       ],
  //     ),
  //   ).animate(delay: 600.ms).fadeIn();
  // }

Widget _buildLegend() {
  return Obx(() => Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildLegendItem(
              color: AttendanceColors.presentColor,
              label: 'Present',
              icon: LucideIcons.checkCircle,
              filter: 'present',
            ),
            _buildLegendItem(
              color: AttendanceColors.absentColor,
              label: 'Absent',
              icon: LucideIcons.xCircle,
              filter: 'absent',
            ),
            _buildLegendItem(
              color: AttendanceColors.holidayColor,
              label: 'Holiday',
              icon: LucideIcons.calendar,
              filter: 'holiday',
            ),
          ],
        ),
      )).animate(delay: 600.ms).fadeIn();
}

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Present': return LucideIcons.checkCircle;
      case 'Absent': return LucideIcons.xCircle;
      case 'Holiday': return LucideIcons.calendar;
      default: return LucideIcons.clock;
    }
  }
  
  // Widget _buildLegendItem({required Color color, required String label, required IconData icon}) {
  //   return Row(
  //     children: [
  //       Container(
  //         width: 12.w,
  //         height: 12.h,
  //         decoration: BoxDecoration(
  //           color: color,
  //           shape: BoxShape.circle,
  //         ),
  //       ),
  //       SizedBox(width: 8.w),
  //       Icon(icon, size: 16.sp, color: color),
  //       SizedBox(width: 4.w),
  //       Text(
  //         label,
  //         style: GoogleFonts.poppins(
  //           fontSize: 12.sp,
  //           fontWeight: FontWeight.w500,
  //           color: AttendanceColors.darkText,
  //         ),
  //       ),
  //     ],
  //   );
  // }


Widget _buildLegendItem({
  required Color color,
  required String label,
  required IconData icon,
  required String filter,
}) {
  final isSelected = controller.selectedFilter.value == filter;

  return InkWell(
    onTap: () {
      if (controller.selectedFilter.value == filter) {
        controller.changeFilter('all');
      } else {
        controller.changeFilter(filter);
      }
    },
    borderRadius: BorderRadius.circular(20.r),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? color.withOpacity(0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isSelected ? color : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 10.w,
            height: 10.h,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 4.w),
          Icon(icon, size: 14.sp, color: color),
          SizedBox(width: 4.w),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: AttendanceColors.darkText,
            ),
          ),
        ],
      ),
    ),
  );
}
  Widget _buildDetailedList(BuildContext context) {
  return 
  
// Obx(() {


// final markedDays = controller.filteredMarkedDays;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [

//         Text(
//           'Detailed Attendance',
//           style: AttendanceTypography.headlineMedium(context),
//         ).animate(delay: 800.ms).fadeIn(),

//         SizedBox(height: 16.h),

//         if (controller.isLoading.value)
//           const Center(
//             child: CircularProgressIndicator(),
//           ),

//         if (!controller.isLoading.value &&
//             markedDays.isEmpty)
//           const Text(
//             'No attendance marked yet',
//           ),

//         if (!controller.isLoading.value)
//           ...markedDays.map((item) {

//             final statusText =
//                 controller.getStatusText(item.status);

//             return AttendanceDetailItem(
//               day: controller.getDayName(item.date),

//               date: controller.getDateText(item.date),

//               time: item.status == 'holiday'
//                   ? 'Sunday Holiday'
//                   : 'Attendance Marked',

//               status: statusText,

//             color: AttendanceColors.getAttendanceStatusColor(
//   item.status,
// ),

//               icon: _getStatusIcon(statusText),
//             );

//           }).toList()
//               .animate(interval: 100.ms)
//               .fadeIn()
//               .slideX(begin: 0.1),
//       ],
//     );
//   });


Obx(() {

  final markedDays = controller.filteredMarkedDays;

  return Skeletonizer(
    enabled: controller.isLoading.value,

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          'Detailed Attendance',
          style: AttendanceTypography.headlineMedium(context),
        ).animate(delay: 800.ms).fadeIn(),

        SizedBox(height: 16.h),

        if (!controller.isLoading.value &&
            markedDays.isEmpty)
          const Text(
            'No attendance marked yet',
          ),

        if (!controller.isLoading.value)
          ...markedDays.map((item) {

            final statusText =
                controller.getStatusText(item.status);

            return AttendanceDetailItem(
              day: controller.getDayName(item.date),

              date: controller.getDateText(item.date),

              time: item.status == 'holiday'
                  ? 'Sunday Holiday'
                  : 'Attendance Marked',

              status: statusText,

              color: AttendanceColors.getAttendanceStatusColor(
                item.status,
              ),

              icon: _getStatusIcon(statusText),
            );

          }).toList()
              .animate(interval: 100.ms)
              .fadeIn()
              .slideX(begin: 0.1),
      ],
    ),
  );
});
}
}