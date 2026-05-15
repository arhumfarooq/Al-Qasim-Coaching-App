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
import 'package:qr_code_scanner/presentation/views/splash_screen.dart';
import 'package:qr_code_scanner/presentation/views/test_resutls/monthly_test_results_screen.dart';

class TestResultsScreen extends StatelessWidget {
  final TestResultController testResultController = Get.put(TestResultController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AttendanceColors.warmWhite,
      body: Stack(
        children: [
          // Background elements
          _buildBackgroundElements(),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  _buildHeaderSection(context),
                  SizedBox(height: 32.h),
                  
                  // Overall Performance Card
                  _buildOverallPerformanceCard(),
                  SizedBox(height: 24.h),
                  
                  // Latest Test Result
                  _buildLatestTestCard(context),
                  SizedBox(height: 24.h),
                  
                  // Performance Trend
                  _buildPerformanceTrend(context),
                  SizedBox(height: 32.h),
                  
                  // Recent Tests
                  _buildRecentTests(context),
                  
                  SizedBox(height: 80.h),
                ],
              ),
            ),
          ),
          
          // Floating Action Button
          Positioned(
            bottom: 24.h,
            right: 24.w,
            child: FloatingActionButton(
              onPressed:(){},
              backgroundColor: AttendanceColors.primaryOrange,
              child: Icon(LucideIcons.barChart3, color: Colors.white, size: 24.sp),
            ).animate().scale(delay: 300.ms).fadeIn(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBackgroundElements() {
    return Stack(
      children: [
        Positioned(
          top: -80,
          right: -60,
          child: Container(
            width: 200.w,
            height: 200.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AttendanceColors.primaryOrange.withOpacity(0.05),
                  AttendanceColors.primaryOrange.withOpacity(0.02),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  // Widget _buildHeaderSection(context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 'Test Results',
  //                 style: AttendanceTypography.headlineLarge(context),
  //               ).animate().fadeIn(delay: 100.ms),
  //               SizedBox(height: 4.h),
  //               Text(
  //                 'December 2024',
  //                 style: AttendanceTypography.bodyMedium(context),
  //               ).animate().fadeIn(delay: 200.ms),
  //             ],
  //           ),
  //           Container(
  //             width: 50.w,
  //             height: 50.h,
  //             decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               color: Colors.white,
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.black.withOpacity(0.05),
  //                   blurRadius: 10,
  //                   spreadRadius: 1,
  //                 ),
  //               ],
  //             ),
  //             child: Icon(LucideIcons.clipboardCheck, 
  //               color: AttendanceColors.primaryOrange, 
  //               size: 24.sp
  //             ),
  //           ).animate().scale(delay: 300.ms),
  //         ],
  //       ),
  //       SizedBox(height: 8.h),
  //       Text(
  //         'Al-Qasim Academy • Class 10th • Mathematics',
  //         style: GoogleFonts.inter(
  //           fontSize: 12.sp,
  //           fontWeight: FontWeight.w400,
  //           color: AttendanceColors.lightText,
  //         ),
  //       ).animate().fadeIn(delay: 400.ms),
  //     ],
  //   );
  // }

 Widget _buildHeaderSection(BuildContext context) {
  return Obx(() {

    final now = DateTime.now();

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

final student =
    testResultController.currentStudent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  'Test Results',
                  style: AttendanceTypography
                      .headlineLarge(context),
                ).animate().fadeIn(delay: 100.ms),

                SizedBox(height: 4.h),

                Text(
                  '${months[now.month - 1]} ${now.year}',
                  style: AttendanceTypography
                      .bodyMedium(context),
                ).animate().fadeIn(delay: 200.ms),
              ],
            ),

            Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Icon(
                LucideIcons.clipboardCheck,
                color: AttendanceColors.primaryOrange,
                size: 24.sp,
              ),
            ).animate().scale(delay: 300.ms),
          ],
        ),

        SizedBox(height: 8.h),

        Text(
          'Al-Qasim Academy • Class ${student?.grade ?? '--'}',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AttendanceColors.lightText,
          ),
        ).animate().fadeIn(delay: 400.ms),
      ],
    );
  });
}

  Widget _buildOverallPerformanceCard() {
    return Obx(() => Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: AttendanceColors.primaryGradient,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AttendanceColors.primaryOrange.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overall Performance',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'This Semester',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              Icon(LucideIcons.trendingUp, color: Colors.white, size: 24.sp),
            ],
          ),
          SizedBox(height: 20.h),
          
          // Score Circle
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 140.w,
                height: 140.h,
                child: CircularProgressIndicator(
                  value: testResultController.averageScore / 100,
                  strokeWidth: 12.w,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ).animate(delay: 500.ms).fadeIn(),
              ),
              Column(
                children: [
                  Text(
                    '${testResultController.averageScore.toStringAsFixed(1)}%',
                    style: GoogleFonts.poppins(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ).animate(delay: 700.ms).scale(),
                  Text(
                    _getPerformanceLabel(testResultController.averageScore),
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          
          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem(
                title: 'Tests Taken',
                value: '${testResultController.testsTaken}',
                icon: LucideIcons.clipboardList,
                delay: 800.ms,
              ),
              _buildStatItem(
                title: 'Average Rank',
                value: '#${testResultController.averageRank}',
                icon: LucideIcons.award,
                delay: 900.ms,
              ),
              _buildStatItem(
                title: 'Best Score',
                value: '${testResultController.bestScore}%',
                icon: LucideIcons.star,
                delay: 1000.ms,
              ),
            ],
          ),
        ],
      ),
    ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.2, end: 0));
  }
  
  String _getPerformanceLabel(double score) {
    if (score >= 90) return 'Excellent';
    if (score >= 80) return 'Very Good';
    if (score >= 70) return 'Good';
    if (score >= 60) return 'Average';
    return 'Needs Improvement';
  }
  
  Widget _buildStatItem({
    required String title,
    required String value,
    required IconData icon,
    required Duration delay,
  }) {
    return Column(
      children: [
        Icon(icon, size: 20.sp, color: Colors.white),
        SizedBox(height: 8.h),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    ).animate(delay: delay).fadeIn().scale(begin: Offset(0.9, 0.9));
  }
  
  // Widget _buildLatestTestCard(context) {
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
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               'Latest Test',
  //               style: AttendanceTypography.headlineMedium(context),
  //             ),
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
  //               decoration: BoxDecoration(
  //                 color: AttendanceColors.primaryOrange.withOpacity(0.1),
  //                 borderRadius: BorderRadius.circular(20.r),
  //               ),
  //               child: Row(
  //                 children: [
  //                   Icon(LucideIcons.clock, size: 14.sp, color: AttendanceColors.primaryOrange),
  //                   SizedBox(width: 4.w),
  //                   Text(
  //                     'Dec 15, 2024',
  //                     style: GoogleFonts.inter(
  //                       fontSize: 12.sp,
  //                       fontWeight: FontWeight.w600,
  //                       color: AttendanceColors.primaryOrange,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 16.h),
          
  //         Row(
  //           children: [
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     'Unit Test 3',
  //                     style: GoogleFonts.poppins(
  //                       fontSize: 18.sp,
  //                       fontWeight: FontWeight.w700,
  //                       color: AttendanceColors.darkText,
  //                     ),
  //                   ),
  //                   SizedBox(height: 4.h),
  //                   Text(
  //                     'Algebra - Chapter 4',
  //                     style: GoogleFonts.inter(
  //                       fontSize: 14.sp,
  //                       color: AttendanceColors.lightText,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               children: [
  //                 Container(
  //                   padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
  //                   decoration: BoxDecoration(
  //                     gradient: LinearGradient(
  //                       colors: [
  //                         AttendanceColors.presentColor, // Green for excellent
  //                         AttendanceColors.presentColor.withOpacity(0.8),
  //                       ],
  //                     ),
  //                     borderRadius: BorderRadius.circular(16.r),
  //                   ),
  //                   child: Text(
  //                     '85%',
  //                     style: GoogleFonts.poppins(
  //                       fontSize: 24.sp,
  //                       fontWeight: FontWeight.w800,
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(height: 4.h),
  //                 Text(
  //                   'Rank: #7',
  //                   style: GoogleFonts.inter(
  //                     fontSize: 12.sp,
  //                     fontWeight: FontWeight.w500,
  //                     color: AttendanceColors.lightText,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 20.h),
          
  //         InkWell(
  //           // onTap: () => Get.to(() => MonthlyTestResultsScreen()),

  //           borderRadius: BorderRadius.circular(16.r),
  //           child: Container(
  //             padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
  //             decoration: BoxDecoration(
  //               color: AttendanceColors.primaryOrange.withOpacity(0.1),
  //               borderRadius: BorderRadius.circular(16.r),
  //             ),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text(
  //                   'View All Test Results',
  //                   style: GoogleFonts.poppins(
  //                     fontSize: 14.sp,
  //                     fontWeight: FontWeight.w600,
  //                     color: AttendanceColors.primaryOrange,
  //                   ),
  //                 ),
  //                 SizedBox(width: 8.w),
  //                 Icon(LucideIcons.chevronRight, 
  //                   color: AttendanceColors.primaryOrange, 
  //                   size: 16.sp
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   ).animate(delay: 1100.ms).fadeIn().slideY(begin: 0.2, end: 0);
  // }


 Widget _buildLatestTestCard(context) {
  return Obx(() {

    if (testResultController.isLoading.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final item = testResultController.latestResult;

    if (item == null) {
      return const Center(
        child: Text('No test results found'),
      );
    }

    final score = item.percentage.round();

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                'Latest Test',
                style: AttendanceTypography.headlineMedium(context),
              ),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: AttendanceColors.primaryOrange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [

                    Icon(
                      LucideIcons.clock,
                      size: 14.sp,
                      color: AttendanceColors.primaryOrange,
                    ),

                    SizedBox(width: 4.w),

                    Text(
                      _formatDate(item.testDate),
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AttendanceColors.primaryOrange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          Row(
            children: [

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

                    SizedBox(height: 4.h),

                    Text(
                      '${item.obtainedMarks}/${item.totalMarks} Marks',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: AttendanceColors.lightText,
                      ),
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
                          _getScoreColor(score),
                          _getScoreColor(score).withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      '$score%',
                      style: GoogleFonts.poppins(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: 4.h),

                  Text(
                    'Latest Result',
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

          SizedBox(height: 20.h),

          InkWell(
            onTap: () => Get.to(() => MonthlyTestResultsScreen()),
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 24.w,
              ),
              decoration: BoxDecoration(
                color: AttendanceColors.primaryOrange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    'View All Test Results',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AttendanceColors.primaryOrange,
                    ),
                  ),

                  SizedBox(width: 8.w),

                  Icon(
                    LucideIcons.chevronRight,
                    color: AttendanceColors.primaryOrange,
                    size: 16.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate(delay: 1100.ms)
        .fadeIn()
        .slideY(begin: 0.2, end: 0);
  });
}

  // // Widget _buildPerformanceTrend(context) {
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
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               'Performance Trend',
  //               style: AttendanceTypography.headlineMedium(context),
  //             ),
  //             Icon(LucideIcons.trendingUp, color: AttendanceColors.primaryOrange),
  //           ],
  //         ),
  //         SizedBox(height: 16.h),
          
  //         SizedBox(
  //           height: 140.h,
  //           child: ListView.builder(
  //             scrollDirection: Axis.horizontal,
  //             itemCount: 6,
  //             itemBuilder: (context, index) {
  //               final tests = ['UT1', 'UT2', 'UT3', 'MT1', 'UT4', 'UT5'];
  //               final scores = [78, 82, 85, 88, 83, 87];
  //               final dates = ['Sep', 'Oct', 'Nov', 'Dec', 'Jan', 'Feb'];
                
  //               return Container(
  //                 width: 60.w,
  //                 margin: EdgeInsets.only(right: 16.w),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     Text(
  //                       '${scores[index]}%',
  //                       style: GoogleFonts.inter(
  //                         fontSize: 10.sp,
  //                         fontWeight: FontWeight.w500,
  //                         color: AttendanceColors.lightText,
  //                       ),
  //                     ),
  //                     SizedBox(height: 8.h),
  //                     Container(
  //                       height: (scores[index] / 100 * 80).h,
  //                       width: 30.w,
  //                       decoration: BoxDecoration(
  //                         gradient: LinearGradient(
  //                           colors: [
  //                             AttendanceColors.primaryOrange,
  //                             AttendanceColors.secondaryOrange,
  //                           ],
  //                           begin: Alignment.topCenter,
  //                           end: Alignment.bottomCenter,
  //                         ),
  //                         borderRadius: BorderRadius.vertical(
  //                           top: Radius.circular(8.r),
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(height: 8.h),
  //                     Column(
  //                       children: [
  //                         Text(
  //                           tests[index],
  //                           style: GoogleFonts.inter(
  //                             fontSize: 12.sp,
  //                             fontWeight: FontWeight.w600,
  //                             color: AttendanceColors.darkText,
  //                           ),
  //                         ),
  //                         Text(
  //                           dates[index],
  //                           style: GoogleFonts.inter(
  //                             fontSize: 10.sp,
  //                             color: AttendanceColors.lightText,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ).animate(delay: (index * 100 + 1200).ms)
  //                 .fadeIn()
  //                 .scale(begin: Offset(0.9, 0.9));
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  

Widget _buildPerformanceTrend(context) {
  return Obx(() {
    final monthlyScores = testResultController.monthlyAverageScores;

    final now = DateTime.now();

    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Performance Trend',
                style: AttendanceTypography.headlineMedium(context),
              ),
              Icon(
                LucideIcons.trendingUp,
                color: AttendanceColors.primaryOrange,
              ),
            ],
          ),

          SizedBox(height: 16.h),

          if (testResultController.isLoading.value)
            SizedBox(
              height: 140.h,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          else
            SizedBox(
              height: 140.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 12,
                itemBuilder: (context, index) {
                  final month = index + 1;

                  final isFutureMonth =
                      DateTime(DateTime.now().year, month, 1).isAfter(
                    DateTime(now.year, now.month, 1),
                  );

                  final score = monthlyScores[month] ?? 0;

                  final hasData = monthlyScores.containsKey(month);

                  final isDisabled = isFutureMonth || !hasData;

                  return Container(
                    width: 60.w,
                    margin: EdgeInsets.only(right: 16.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          isDisabled ? '0%' : '${score.toStringAsFixed(0)}%',
                          style: GoogleFonts.inter(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: isDisabled
                                ? Colors.grey
                                : AttendanceColors.lightText,
                          ),
                        ),

                        SizedBox(height: 8.h),

                        Container(
                          height: isDisabled
                              ? 12.h
                              : (score / 100 * 80).h,
                          width: 30.w,
                          decoration: BoxDecoration(
                            color: isDisabled
                                ? Colors.grey.shade300
                                : null,
                            gradient: isDisabled
                                ? null
                                : const LinearGradient(
                                    colors: [
                                      AttendanceColors.primaryOrange,
                                      AttendanceColors.secondaryOrange,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(8.r),
                            ),
                          ),
                        ),

                        SizedBox(height: 8.h),

                        Column(
                          children: [
                            Text(
                              months[index],
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: isDisabled
                                    ? Colors.grey
                                    : AttendanceColors.darkText,
                              ),
                            ),
                            Text(
                              hasData ? 'Avg' : 'No Data',
                              style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                color: isDisabled
                                    ? Colors.grey
                                    : AttendanceColors.lightText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).animate(delay: (index * 40).ms)
                      .fadeIn(duration: 250.ms)
                      .scale(
                        begin: const Offset(0.96, 0.96),
                        duration: 250.ms,
                      );
                },
              ),
            ),
        ],
      ),
    );
  });
}


Widget _buildRecentTests(context) {
  return Obx(() {
   final recentResults =
    testResultController.recentMonthResults;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Tests',
              style: AttendanceTypography.headlineMedium(context),
            ).animate(delay: 1300.ms).fadeIn(),

            TextButton(
              onPressed: ()
              
              
               => Get.to(() => 
               
               MonthlyTestResultsScreen()
               
               
               ),
              child: Text(
                'View All',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AttendanceColors.primaryOrange,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        if (testResultController.isLoading.value)
          const Center(child: CircularProgressIndicator()),

        if (!testResultController.isLoading.value &&
            recentResults.isEmpty)
          const Text('No test results found'),

        if (!testResultController.isLoading.value)
          ...recentResults.map((item) {
            return _buildTestItem(item );
          }).toList()
              .animate(interval: 100.ms)
              .fadeIn()
              .slideX(begin: 0.1),
      ],
    );
  });
}

  // Widget _buildRecentTests(context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             'Recent Tests',
  //             style: AttendanceTypography.headlineMedium(context),
  //           ).animate(delay: 1300.ms).fadeIn(),
  //           TextButton(
  //             onPressed: () => Get.to(() => MonthlyTestResultsScreen()),
  //             child: Text(
  //               'View All',
  //               style: GoogleFonts.poppins(
  //                 fontSize: 14.sp,
  //                 fontWeight: FontWeight.w600,
  //                 color: AttendanceColors.primaryOrange,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       SizedBox(height: 16.h),
        
  //       ...List.generate(3, (index) => _buildTestItem(index))
  //           .animate(interval: 100.ms)
  //           .fadeIn()
  //           .slideX(begin: 0.1),
  //     ],
  //   );
  // }
  
//   Widget _buildTestItem(TestResultModel item) {
//   final score = item.percentage.round();

//   return Container(
//     margin: EdgeInsets.only(bottom: 12.h),
//     padding: EdgeInsets.all(16.w),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(16.r),
//     ),
//     child: Row(
//       children: [
//         Icon(
//           LucideIcons.clipboardCheck,
//           color: _getScoreColor(score),
//           size: 24.sp,
//         ),
//         SizedBox(width: 16.w),
//         Expanded(
//           child: Text(item.title),
//         ),
//         Text('$score%'),
//       ],
//     ),
//   );
// }
  
Widget _buildTestItem(TestResultModel item) {
  final score = item.percentage.round();

  return Container(
    margin: EdgeInsets.only(bottom: 12.h),
    padding: EdgeInsets.all(16.w),
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
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: _getScoreColor(score).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            LucideIcons.clipboardCheck,
            color: _getScoreColor(score),
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
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AttendanceColors.darkText,
                ),
              ),
              SizedBox(height: 4.h),
              // Text(
              //   '${item.obtainedMarks}/${item.totalMarks} Marks • ${_formatDate(item.testDate)}',
              //   style: GoogleFonts.inter(
              //     fontSize: 12.sp,
              //     fontWeight: FontWeight.w400,
              //     color: AttendanceColors.lightText,
              //   ),
              
              // ),

              Text(
        '${item.chapterName} • ${AppDateUtils.formatDate(item.testDate)}',
        style: GoogleFonts.inter(
          fontSize: 12.sp,
          color: AttendanceColors.lightText,
        ),
        // overflow: TextOverflow.ellipsis,
      ),
            ],
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$score%',
              style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: _getScoreColor(score),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}




String _formatDate(DateTime date) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  return '${months[date.month - 1]} ${date.day}, ${date.year}';
}
  
  Color _getScoreColor(int score) {
    // Use AttendanceColors for performance grading
    if (score >= 90) return AttendanceColors.presentColor; // Green for excellent
    if (score >= 80) return AttendanceColors.primaryOrange; // Orange for good
    if (score >= 70) return AttendanceColors.pendingColor; // Yellow for average
    return AttendanceColors.absentColor; // Red for needs improvement
  }
}

// class TestResultsController extends GetxController {
//   var averageScore = 85.0.obs;
//   var testsTaken = 12.obs;
//   var averageRank = 10.obs;
//   var bestScore = 94.obs;
// }