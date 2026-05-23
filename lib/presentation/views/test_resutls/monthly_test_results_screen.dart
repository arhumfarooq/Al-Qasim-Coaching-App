import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:qr_code_scanner/components/test_constants.dart';
import 'package:qr_code_scanner/core/constants/attendance_Colors.dart';
import 'package:qr_code_scanner/data/models/datafetch/test_result_model.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/test_result_controller.dart';
import 'package:qr_code_scanner/presentation/views/test_resutls/test_results_screen.dart';
import 'package:qr_code_scanner/presentation/views/test_resutls/test_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';


class MonthlyTestResultsScreen extends StatelessWidget {
  final TestResultController controller = Get.find();
  final RxString selectedMonth = 'December 2024'.obs;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AttendanceColors.warmWhite,
      body: Stack(
        children: [
          _buildBackgroundElements(),
          
          SafeArea(
            child: Column(
              children: [
                // Header
                _buildHeader(context),
                
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                    child: Column(
                      children: [
                        // Month Summary
                        _buildMonthSummary(),
                        SizedBox(height: 24.h),
                        
                        // Month Navigation
                        _buildMonthNavigation(),
                        SizedBox(height: 24.h),
                        
                        // Tests List
                        _buildTestsList(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBackgroundElements() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          left: -80,
          child: Container(
            width: 240.w,
            height: 240.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AttendanceColors.primaryOrange.withOpacity(0.03),
                  AttendanceColors.primaryOrange.withOpacity(0.01),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildHeader(BuildContext context) {
  //   return Container(
  //     padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.05),
  //           blurRadius: 10,
  //           spreadRadius: 1,
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             IconButton(
  //               onPressed: () => Get.back(),
  //               icon: Icon(LucideIcons.chevronLeft, size: 24.sp),
  //             ),
  //             Expanded(
  //               child: Center(
  //                 child: Text(
  //                   'Monthly Results',
  //                   style: AttendanceTypography.headlineLarge(context),
  //                 ).animate().fadeIn(),
  //               ),
  //             ),
              
  //           ],
  //         ),
  //         SizedBox(height: 8.h),
  //         Obx(() => Text(
  //           selectedMonth.value,
  //           style: AttendanceTypography.bodyMedium(context),
  //         )),
  //       ],
  //     ));
  // }

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
              icon: Icon(
                LucideIcons.chevronLeft,
                size: 24.sp,
              ),
            ),

            Expanded(
              child: Center(
                child: Text(
                  'Monthly Results',
                  style: AttendanceTypography
                      .headlineLarge(context),
                ).animate().fadeIn(),
              ),
            ),

            SizedBox(width: 48.w),
          ],
        ),

        SizedBox(height: 8.h),

        Obx(() {

          const months = [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July',
            'August',
            'September',
            'October',
            'November',
            'December',
          ];

          final monthName =
              months[
                  controller
                          .selectedMonth
                          .value -
                      1
              ];

          final year =
              controller
                  .selectedYear
                  .value;

          return Text(
            '$monthName $year',
            style: AttendanceTypography
                .bodyMedium(context),
          );
        }),
      ],
    ),
  );
}

Widget _buildMonthSummary() {
  return Obx(() {

    final monthResults =
        controller.selectedMonthResults;

    final testsTaken = monthResults.length;

    double avgScore = 0;

    if (monthResults.isNotEmpty) {
      final total = monthResults.fold<double>(
        0,
        (sum, item) => sum + item.percentage,
      );

      avgScore = total / monthResults.length;
    }

    double avgRank = 0;

    if (monthResults.isNotEmpty) {
      final totalRank = monthResults.fold<int>(
        0,
        (sum, item) => sum + item.rank,
      );

      avgRank = totalRank / monthResults.length;
    }

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
        children: [

          Expanded(
            child: _buildSummaryItem(
              icon: LucideIcons.clipboardList,
              value: '$testsTaken',
              label: 'Tests Taken',
              color: AttendanceColors.primaryOrange,
            ),
          ),

          Container(
            width: 1.w,
            height: 40.h,
            color: Colors.grey.shade200,
          ),

          Expanded(
            child: _buildSummaryItem(
              icon: LucideIcons.trendingUp,
              value: '${avgScore.toStringAsFixed(0)}%',
              label: 'Avg Score',
              color: AttendanceColors.presentColor,
            ),
          ),

          Container(
            width: 1.w,
            height: 40.h,
            color: Colors.grey.shade200,
          ),

          Expanded(
            child: _buildSummaryItem(
              icon: LucideIcons.award,
              value: testsTaken == 0
                  ? '--'
                  // : '#${avgRank.toStringAsFixed(0)}',
                  :'#${controller.averageRank}',
              label: 'Avg Rank',
              color: AttendanceColors.darkText,
            ),
          ),
        ],
      ),
    ).animate(delay: 200.ms)
        .fadeIn()
        .slideY(begin: 0.2, end: 0);
  });
}

  // Widget _buildMonthSummary() {
  //   return Container(
  //     padding: EdgeInsets.all(20.w),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(20.r),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.05),
  //           blurRadius: 15,
  //           spreadRadius: 2,
  //         ),
  //       ],
  //     ),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: _buildSummaryItem(
  //             icon: LucideIcons.clipboardList,
  //             value: '3',
  //             label: 'Tests Taken',
  //             color: AttendanceColors.primaryOrange,
  //           ),
  //         ),
  //         Container(
  //           width: 1.w,
  //           height: 40.h,
  //           color: Colors.grey.shade200,
  //         ),
  //         Expanded(
  //           child: _buildSummaryItem(
  //             icon: LucideIcons.trendingUp,
  //             value: '85%',
  //             label: 'Avg Score',
  //             color: AttendanceColors.presentColor,
  //           ),
  //         ),
  //         Container(
  //           width: 1.w,
  //           height: 40.h,
  //           color: Colors.grey.shade200,
  //         ),
  //         Expanded(
  //           child: _buildSummaryItem(
  //             icon: LucideIcons.award,
  //             value: '#9',
  //             label: 'Avg Rank',
  //             color: AttendanceColors.darkText,
  //           ),
  //         ),
  //       ],
  //     ),
  //   ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2, end: 0);
  // }
  
  Widget _buildSummaryItem({required IconData icon, required String value, required String label, required Color color}) {
    return Column(
      children: [
        Icon(icon, size: 24.sp, color: color),
        SizedBox(height: 8.h),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AttendanceColors.lightText,
          ),
        ),
      ],
    );
  }
  
  // Widget _buildMonthNavigation() {
  //   final months = ['October', 'November', 'December', 'January', 'February'];
    
  //   return SizedBox(
  //     height: 60.h,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: months.length,
  //       itemBuilder: (context, index) {
  //         final isSelected = months[index] == 'December';
          
  //         return GestureDetector(
  //           onTap: () => selectedMonth.value = '${months[index]} 2024',
  //           child: Container(
  //             margin: EdgeInsets.only(right: 12.w),
  //             padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
  //             decoration: BoxDecoration(
  //               gradient: isSelected 
  //                   ? AttendanceColors.primaryGradient
  //                   : LinearGradient(colors: [Colors.grey.shade100, Colors.grey.shade100]),
  //               borderRadius: BorderRadius.circular(30.r),
  //             ),
  //             child: Center(
  //               child: Text(
  //                 months[index],
  //                 style: GoogleFonts.poppins(
  //                   fontSize: 14.sp,
  //                   fontWeight: FontWeight.w600,
  //                   color: isSelected ? Colors.white : AttendanceColors.lightText,
  //                 ),
  //               ),
  //             ),
  //           ).animate(delay: (index * 100 + 300).ms)
  //             .fadeIn()
  //             .scale(begin: Offset(0.9, 0.9)),
  //         );
  //       },
  //     ),
  //   );
  // }


Widget _buildMonthNavigation() {
  const months = AppDateUtils.fullMonths;

  return SizedBox(
    height: 60.h,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: months.length,
      itemBuilder: (context, index) {
        final monthNumber = index + 1;

        return Obx(() {
          final isSelected =
              controller.selectedMonth.value == monthNumber;

          final isFuture =
              controller.isFutureMonth(monthNumber);

          return GestureDetector(
            onTap: isFuture
                ? null
                : () => controller.changeMonth(monthNumber),
            child: Opacity(
              opacity: isFuture ? 0.45 : 1,
              child: Container(
                margin: EdgeInsets.only(right: 12.w),
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 12.h,
                ),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? AttendanceColors.primaryGradient
                      : LinearGradient(
                          colors: [
                            isFuture
                                ? Colors.grey.shade300
                                : Colors.grey.shade100,
                            isFuture
                                ? Colors.grey.shade300
                                : Colors.grey.shade100,
                          ],
                        ),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Center(
                  child: Text(
                    months[index],
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : isFuture
                              ? Colors.grey
                              : AttendanceColors.lightText,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
      },
    ),
  );
}
 Widget _buildTestsList(BuildContext context) {
  return 
  
  // Obx(() {
  //   final monthResults =
  //       controller.selectedMonthResults;

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Text(
  //         'Tests in ${controller.selectedMonthName}',
  //         style: AttendanceTypography.headlineMedium(context),
  //       ).animate(delay: 600.ms).fadeIn(),

  //       SizedBox(height: 16.h),

  //       if (controller.isLoading.value)
  //         const Center(child: CircularProgressIndicator()),

  //       if (!controller.isLoading.value &&
  //           monthResults.isEmpty)
  //         const Text(
  //           'No test has been taken this month',
  //         ),

  //       if (!controller.isLoading.value)
  //         ...monthResults.map((item) {
  //           return _buildTestDetailCard(item);
  //         }).toList()
  //             .animate(interval: 100.ms)
  //             .fadeIn()
  //             .slideX(begin: 0.1),
  //     ],
  //   );
  // });


Obx(() {
  final monthResults =
      controller.selectedMonthResults;

  return Skeletonizer(
    enabled: controller.isLoading.value,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Tests in ${controller.selectedMonthName}',
          style: AttendanceTypography.headlineMedium(context),
        ).animate(delay: 600.ms).fadeIn(),

        SizedBox(height: 16.h),

        if (!controller.isLoading.value &&
            monthResults.isEmpty)
          const Text(
            'No test has been taken this month',
          ),

        if (!controller.isLoading.value)
          ...monthResults.map((item) {
            return _buildTestDetailCard(item);
          }).toList()
              .animate(interval: 100.ms)
              .fadeIn()
              .slideX(begin: 0.1),
      ],
    ),
  );
});

}
  
  // Widget _buildTestDetailCard(int index) {
  //   final tests = [
  //     {
  //       'name': 'Unit Test 3',
  //       'subject': 'Algebra',
  //       'chapter': 'Chapter 4: Quadratic Equations',
  //       'date': 'Dec 15, 2024',
  //       'score': 85,
  //       'total': 100,
  //       'rank': 7,
  //       'classAvg': 78,
  //       'topScore': 96,
  //     },
  //     {
  //       'name': 'Monthly Test 1',
  //       'subject': 'Geometry',
  //       'chapter': 'Chapters 1-3 Review',
  //       'date': 'Dec 5, 2024',
  //       'score': 88,
  //       'total': 100,
  //       'rank': 8,
  //       'classAvg': 82,
  //       'topScore': 95,
  //     },
  //     {
  //       'name': 'Unit Test 2',
  //       'subject': 'Calculus',
  //       'chapter': 'Chapter 3: Derivatives',
  //       'date': 'Nov 20, 2024',
  //       'score': 82,
  //       'total': 100,
  //       'rank': 12,
  //       'classAvg': 76,
  //       'topScore': 94,
  //     },
  //   ];
    
  //   final test = tests[index];
  //   final percentage = ((test['score']! as int )/ (test['total']! as int ) * 100).toInt();

  //   return Container(
  //     margin: EdgeInsets.only(bottom: 16.h),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(20.r),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.05),
  //           blurRadius: 10,
  //           spreadRadius: 2,
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       children: [
  //         // Test Header
  //         Container(
  //           padding: EdgeInsets.all(20.w),
  //           decoration: BoxDecoration(
  //             color: _getScoreColor(percentage).withOpacity(0.05),
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(20.r),
  //               topRight: Radius.circular(20.r),
  //             ),
  //           ),
  //           child: Row(
  //             children: [
  //               Container(
  //                 padding: EdgeInsets.all(12.w),
  //                 decoration: BoxDecoration(
  //                   color: _getScoreColor(percentage).withOpacity(0.1),
  //                   shape: BoxShape.circle,
  //                 ),
  //                 child: Icon(
  //                   LucideIcons.clipboardCheck,
  //                   color: _getScoreColor(percentage),
  //                   size: 24.sp,
  //                 ),
  //               ),
  //               SizedBox(width: 16.w),
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       test['name']! as String,
  //                       style: GoogleFonts.poppins(
  //                         fontSize: 18.sp,
  //                         fontWeight: FontWeight.w700,
  //                         color: AttendanceColors.darkText,
  //                       ),
  //                     ),
  //                     Text(
  //                       '${test['subject']! as String} • ${test['date']! as String}',
  //                       style: GoogleFonts.inter(
  //                         fontSize: 13.sp,
  //                         color: AttendanceColors.lightText,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   Container(
  //                     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
  //                     decoration: BoxDecoration(
  //                       gradient: LinearGradient(
  //                         colors: [
  //                           _getScoreColor(percentage),
  //                           _getScoreColor(percentage).withOpacity(0.8),
  //                         ],
  //                       ),
  //                       borderRadius: BorderRadius.circular(16.r),
  //                     ),
  //                     child: Text(
  //                       '$percentage%',
  //                       style: GoogleFonts.poppins(
  //                         fontSize: 24.sp,
  //                         fontWeight: FontWeight.w800,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(height: 4.h),
  //                   Text(
  //                     'Rank: #${test['rank']!}',
  //                     style: GoogleFonts.inter(
  //                       fontSize: 12.sp,
  //                       fontWeight: FontWeight.w500,
  //                       color: AttendanceColors.lightText,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
          
  //         // Test Details
  //         Container(
  //           padding: EdgeInsets.all(20.w),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 'Chapter: ${test['chapter']! as String}',
  //                 style: GoogleFonts.inter(
  //                   fontSize: 14.sp,
  //                   fontWeight: FontWeight.w500,
  //                   color: AttendanceColors.darkText,
  //                 ),
  //               ),
  //               SizedBox(height: 16.h),
                
  //               // Score Breakdown
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   _buildScoreDetail(
  //                     label: 'Your Score',
  //                     value: '${test['score']!}/${test['total']!}',
  //                     color: _getScoreColor(percentage),
  //                   ),
  //                   _buildScoreDetail(
  //                     label: 'Class Average',
  //                     value: '${test['classAvg']!}%',
  //                     color: AttendanceColors.pendingColor,
  //                   ),
  //                   _buildScoreDetail(
  //                     label: 'Top Score',
  //                     value: '${test['topScore']!}%',
  //                     color: AttendanceColors.presentColor,
  //                   ),
  //                 ],
  //               ),
                
  //               SizedBox(height: 20.h),
                
  //               // Performance Indicator
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     'Performance',
  //                     style: GoogleFonts.inter(
  //                       fontSize: 14.sp,
  //                       fontWeight: FontWeight.w500,
  //                       color: AttendanceColors.darkText,
  //                     ),
  //                   ),
  //                   SizedBox(height: 8.h),
  //                   Container(
  //                     height: 8.h,
  //                     decoration: BoxDecoration(
  //                       color: Colors.grey.shade200,
  //                       borderRadius: BorderRadius.circular(4.r),
  //                     ),
  //                     child: Row(
  //                       children: [
  //                         Expanded(
  //                           flex: test['classAvg']! as int,
  //                           child: Container(
  //                             decoration: BoxDecoration(
  //                               color: AttendanceColors.pendingColor,
  //                               borderRadius: BorderRadius.horizontal(
  //                                 left: Radius.circular(4.r),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Expanded(
  //                           flex: percentage - (test['classAvg']! as int),
  //                           child: Container(
  //                             decoration: BoxDecoration(
  //                               color: _getScoreColor(percentage),
  //                             ),
  //                           ),
  //                         ),
  //                         Expanded(
  //                           flex: (test['topScore']! as int) - percentage,
  //                           child: Container(
  //                             decoration: BoxDecoration(
  //                               color: Colors.grey.shade300,
  //                               borderRadius: BorderRadius.horizontal(
  //                                 right: Radius.circular(4.r),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(height: 8.h),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(
  //                         'Class Avg',
  //                         style: GoogleFonts.inter(
  //                           fontSize: 10.sp,
  //                           color: AttendanceColors.lightText,
  //                         ),
  //                       ),
  //                       Text(
  //                         'Your Score',
  //                         style: GoogleFonts.inter(
  //                           fontSize: 10.sp,
  //                           color: _getScoreColor(percentage),
  //                           fontWeight: FontWeight.w600,
  //                         ),
  //                       ),
  //                       Text(
  //                         'Top Score',
  //                         style: GoogleFonts.inter(
  //                           fontSize: 10.sp,
  //                           color: AttendanceColors.lightText,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }


 Widget _buildTestDetailCard(TestResultModel item) {

  final percentage = item.percentage.round();

  return Container(
    margin: EdgeInsets.only(bottom: 16.h),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          spreadRadius: 2,
        ),
      ],
    ),
    child: Column(
      children: [

        /// HEADER
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: _getScoreColor(percentage).withOpacity(0.05),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Row(
            children: [

              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: _getScoreColor(percentage).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  LucideIcons.clipboardCheck,
                  color: _getScoreColor(percentage),
                  size: 24.sp,
                ),
              ),

              SizedBox(width: 16.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      item.title,
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: AttendanceColors.darkText,
                      ),
                    ),

Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Flexible(
      child: Text(
        '${item.chapterName} • ${AppDateUtils.formatDate(item.testDate)}',
        style: GoogleFonts.inter(
          fontSize: 10.sp,
          color: AttendanceColors.lightText,
        ),
        // overflow: TextOverflow.ellipsis,
      ),
    ),
     
  ],
),

                
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _getScoreColor(percentage),
                          _getScoreColor(percentage).withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      '$percentage%',
                      style: GoogleFonts.poppins(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: 4.h),

                  Text(
                   'Rank #${item.rank}',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AttendanceColors.lightText,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        /// DETAILS
        Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                'Performance Overview',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AttendanceColors.darkText,
                ),
              ),

              SizedBox(height: 16.h),

              /// SCORE DETAILS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  _buildScoreDetail(
                    label: 'Your Score',
                    value:
                        '${item.obtainedMarks}/${item.totalMarks}',
                    color: _getScoreColor(percentage),
                  ),

                  _buildScoreDetail(
                    label: 'Percentage',
                    value: '$percentage%',
                    color: AttendanceColors.pendingColor,
                  ),

                  _buildScoreDetail(
                    label: 'Result',
                    value: percentage >= 40
                        ? 'Pass'
                        : 'Fail',
                    color: percentage >= 40
                        ? AttendanceColors.presentColor
                        : AttendanceColors.absentColor,
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              /// PROGRESS BAR
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    'Performance',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AttendanceColors.darkText,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: LinearProgressIndicator(
                      value: percentage / 100,
                      minHeight: 8.h,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation(
                        _getScoreColor(percentage),
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        '0%',
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          color: AttendanceColors.lightText,
                        ),
                      ),

                      Text(
                        '$percentage%',
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          color: _getScoreColor(percentage),
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Text(
                        '100%',
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          color: AttendanceColors.lightText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  Widget _buildScoreDetail({required String label, required String value, required Color color}) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AttendanceColors.lightText,
          ),
        ),
      ],
    );
  }
  
  Color _getScoreColor(int score) {
    // Use AttendanceColors for performance grading
    if (score >= 90) return AttendanceColors.presentColor; // Green for excellent
    if (score >= 80) return AttendanceColors.primaryOrange; // Orange for good
    if (score >= 70) return AttendanceColors.pendingColor; // Yellow for average
    return AttendanceColors.absentColor; // Red for needs improvement
  }
}