
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:qr_code_scanner/core/constants/attendance_Colors.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/YearlyAttendanceController.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/attendance_controller.dart';
import 'package:qr_code_scanner/presentation/views/attendance/monthly_attendance_screen.dart';
import 'package:qr_code_scanner/presentation/views/attendance/widget/year_summary_chart.dart';
import 'package:qr_code_scanner/presentation/views/home_screen.dart';

class YearlyAttendanceScreen extends StatelessWidget {
  final AttendanceController controller = Get.put(AttendanceController());
  final YearlyAttendanceController yearlyAttendanceController =
    Get.put(YearlyAttendanceController());
  final RxInt selectedYear = 2024.obs;
  
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
            _buildBackgroundElements(),
            
            SafeArea(
              child: Column(
                children: [
                  // Header
                  _buildHeader(context),
                  
                  // Year Selector
                  _buildYearSelector(),
                  
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                      child: Column(
                        children: [
                          // Year Summary Chart
 
                          // YearSummaryChart(selectedYear: 2026),

// Obx(() {
//   if (yearlyAttendanceController.isLoading.value) {
//     return const Center(child: CircularProgressIndicator());
//   }

//   return YearSummaryChart(
//     selectedYear: yearlyAttendanceController.selectedYear.value,
//     months: yearlyAttendanceController.months,
//   );
// })


Obx(() {
  if (yearlyAttendanceController.isLoading.value) {
    return SizedBox(
      height: 220.h,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  if (yearlyAttendanceController.months.isEmpty) {
    return SizedBox(
      height: 220.h,
      child: const Center(
        child: Text('No yearly attendance found'),
      ),
    );
  }

  return YearSummaryChart(
    selectedYear: yearlyAttendanceController.selectedYear.value,
    months: yearlyAttendanceController.months.toList(),
  );
}),

// Obx(() => YearSummaryChart(
//   selectedYear: yearlyAttendanceController.selectedYear.value,
//   months: yearlyAttendanceController.months,
// )),

                          SizedBox(height: 32.h),
                          
                          // Monthly Grid
                          buildMonthlyGrid(context),
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
  
  Widget _buildBackgroundElements() {
    return Stack(
      children: [
        Positioned(
          top: -60,
          right: -40,
          child: Container(
            width: 160.w,
            height: 160.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AttendanceColors.primaryOrange.withOpacity(0.1),
                  AttendanceColors.primaryOrange.withOpacity(0.05),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildHeader(context) {
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
                  child: Text(
                    'Yearly Attendance',
                    style: AttendanceTypography.headlineLarge(context),
                  ).animate().fadeIn(),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(LucideIcons.filter, size: 24.sp),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Track your attendance progress across years',
            style: AttendanceTypography.bodyMedium(context),
          ),
        ],
      ),
    );
  }
  
  // Widget _buildYearSelector() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 16.h),
  //     color: Colors.white,
  //     child: Obx(() => Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         IconButton(
  //           onPressed: () => selectedYear.value--,
  //           icon: Icon(LucideIcons.chevronLeft, size: 24.sp),
  //         ),
  //         SizedBox(width: 16.w),
  //         AnimatedContainer(
  //           duration: 300.ms,
  //           padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
  //           decoration: BoxDecoration(
  //             gradient: selectedYear.value == 2024 
  //                 ? AttendanceColors.primaryGradient
  //                 : LinearGradient(colors: [Colors.grey.shade300, Colors.grey.shade300]),
  //             borderRadius: BorderRadius.circular(25.r),
  //           ),
  //           child: Text(
  //             selectedYear.value.toString(),
  //             style: GoogleFonts.poppins(
  //               fontSize: 20.sp,
  //               fontWeight: FontWeight.w700,
  //               color: selectedYear.value == 2024 ? Colors.white : Colors.grey.shade700,
  //             ),
  //           ),
  //         ).animate().scale(),
  //         SizedBox(width: 16.w),
  //         IconButton(
  //           onPressed: () => selectedYear.value++,
  //           icon: Icon(LucideIcons.chevronRight, size: 24.sp),
  //         ),
  //       ],
  //     )),
  //   );
  // }


// Widget _buildYearSelector() {
//   return Container(
//     padding: EdgeInsets.symmetric(vertical: 16.h),
//     color: Colors.white,
//     child: Obx(() => Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             yearlyAttendanceController.hasPreviousYear
//                 ? IconButton(
//                     onPressed: yearlyAttendanceController.previousYear,
//                     icon: Icon(LucideIcons.chevronLeft, size: 24.sp),
//                   )
//                 : SizedBox(width: 48.w),

//             SizedBox(width: 16.w),

//             AnimatedContainer(
//               duration: 300.ms,
//               padding: EdgeInsets.symmetric(
//                 horizontal: 32.w,
//                 vertical: 12.h,
//               ),
//               decoration: BoxDecoration(
//                 gradient: AttendanceColors.primaryGradient,
//                 borderRadius: BorderRadius.circular(25.r),
//               ),
//               child: Text(
//                 // yearlyAttendanceController.selectedYear.value.toString(),
//                 yearlyAttendanceController.selectedYear.value.toString(),

//                 style: GoogleFonts.poppins(
//                   fontSize: 20.sp,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white,
//                 ),
//               ),
//             ).animate().scale(),

//             SizedBox(width: 16.w),

//             yearlyAttendanceController.hasNextYear
//                 ? IconButton(
//                     onPressed: yearlyAttendanceController.nextYear,
//                     icon: Icon(LucideIcons.chevronRight, size: 24.sp),
//                   )
//                 : SizedBox(width: 48.w),
//           ],
//         )),
//   );
// }


Widget _buildYearSelector() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 16.h),
    color: Colors.white,
    child: Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          /// PREVIOUS YEAR
          AnimatedOpacity(
            duration: 250.ms,
            opacity:
                yearlyAttendanceController.hasPreviousYear
                    ? 1
                    : 0,
            child:
                yearlyAttendanceController.hasPreviousYear
                    ? IconButton(
                        onPressed:
                            yearlyAttendanceController.previousYear,
                        icon: Icon(
                          LucideIcons.chevronLeft,
                          size: 24.sp,
                          color: AttendanceColors.darkText,
                        ),
                      )
                    : SizedBox(width: 48.w),
          ),

          SizedBox(width: 16.w),

          /// YEAR CONTAINER
          AnimatedContainer(
            duration: 300.ms,
            curve: Curves.easeInOut,
            padding: EdgeInsets.symmetric(
              horizontal: 32.w,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              gradient: AttendanceColors.primaryGradient,
              borderRadius: BorderRadius.circular(25.r),
              boxShadow: [
                BoxShadow(
                  color: AttendanceColors.primaryOrange
                      .withOpacity(0.25),
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              yearlyAttendanceController
                  .selectedYear.value
                  .toString(),
              style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ).animate().scale(),

          SizedBox(width: 16.w),

          /// NEXT YEAR
          AnimatedOpacity(
            duration: 250.ms,
            opacity:
                yearlyAttendanceController.hasNextYear
                    ? 1
                    : 0,
            child:
                yearlyAttendanceController.hasNextYear
                    ? IconButton(
                        onPressed:
                            yearlyAttendanceController.nextYear,
                        icon: Icon(
                          LucideIcons.chevronRight,
                          size: 24.sp,
                          color: AttendanceColors.darkText,
                        ),
                      )
                    : SizedBox(width: 48.w),
          ),
        ],
      ),
    ),
  );
}


// Widget buildMonthlyGrid(BuildContext context) {
//   final months = [
//     'January', 'February', 'March', 'April',
//     'May', 'June', 'July', 'August',
//     'September', 'October', 'November', 'December'
//   ];
//   final percentages = [88, 90, 89, 92, 91, 93, 95, 94, 96, 95, 97, 96];

//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         'Monthly Breakdown',
//         style: AttendanceTypography.headlineMedium(context),
//       ).animate(delay: 400.ms).fadeIn(),
//       SizedBox(height: 12.h),

//       // Let GridView determine its own height based on content
//       GridView.builder(
//         shrinkWrap: true, // Important: allows GridView to be inside Column
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: 12,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 16.h,
//           crossAxisSpacing: 16.w,
//           childAspectRatio: 1.0, // Keep this aspect ratio
//         ),
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () => Get.to(() => MonthlyAttendanceScreen()),
//             borderRadius: BorderRadius.circular(16.r),
//             child: Container(
//               padding: EdgeInsets.all(16.w),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16.r),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     spreadRadius: 1,
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         padding: EdgeInsets.all(8.w),
//                         decoration: BoxDecoration(
//                           color: AttendanceColors.primaryOrange.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(12.r),
//                         ),
//                         child: Text(
//                           months[index].substring(0, 3),
//                           style: GoogleFonts.poppins(
//                             fontSize: 12.sp,
//                             fontWeight: FontWeight.w600,
//                             color: AttendanceColors.primaryOrange,
//                           ),
//                         ),
//                       ),
//                       Icon(LucideIcons.chevronRight, size: 16.sp, color: Colors.grey),
//                     ],
//                   ),
//                   SizedBox(height: 12.h),
//                   Text(
//                     months[index],
//                     style: GoogleFonts.poppins(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w600,
//                       color: AttendanceColors.darkText,
//                     ),
//                   ),
//                   SizedBox(height: 8.h),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(10.r),
//                           child: LinearProgressIndicator(
//                             value: percentages[index] / 100,
//                             backgroundColor: Colors.grey.shade200,
//                             valueColor: AlwaysStoppedAnimation(
//                               _getProgressColor(percentages[index]),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 12.w),
//                       Text(
//                         '${percentages[index]}%',
//                         style: GoogleFonts.poppins(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w700,
//                           color: _getProgressColor(percentages[index]),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8.h),
//                   Text(
//                     '18 Present • 2 Absent',
//                     style: GoogleFonts.poppins(
//                       fontSize: 10.sp,
//                       fontWeight: FontWeight.w500,
//                       color: AttendanceColors.lightText,
//                     ),
//                   ),
//                 ],
//               ),
//             ).animate(delay: (index * 100 + 600).ms).fadeIn().scale(begin: Offset(0.9, 0.9)),
//           );
//         },
//       ),
//     ],
//   );
// }

Widget buildMonthlyGrid(BuildContext context) {
  return Obx(() {
    // if (controller.isLoading.value)
    if (yearlyAttendanceController.isLoading.value)
     {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Monthly Breakdown',
          style: AttendanceTypography.headlineMedium(context),
        ).animate(delay: 400.ms).fadeIn(),

        SizedBox(height: 12.h),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: yearlyAttendanceController.months.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (context, index) {
            final item = yearlyAttendanceController.months[index];

            final percentage = item.percentage;
            final isDisabled = !item.hasData;

            return InkWell(
              onTap: isDisabled
                  ? null
                  : () {
                    Get.delete<AttendanceController>();
                      Get.to(
                        () => MonthlyAttendanceScreen(),
                        arguments: {
                          'year': item.year,
                          'month': item.month,
                        },
                      );
                    },
              borderRadius: BorderRadius.circular(16.r),
              child: Opacity(
                opacity: isDisabled ? 0.45 : 1,
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: isDisabled ? Colors.grey.shade200 : Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      if (!isDisabled)
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: isDisabled
                                  ? Colors.grey.shade300
                                  : AttendanceColors.primaryOrange
                                      .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              item.monthName.substring(0, 3),
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: isDisabled
                                    ? Colors.grey
                                    : AttendanceColors.primaryOrange,
                              ),
                            ),
                          ),
                          Icon(
                            LucideIcons.chevronRight,
                            size: 16.sp,
                            color: isDisabled ? Colors.grey : Colors.black45,
                          ),
                        ],
                      ),

                      SizedBox(height: 12.h),

                      Text(
                        item.monthName,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isDisabled
                              ? Colors.grey
                              : AttendanceColors.darkText,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: LinearProgressIndicator(
                                value: isDisabled ? 0 : percentage / 100,
                                backgroundColor: Colors.grey.shade300,
                                valueColor: AlwaysStoppedAnimation(
                                  isDisabled
                                      ? Colors.grey
                                      : _getProgressColor(percentage.round()),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            isDisabled
                                ? '--'
                                : '${percentage.toStringAsFixed(0)}%',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: isDisabled
                                  ? Colors.grey
                                  : _getProgressColor(percentage.round()),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 8.h),

                      Text(
                        isDisabled
                            ? 'No attendance marked'
                            : '${item.present} Present • ${item.absent} Absent',
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: AttendanceColors.lightText,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              // .animate(
              //   delay: (index * 100 + 600).ms,
              // ).fadeIn().scale(begin: const Offset(0.9, 0.9)),
.animate()
.fadeIn(duration: 300.ms)
.scale(
  begin: const Offset(0.96, 0.96),
  duration: 300.ms,
)
            );
          },
        ),
      ],
    );
  });
}



// Widget buildMonthlyGrid(BuildContext context) {
//   return Obx(() {

//     if (yearlyAttendanceController.isLoading.value) {
//       return SizedBox(
//         height: 300.h,
//         child: const Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }

//     if (yearlyAttendanceController.months.isEmpty) {
//       return SizedBox(
//         height: 250.h,
//         child: const Center(
//           child: Text('No attendance found'),
//         ),
//       );
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [

//         Text(
//           'Monthly Breakdown',
//           style: AttendanceTypography.headlineMedium(context),
//         ),

//         SizedBox(height: 12.h),

//         GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),

//           itemCount:
//               yearlyAttendanceController.months.length,

//           gridDelegate:
//               SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 16.h,
//             crossAxisSpacing: 16.w,
//             childAspectRatio: 1.0,
//           ),

//           itemBuilder: (context, index) {

//             final item =
//                 yearlyAttendanceController.months[index];

//             final percentage = item.percentage;

//             final isDisabled = !item.hasData;

//             return InkWell(
//               onTap: isDisabled
//                   ? null
//                   : () {

//                       Get.delete<AttendanceController>();

//                       Get.to(
//                         () => MonthlyAttendanceScreen(),
//                         arguments: {
//                           'year': item.year,
//                           'month': item.month,
//                         },
//                       );
//                     },

//               borderRadius: BorderRadius.circular(16.r),

//               child: Opacity(
//                 opacity: isDisabled ? 0.45 : 1,

//                 child: Container(
//                   padding: EdgeInsets.all(16.w),

//                   decoration: BoxDecoration(
//                     color: isDisabled
//                         ? Colors.grey.shade200
//                         : Colors.white,

//                     borderRadius:
//                         BorderRadius.circular(16.r),

//                     boxShadow: [
//                       if (!isDisabled)
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 10,
//                           spreadRadius: 1,
//                         ),
//                     ],
//                   ),

//                   child: Column(
//                     crossAxisAlignment:
//                         CrossAxisAlignment.start,

//                     children: [

//                       Row(
//                         mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,

//                         children: [

//                           Container(
//                             padding: EdgeInsets.all(8.w),

//                             decoration: BoxDecoration(
//                               color: isDisabled
//                                   ? Colors.grey.shade300
//                                   : AttendanceColors
//                                       .primaryOrange
//                                       .withOpacity(0.1),

//                               borderRadius:
//                                   BorderRadius.circular(12.r),
//                             ),

//                             child: Text(
//                               item.monthName.substring(0, 3),

//                               style: GoogleFonts.poppins(
//                                 fontSize: 12.sp,
//                                 fontWeight: FontWeight.w600,

//                                 color: isDisabled
//                                     ? Colors.grey
//                                     : AttendanceColors
//                                         .primaryOrange,
//                               ),
//                             ),
//                           ),

//                           Icon(
//                             LucideIcons.chevronRight,
//                             size: 16.sp,

//                             color: isDisabled
//                                 ? Colors.grey
//                                 : Colors.black45,
//                           ),
//                         ],
//                       ),

//                       SizedBox(height: 12.h),

//                       Text(
//                         item.monthName,

//                         style: GoogleFonts.poppins(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w600,

//                           color: isDisabled
//                               ? Colors.grey
//                               : AttendanceColors.darkText,
//                         ),
//                       ),

//                       SizedBox(height: 8.h),

//                       Row(
//                         children: [

//                           Expanded(
//                             child: ClipRRect(
//                               borderRadius:
//                                   BorderRadius.circular(10.r),

//                               child: LinearProgressIndicator(
//                                 value: isDisabled
//                                     ? 0
//                                     : percentage / 100,

//                                 backgroundColor:
//                                     Colors.grey.shade300,

//                                 valueColor:
//                                     AlwaysStoppedAnimation(
//                                   isDisabled
//                                       ? Colors.grey
//                                       : _getProgressColor(
//                                           percentage.round(),
//                                         ),
//                                 ),
//                               ),
//                             ),
//                           ),

//                           SizedBox(width: 12.w),

//                           Text(
//                             isDisabled
//                                 ? '--'
//                                 : '${percentage.toStringAsFixed(0)}%',

//                             style: GoogleFonts.poppins(
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w700,

//                               color: isDisabled
//                                   ? Colors.grey
//                                   : _getProgressColor(
//                                       percentage.round(),
//                                     ),
//                             ),
//                           ),
//                         ],
//                       ),

//                       SizedBox(height: 8.h),

//                       Text(
//                         isDisabled
//                             ? 'No attendance marked'
//                             : '${item.present} Present • ${item.absent} Absent',

//                         style: GoogleFonts.poppins(
//                           fontSize: 10.sp,
//                           fontWeight: FontWeight.w500,
//                           color: AttendanceColors.lightText,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   });
// }


  Color _getProgressColor(int percentage) {
    if (percentage >= 95) return AttendanceColors.presentColor;
    if (percentage >= 85) return AttendanceColors.primaryOrange;
    return AttendanceColors.absentColor;
  }
}