import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:qr_code_scanner/core/constants/attendance_Colors.dart';

class AnimatedHeaderSection extends StatelessWidget {
  final RxString greeting;
  final String userName;
  final String classInfo;
  final String rollNumber;
  final IconData Function(String) getGreetingIcon;
  VoidCallback? onLogout;

  AnimatedHeaderSection({
    
    super.key,
    this.onLogout,
    required this.greeting,
    required this.rollNumber,
    required this.userName,
    required this.classInfo,
    required this.getGreetingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Greeting row
        Obx(() =>
        
        //  Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Row(
        //           children: [
        //             Text(
        //               greeting.value,
        //               style: GoogleFonts.poppins(
        //                 fontSize: 18.sp,
        //                 fontWeight: FontWeight.w600,
        //                 color: AttendanceColors.lightText,
        //               ),
        //             )
        //                 .animate(delay: 100.ms)
        //                 .fadeIn(duration: 600.ms)
        //                 .slideX(begin: -0.2, end: 0),
        //         SizedBox(width: 8.w),

        //                    Icon(
        //           getGreetingIcon(greeting.value),
        //           size: 20.sp,
        //           color: AttendanceColors.primaryOrange,
        //         )
        //             .animate(delay: 200.ms)
        //             .scale(begin: const Offset(0, 0), end: const Offset(1, 1))
        //             .fadeIn(duration: 500.ms),

        //                 // Icon(Icons.logout)
        //           ],
        //         ),
        //                   InkWell(
        //                     onTap: onLogout,
        //                     child: Icon(
        //                       Icons.logout_rounded,
        //                       size: 23.sp,
        //                       color: AttendanceColors.absentColor,
        //                     ),
        //                   ),
             
        //       ],
  
            // )
            Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Expanded(
      child: Row(
        children: [
          Text(
            greeting.value,
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AttendanceColors.lightText,
            ),
          ),

          SizedBox(width: 8.w),

          Icon(
            getGreetingIcon(greeting.value),
            size: 20.sp,
            color: AttendanceColors.primaryOrange,
          ),
        ],
      ),
    ),

     InkWell(
                            onTap: onLogout,
                            child: Icon(
                              Icons.logout_rounded,
                              size: 23.sp,
                              color: AttendanceColors.absentColor,
                            ),
                          ),

  ],
),
            
            ),

        SizedBox(height: 4.h),

        /// Username row
        Row(
          children: [
            Text(
              '$userName,',
              style: GoogleFonts.poppins(
                fontSize: 32.sp,
                fontWeight: FontWeight.w800,
                color: AttendanceColors.darkText,
                letterSpacing: -0.5,
              ),
            )
                .animate(delay: 300.ms)
                .fadeIn(duration: 800.ms)
                .slideX(begin: -0.3, end: 0),
            SizedBox(width: 8.w),
            Text(
              '👋',
              style: TextStyle(fontSize: 24.sp),
            )
                .animate(delay: 400.ms)
                .shake(hz: 3, duration: NumDurationExtensions(1).seconds)
                .scale(begin: const Offset(0, 0), end: const Offset(1, 1)),
          ],
        ),

        SizedBox(height: 8.h),

        /// Class info
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            Row(
              children: [
                Icon(
                  LucideIcons.graduationCap,
                  size: 16.sp,
                  color: AttendanceColors.primaryOrange.withOpacity(0.8),
                ),
                SizedBox(width: 8.w),
                Text(
                  classInfo ,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AttendanceColors.lightText,
                  ),
                ),
            
               
              ],
            )
                .animate(delay: 500.ms)
                .fadeIn(duration: 600.ms)
                .slideY(begin: 0.2, end: 0),
                
          ],
        ),

            
      ],
    );
  }
}
