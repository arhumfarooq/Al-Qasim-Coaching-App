

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:qr_code_scanner/components/background_gradient_circle.dart';
import 'package:qr_code_scanner/core/constants/attendance_Colors.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/attendance_controller.dart';
import 'package:qr_code_scanner/presentation/views/attendance/monthly_attendance_screen.dart';

class HomeScreen extends StatelessWidget {
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
            // Background elements similar to login
            // _buildBackgroundElements(),
            BackgroundGradientCircle(),
            
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with greeting
                    _buildHeaderSection(),
                    SizedBox(height: 32.h),
                    
                    // Attendance Summary Card
                    _buildAttendanceSummaryCard(),
                    SizedBox(height: 24.h),
                    
                    // Quick Stats
                    _buildQuickStats(),
                    SizedBox(height: 32.h),
                    
                    // Recent Attendance
                    _buildRecentAttendance(),
                    SizedBox(height: 32.h),
                    
                    // Monthly Attendance Card
                    _buildMonthlyAttendanceCard(),
                    
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
                onPressed: ()=> Get.to(() => MonthlyAttendanceScreen()),
                backgroundColor: AttendanceColors.primaryOrange,
                child: Icon(LucideIcons.calendar, color: Colors.white, size: 24.sp),
              ).animate().scale(delay: 300.ms).fadeIn(),
            ),
          ],
        ),
      ),
    );
  }
 
  
  Widget _buildHeaderSection() {
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
                  'Good Morning,',
                  style: AttendanceTypography.bodyMedium(Get.context!),
                ).animate().fadeIn(delay: 100.ms),
                SizedBox(height: 4.h),
                Text(
                  'Ali Raza',
                  style: GoogleFonts.poppins(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: AttendanceColors.darkText,
                  ),
                ).animate().fadeIn(delay: 200.ms),
              ],
            ),
           
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          'Al-Qasim Academy - Class 10th',
          style: AttendanceTypography.caption(Get.context!),
        ).animate().fadeIn(delay: 400.ms),
      ],
    );
  }
  
  Widget _buildAttendanceSummaryCard() {
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
                    'Current Attendance',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'December 2024',
                    style: GoogleFonts.poppins(
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
          
          // Circular Progress Indicator
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120.w,
                height: 120.h,
                child: CircularProgressIndicator(
                  // value: controller.attendancePercentage.value / 100,
                  value: controller.workingDays == 0
    ? 0
    : controller.presentCount / controller.workingDays,
                  strokeWidth: 10.w,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
              Column(
                children: [
                  Text(
                    // '${controller.attendancePercentage.value.toStringAsFixed(1)}%',
                    controller.percentage,
                    style: GoogleFonts.poppins(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    // '${controller.presentDays.value} of ${controller.totalDays.value} days',
'${controller.presentCount} of ${controller.workingDays} days',
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          
          // Action Button
          InkWell(
            onTap: () => Get.to(() => MonthlyAttendanceScreen()),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'View Monthly Details',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(LucideIcons.chevronRight, color: Colors.white, size: 16.sp),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate(delay: 500.ms).fadeIn().slideY(begin: 0.2, end: 0));
  }
  
  Widget _buildQuickStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Stats',
          style: AttendanceTypography.headlineMedium(Get.context!),
        ).animate(delay: 600.ms).fadeIn(),
        SizedBox(height: 16.h),
        
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: LucideIcons.checkCircle,
                title: 'Present',
                value: '18',
                color: AttendanceColors.presentColor,
                delay: 700.ms,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildStatCard(
                icon: LucideIcons.xCircle,
                title: 'Absent',
                value: '2',
                color: AttendanceColors.absentColor,
                delay: 800.ms,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildStatCard(
                icon: LucideIcons.calendar,
                title: 'Holidays',
                value: '4',
                color: AttendanceColors.holidayColor,
                delay: 900.ms,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required Duration delay,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
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
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20.sp, color: color),
          ),
          SizedBox(height: 12.h),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AttendanceColors.darkText,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AttendanceColors.lightText,
            ),
          ),
        ],
      ),
    ).animate(delay: delay).fadeIn().scale(begin: Offset(0.9, 0.9));
  }
  
  Widget _buildRecentAttendance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Attendance',
              style: AttendanceTypography.headlineMedium(Get.context!),
            ).animate(delay: 1000.ms).fadeIn(),
            TextButton(
              onPressed: () => Get.to(() => MonthlyAttendanceScreen()),
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
        
        // Recent days list
        Column(
          children: List.generate(5, (index) => _buildRecentDayItem(index))
              .animate(interval: 100.ms)
              .fadeIn()
              .slideX(begin: 0.1),
        ),
      ],
    );
  }
  
  Widget _buildRecentDayItem(int index) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
    final dates = ['16', '17', '18', '19', '20'];
    final statuses = ['Present', 'Present', 'Absent', 'Present', 'Holiday'];
    final colors = [
      AttendanceColors.presentColor,
      AttendanceColors.presentColor,
      AttendanceColors.absentColor,
      AttendanceColors.presentColor,
      AttendanceColors.holidayColor,
    ];
    
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
              color: colors[index].withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                Text(
                  days[index],
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: colors[index],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  dates[index],
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AttendanceColors.darkText,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statuses[index],
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AttendanceColors.darkText,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Mathematics Class - 10:00 AM',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AttendanceColors.lightText,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            _getStatusIcon(statuses[index]),
            color: colors[index],
            size: 24.sp,
          ),
        ],
      ),
    );
  }
  
  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Present': return LucideIcons.checkCircle;
      case 'Absent': return LucideIcons.xCircle;
      case 'Holiday': return LucideIcons.calendar;
      default: return LucideIcons.clock;
    }
  }
  
  Widget _buildMonthlyAttendanceCard() {
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
                'Monthly Performance',
                style: AttendanceTypography.headlineMedium(Get.context!),
              ),
              Icon(LucideIcons.barChart3, color: AttendanceColors.primaryOrange),
            ],
          ),
          SizedBox(height: 16.h),
          
          // Mini bar chart for last 6 months
          SizedBox(
            height: 130.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                final months = ['Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                final percentages = [85, 88, 90, 92, 94, 96];
                
                return Container(
                  width: 50.w,
                  margin: EdgeInsets.only(right: 12.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${percentages[index]}%',
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: AttendanceColors.lightText,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        height: (percentages[index] / 100 * 80).h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
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
                      Text(
                        months[index],
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AttendanceColors.darkText,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ).animate(delay: 1200.ms).fadeIn().slideY(begin: 0.2, end: 0);
  }
}

// class AttendanceController extends GetxController {
//   var attendancePercentage = 90.0.obs;
//   var presentDays = 18.obs;
//   var absentDays = 2.obs;
//   var totalDays = 20.obs;
// }