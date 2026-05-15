import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:qr_code_scanner/components/login_background_elements.dart';
import 'package:qr_code_scanner/core/constants/attendance_Colors.dart';
import 'package:qr_code_scanner/data/models/quick_action_item.dart';
import 'package:qr_code_scanner/data/models/stat_item.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/dashboard_stats_controller.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/student_controller.dart';
import 'package:qr_code_scanner/presentation/views/attendance/monthly_attendance_screen.dart';
import 'package:qr_code_scanner/presentation/views/fee/fee_home_screen.dart';
import 'package:qr_code_scanner/presentation/views/fee/monthly_fee_screen.dart';
import 'package:qr_code_scanner/presentation/views/home/widget/animated_header_section.dart';
import 'package:qr_code_scanner/presentation/views/home/widget/animated_stats_section.dart';
import 'package:qr_code_scanner/presentation/views/home/widget/quick_access_grid.dart';
import 'package:qr_code_scanner/presentation/views/notifications/notifications_screen.dart';
import 'package:qr_code_scanner/presentation/views/test_resutls/test_results_screen.dart';

// Enhanced Student Dashboard
class StudentDashboard extends StatelessWidget {
  final RxString greeting = RxString('');
  final StudentController studentController = Get.put(StudentController());
  final DashboardStatsController dashboardStatsController =
    Get.put(DashboardStatsController());

  @override
  Widget build(BuildContext context) {
    // Set greeting based on time of day
    final hour = DateTime.now().hour;
    if (hour < 12) {
      greeting.value = 'Good Morning';
      // greeting.value = '  Good Evening';
    } else if (hour < 17) {
      greeting.value = 'Good Afternoon';
    } else {
      greeting.value = 'Good Evening';
    }

    return Scaffold(
      backgroundColor: AttendanceColors.warmWhite,
      body: Stack(
        children: [
          const BackgroundElements(),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section with Animation
                  Obx(() {
                    final student = studentController.student.value;

                    if (studentController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (student == null) {
                      return AnimatedHeaderSection(
                        greeting: greeting,
                        userName: 'Student',
                        classInfo: 'Al-Qasim Academy',
                        getGreetingIcon: _getGreetingIcon,
                      );
                    }

                    return AnimatedHeaderSection(
                      greeting: greeting,
                      userName: student.name,
                      classInfo: 'Class ${student.grade}, Al-Qasim Academy',
                      getGreetingIcon: _getGreetingIcon,
                    );
                  }),

                  // AnimatedHeaderSection(
                  //   greeting: greeting,
                  //   userName: 'Naveed kk',
                  //   classInfo: 'Class 10, Al-Qasim Academy',
                  //   getGreetingIcon: _getGreetingIcon,
                  // ),
                  SizedBox(height: 32.h),
                  // AnimatedStatsSection(
                  //   title: 'Your Performance',
                  //   filterLabel: 'This Week',
                  //   stats: [
                  //     StatItem(
                  //       title: 'Attendance',
                  //       value: '94%',
                  //       change: '+2%',
                  //       icon: LucideIcons.calendarCheck,
                  //       color: AttendanceColors.presentColor,
                  //       delay: 600.ms,
                  //     ),
                  //     StatItem(
                  //       title: 'Avg Test Score',
                  //       value: '87%',
                  //       change: '+5%',
                  //       icon: LucideIcons.clipboardCheck,
                  //       color: AttendanceColors.primaryOrange,
                  //       delay: 700.ms,
                  //     ),
                  //     StatItem(
                  //       title: 'Fee Status',
                  //       value: 'Paid',
                  //       change: 'On Time',
                  //       icon: LucideIcons.wallet,
                  //       color: AttendanceColors.holidayColor,
                  //       delay: 800.ms,
                  //     ),
                  //     StatItem(
                  //       title: 'Rank',
                  //       value: '#12',
                  //       change: '↑ 3',
                  //       icon: LucideIcons.award,
                  //       color: AttendanceColors.darkOrange,
                  //       delay: 900.ms,
                  //     ),
                  //   ],
                  // ),


                  Obx(() => AnimatedStatsSection(
  title: 'Your Performance',
  filterLabel: 'This Week',
  stats: [
    StatItem(
      title: 'Attendance',
      value: '${dashboardStatsController.thisWeekAttendance.toStringAsFixed(0)}%',
      change: dashboardStatsController.attendanceChange,
      icon: LucideIcons.calendarCheck,
      color: AttendanceColors.presentColor,
      delay: 600.ms,
    ),
    StatItem(
      title: 'Avg Test Score',
      value: '${dashboardStatsController.thisWeekAvgScore.toStringAsFixed(0)}%',
      change: dashboardStatsController.scoreChange,
      icon: LucideIcons.clipboardCheck,
      color: AttendanceColors.primaryOrange,
      delay: 700.ms,
    ),
    StatItem(
      title: 'Fee Status',
      value: dashboardStatsController.currentFeeStatus,
      change: dashboardStatsController.feeChangeText,
      icon: LucideIcons.wallet,
      color: AttendanceColors.holidayColor,
      delay: 800.ms,
    ),
    StatItem(
      title: 'Rank',
      value: dashboardStatsController.rankChangeText,
      change: 'This Week',
      icon: LucideIcons.award,
      color: AttendanceColors.darkOrange,
      delay: 900.ms,
    ),
  ],
)),

                  SizedBox(height: 32.h),

                  // Quick Access Grid
                  QuickAccessGrid(
                    title: 'Quick Access',
                    crossAxisCount: 2,
                    actions: [
                      QuickActionItem(
                        icon: LucideIcons.calendarCheck,
                        title: 'Attendance',
                        subtitle: 'Track your presence',
                        color: AttendanceColors.presentColor,
                        onTap: () => Get.to(() => MonthlyAttendanceScreen()),
                      ),
                      QuickActionItem(
                        icon: LucideIcons.wallet,
                        title: 'Fee Status',
                        subtitle: 'Payment & dues',
                        color: AttendanceColors.holidayColor,
                        onTap: () => Get.to(() =>
                        
                        //  MonthlyFeeScreen()
                         FeeHomeScreen()
                         ),
                      ),
                      QuickActionItem(
                        icon: LucideIcons.clipboardCheck,
                        title: 'Test Results',
                        subtitle: 'Scores & rankings',
                        color: AttendanceColors.primaryOrange,
                        onTap: () => Get.to(() => TestResultsScreen()),
                      ),
                     
                      QuickActionItem(
                        icon: LucideIcons.bell,
                        title: 'Notifications',
                        subtitle: 'Updates & alerts',
                        color: AttendanceColors.pendingColor,
                                                onTap: () => Get.to(() => NotificationsScreen()),

                      ),
                    ],
                  ),

                  SizedBox(height: 32.h),

                  // Upcoming Tests
                  // _buildUpcomingTests(),

                  // SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getGreetingIcon(String greeting) {
    switch (greeting) {
      case 'Good Morning':
        return LucideIcons.sun;
      case 'Good Afternoon':
        return LucideIcons.sun;
      case 'Good Evening':
        return LucideIcons.moon;
      default:
        return LucideIcons.sun;
    }
  }

  
  Widget _buildTestCard(Map<String, dynamic> test, int index) {
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
              // Animated Countdown Circle
              Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 50.w,
                        height: 50.h,
                        child: CircularProgressIndicator(
                          value: 0.7,
                          strokeWidth: 3.w,
                          backgroundColor: (test['color'] as Color).withOpacity(
                            0.1,
                          ),
                          valueColor: AlwaysStoppedAnimation(
                            test['color'] as Color,
                          ),
                        ),
                      ),
                      Text(
                        '1d',
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: test['color'] as Color,
                        ),
                      ),
                    ],
                  )
                  .animate(delay: (1400 + index * 150).ms)
                  .scale(begin: Offset(0.5, 0.5), end: Offset(1, 1))
                  .fadeIn(duration: 600.ms),

              SizedBox(width: 16.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                          test['subject'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AttendanceColors.darkText,
                          ),
                        )
                        .animate(delay: (1450 + index * 150).ms)
                        .slideX(begin: -0.1, end: 0)
                        .fadeIn(duration: 500.ms),

                    SizedBox(height: 4.h),

                    Text(
                      test['topic'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        color: AttendanceColors.lightText,
                      ),
                    ),

                    SizedBox(height: 4.h),

                    Row(
                      children: [
                        Icon(
                          LucideIcons.clock,
                          size: 12.sp,
                          color: AttendanceColors.lightText,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          test['date'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            color: AttendanceColors.lightText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: () {},
                icon: Icon(
                  LucideIcons.chevronRight,
                  size: 20.sp,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        )
        .animate(delay: (1350 + index * 150).ms)
        .slideX(begin: 0.2, end: 0)
        .fadeIn(duration: 500.ms);
  }
}
