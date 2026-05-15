// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lucide_icons/lucide_icons.dart';
// import 'package:qr_code_scanner/core/constants/fee_colors.dart';
// import 'package:qr_code_scanner/presentation/views/fee/fee_home_screen.dart';
// import 'package:qr_code_scanner/presentation/views/fee/monthly_fee_screen.dart';

// class YearlyFeeScreen extends StatelessWidget {
//   final FeeController controller = Get.find();
//   final RxInt selectedYear = 2024.obs;
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               FeeColors.backgroundWhite,
//               FeeColors.warmWhite,
//               FeeColors.lightOrangeTint,
//             ],
//           ),
//         ),
//         child: Stack(
//           children: [
//             _buildBackgroundElements(),
            
//             SafeArea(
//               child: Column(
//                 children: [
//                   // Header
//                   _buildHeader(context),
                  
//                   // Year Selector
//                   _buildYearSelector(),
                  
//                   Expanded(
//                     child: SingleChildScrollView(
//                       padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
//                       child: Column(
//                         children: [
//                           // Yearly Summary
//                           _buildYearlySummary(context),
//                           SizedBox(height: 32.h),
                          
//                           // Monthly Fee Grid
//                           _buildMonthlyGrid(context),
//                           SizedBox(height: 32.h),
                          
//                           // Year Comparison
//                           _buildYearComparison(context),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
  
//   Widget _buildBackgroundElements() {
//     return Stack(
//       children: [
//         Positioned(
//           top: -60,
//           right: -40,
//           child: Container(
//             width: 160.w,
//             height: 160.h,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: LinearGradient(
//                 colors: [
//                   FeeColors.primaryOrange.withOpacity(0.1),
//                   FeeColors.primaryOrange.withOpacity(0.05),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

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
//                   child: Text(
//                     'Yearly Fee Overview',
//                     style: FeeTypography.headlineLarge(context),
//                   ).animate().fadeIn(),
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {},
//                 icon: Icon(LucideIcons.pieChart, size: 24.sp),
//               ),
//             ],
//           ),
//           SizedBox(height: 8.h),
//           Text(
//             'Track your fee payments across academic years',
//             style: FeeTypography.bodyMedium(context),
//           ),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildYearSelector() {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 16.h),
//       color: Colors.white,
//       child: Obx(() => Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           IconButton(
//             onPressed: () => selectedYear.value--,
//             icon: Icon(LucideIcons.chevronLeft, size: 24.sp),
//           ),
//           SizedBox(width: 16.w),
//           AnimatedContainer(
//             duration: 300.ms,
//             padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
//             decoration: BoxDecoration(
//               gradient: selectedYear.value == 2024 
//                   ? FeeColors.primaryGradient
//                   : LinearGradient(colors: [Colors.grey.shade300, Colors.grey.shade300]),
//               borderRadius: BorderRadius.circular(25.r),
//             ),
//             child: Text(
//               '${selectedYear.value}-${selectedYear.value + 1}',
//               style: GoogleFonts.poppins(
//                 fontSize: 20.sp,
//                 fontWeight: FontWeight.w700,
//                 color: selectedYear.value == 2024 ? Colors.white : Colors.grey.shade700,
//               ),
//             ),
//           ).animate().scale(),
//           SizedBox(width: 16.w),
//           IconButton(
//             onPressed: () => selectedYear.value++,
//             icon: Icon(LucideIcons.chevronRight, size: 24.sp),
//           ),
//         ],
//       )),
//     );
//   }

//   Widget _buildYearlySummary(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 15,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Academic Year ${selectedYear.value}-${selectedYear.value + 1}',
//                 style: FeeTypography.headlineMedium(context),
//               ),
//               Icon(LucideIcons.trendingUp, color: FeeColors.primaryOrange),
//             ],
//           ),
//           SizedBox(height: 20.h),
          
//           // Progress Ring
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               SizedBox(
//                 width: 140.w,
//                 height: 140.h,
//                 child: CircularProgressIndicator(
//                   value: 0.75,
//                   strokeWidth: 12.w,
//                   backgroundColor: Colors.grey.shade200,
//                   valueColor: AlwaysStoppedAnimation(FeeColors.primaryOrange),
//                 ),
//               ),
//               Column(
//                 children: [
//                   Text(
//                     '₹45,000',
//                     style: GoogleFonts.poppins(
//                       fontSize: 24.sp,
//                       fontWeight: FontWeight.w800,
//                       color: FeeColors.darkText,
//                     ),
//                   ),
//                   Text(
//                     'of ₹60,000',
//                     style: GoogleFonts.poppins(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w500,
//                       color: FeeColors.lightText,
//                     ),
//                   ),
//                   SizedBox(height: 4.h),
//                   Text(
//                     '75% Paid',
//                     style: GoogleFonts.poppins(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w700,
//                       color: FeeColors.primaryOrange,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 20.h),
          
//           // Stats Row
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildYearStatItem(
//                 title: 'Paid',
//                 value: '₹45,000',
//                 color: FeeColors.paidColor,
//                 icon: LucideIcons.checkCircle,
//               ),
//               _buildYearStatItem(
//                 title: 'Due',
//                 value: '₹15,000',
//                 color: FeeColors.pendingColor,
//                 icon: LucideIcons.clock,
//               ),
//               _buildYearStatItem(
//                 title: 'Months',
//                 value: '9/12',
//                 color: FeeColors.upcomingColor,
//                 icon: LucideIcons.calendar,
//               ),
//             ],
//           ),
//         ],
//       ),
//     ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2, end: 0);
//   }
  
//   Widget _buildYearStatItem({required String title, required String value, required Color color, required IconData icon}) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(8.w),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, size: 20.sp, color: color),
//         ),
//         SizedBox(height: 8.h),
//         Text(
//           value,
//           style: GoogleFonts.poppins(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w700,
//             color: color,
//           ),
//         ),
//         SizedBox(height: 4.h),
//         Text(
//           title,
//           style: GoogleFonts.poppins(
//             fontSize: 12.sp,
//             fontWeight: FontWeight.w500,
//             color: FeeColors.lightText,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildMonthlyGrid(BuildContext context) {
//     final months = [
//       'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep',
//       'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar'
//     ];
//     final statuses = [
//       'Paid', 'Paid', 'Paid', 'Paid', 'Paid', 'Paid',
//       'Paid', 'Paid', 'Paid', 'Pending', 'Pending', 'Pending'
//     ];
//     final statusColors = [
//       FeeColors.paidColor, FeeColors.paidColor, FeeColors.paidColor,
//       FeeColors.paidColor, FeeColors.paidColor, FeeColors.paidColor,
//       FeeColors.paidColor, FeeColors.paidColor, FeeColors.paidColor,
//       FeeColors.pendingColor, FeeColors.pendingColor, FeeColors.pendingColor,
//     ];
    
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Monthly Fee Status',
//           style: FeeTypography.headlineMedium(context),
//         ).animate(delay: 400.ms).fadeIn(),
//         SizedBox(height: 16.h),
        
//         GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3,
//             mainAxisSpacing: 16.h,
//             crossAxisSpacing: 16.w,
//             childAspectRatio: 1.2,
//           ),
//           itemCount: 12,
//           itemBuilder: (context, index) {
//             return InkWell(
//               onTap: () => Get.to(() => MonthlyFeeScreen()),
//               borderRadius: BorderRadius.circular(16.r),
//               child: Container(
//                 padding: EdgeInsets.all(16.w),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16.r),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 10,
//                       spreadRadius: 1,
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       months[index],
//                       style: GoogleFonts.poppins(
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w700,
//                         color: FeeColors.darkText,
//                       ),
//                     ),
//                     SizedBox(height: 8.h),
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
//                       decoration: BoxDecoration(
//                         color: statusColors[index].withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(
//                             _getStatusIcon(statuses[index]),
//                             size: 12.sp,
//                             color: statusColors[index],
//                           ),
//                           SizedBox(width: 4.w),
//                           Text(
//                             statuses[index],
//                             style: GoogleFonts.poppins(
//                               fontSize: 10.sp,
//                               fontWeight: FontWeight.w600,
//                               color: statusColors[index],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       '₹5,000',
//                       style: GoogleFonts.poppins(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w600,
//                         color: FeeColors.darkText,
//                       ),
//                     ),
//                   ],
//                 ),
//               ).animate(delay: (index * 100 + 600).ms)
//                 .fadeIn()
//                 .scale(begin: Offset(0.9, 0.9)),
//             );
//           },
//         ),
//       ],
//     );
//   }
  
//   IconData _getStatusIcon(String status) {
//     switch (status) {
//       case 'Paid': return LucideIcons.checkCircle;
//       case 'Pending': return LucideIcons.clock;
//       case 'Overdue': return LucideIcons.alertCircle;
//       default: return LucideIcons.circle;
//     }
//   }

//   Widget _buildYearComparison(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 15,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Year-on-Year Comparison',
//             style: FeeTypography.headlineMedium(context),
//           ),
//           SizedBox(height: 20.h),
          
//           SizedBox(
//             height: 120.h,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: 3,
//               itemBuilder: (context, index) {
//                 final years = ['2022-23', '2023-24', '2024-25'];
//                 final percentages = [85, 90, 75];
//                 final amounts = ['₹51,000', '₹54,000', '₹45,000'];
                
//                 return Container(
//                   width: 100.w,
//                   margin: EdgeInsets.only(right: 16.w),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         '${percentages[index]}%',
//                         style: GoogleFonts.poppins(
//                           fontSize: 10.sp,
//                           fontWeight: FontWeight.w500,
//                           color: FeeColors.lightText,
//                         ),
//                       ),
//                       SizedBox(height: 8.h),
//                       Container(
//                         height: (percentages[index] / 100 * 80).h,
//                         width: 40.w,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               FeeColors.primaryOrange,
//                               FeeColors.secondaryOrange,
//                             ],
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                           ),
//                           borderRadius: BorderRadius.vertical(
//                             top: Radius.circular(8.r),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 8.h),
//                       Text(
//                         years[index],
//                         style: GoogleFonts.poppins(
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.w600,
//                           color: FeeColors.darkText,
//                         ),
//                       ),
//                       SizedBox(height: 4.h),
//                       Text(
//                         amounts[index],
//                         style: GoogleFonts.poppins(
//                           fontSize: 10.sp,
//                           fontWeight: FontWeight.w500,
//                           color: FeeColors.lightText,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     ).animate(delay: 800.ms).fadeIn().slideY(begin: 0.2, end: 0);
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:qr_code_scanner/core/constants/fee_colors.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/fee_controller.dart';
import 'package:qr_code_scanner/presentation/views/fee/fee_home_screen.dart';
import 'package:qr_code_scanner/presentation/views/fee/monthly_fee_screen.dart';

class YearlyFeeScreen extends StatelessWidget {
  YearlyFeeScreen({super.key});

  // final FeeController controller = Get.find();
  final FeesController feeController = Get.put(FeesController());
  final RxInt selectedYear = 2026.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FeeColors.backgroundWhite,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              FeeColors.backgroundWhite,
              FeeColors.warmWhite,
              FeeColors.lightOrangeTint,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildYearSwitcher(),
                      SizedBox(height: 20.h),
                      _buildHeroCard(context),
                      SizedBox(height: 22.h),
                      _buildMonthTimeline(context),
                      SizedBox(height: 22.h),
                      // _buildStatusLegend(context),
                      // SizedBox(height: 22.h),
                      // _buildPastYears(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 10.h, 14.w, 8.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              LucideIcons.arrowLeft,
              size: 23.sp,
              color: FeeColors.darkText,
            ),
          ),
          Expanded(
            child: Text(
              'Yearly Records',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 22.sp,
                fontWeight: FontWeight.w800,
                color: FeeColors.darkText,
              ),
            ),
          ),
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: FeeColors.primaryOrange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              LucideIcons.calendarRange,
              color: FeeColors.primaryOrange,
              size: 21.sp,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildYearSwitcher() {
  //   return Obx(
  //     () => Container(
  //       padding: EdgeInsets.all(8.w),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(22.r),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black.withOpacity(0.045),
  //             blurRadius: 14,
  //             offset: const Offset(0, 6),
  //           ),
  //         ],
  //       ),
  //       child: Row(
  //         children: [
  //           _yearButton(
  //             icon: LucideIcons.chevronLeft,
  //             onTap: () => selectedYear.value--,
  //           ),
  //           Expanded(
  //             child: Column(
  //               children: [
  //                 Text(
  //                   'Academic Session',
  //                   style: GoogleFonts.poppins(
  //                     fontSize: 11.sp,
  //                     fontWeight: FontWeight.w500,
  //                     color: FeeColors.lightText,
  //                   ),
  //                 ),
  //                 SizedBox(height: 2.h),
  //                 Text(
  //                   '${selectedYear.value} - ${selectedYear.value + 1}',
  //                   style: GoogleFonts.poppins(
  //                     fontSize: 18.sp,
  //                     fontWeight: FontWeight.w800,
  //                     color: FeeColors.darkText,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           _yearButton(
  //             icon: LucideIcons.chevronRight,
  //             onTap: () => selectedYear.value++,
  //           ),
  //         ],
  //       ),
  //     ).animate().fadeIn().slideY(begin: -0.1),
  //   );
  // }


Widget _buildYearSwitcher() {
  return Obx(
    () => Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.045),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          feeController.hasPreviousYear
              ? _yearButton(
                  icon: LucideIcons.chevronLeft,
                  onTap: feeController.previousYear,
                )
              : SizedBox(width: 48.w),

          Expanded(
            child: Column(
              children: [
                Text(
                  'Academic Session',
                  style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: FeeColors.lightText,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  feeController.selectedYearText,
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: FeeColors.darkText,
                  ),
                ),
              ],
            ),
          ),

          feeController.hasNextYear
              ? _yearButton(
                  icon: LucideIcons.chevronRight,
                  onTap: feeController.nextYear,
                )
              : SizedBox(width: 48.w),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.1),
  );
}
  Widget _yearButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          gradient: FeeColors.primaryGradient,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Icon(icon, color: Colors.white, size: 22.sp),
      ),
    );
  }

 Widget _buildHeroCard(BuildContext context) {
  return Obx(() {
    final fees = feeController.fees.toList();
    final now = DateTime.now();

    final paidCount = fees.where((e) {
      return e.status.toLowerCase() == 'paid' &&
          e.month.startsWith('${now.year}-');
    }).length;

    final totalMonths = now.month;
    final pendingCount = totalMonths - paidCount;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        color: FeeColors.backgroundWhite,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: FeeColors.warmWhite,
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -25.w,
            top: -25.h,
            child: Container(
              width: 110.w,
              height: 110.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: FeeColors.primaryOrange.withOpacity(0.18),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                LucideIcons.fileBadge,
                color: FeeColors.primaryOrange,
                size: 30.sp,
              ),
              SizedBox(height: 14.h),
              Text(
                'Fee Record Summary',
                style: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  color: FeeColors.darkText,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                'Session ${now.year}-${now.year + 1}',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: FeeColors.lightText,
                ),
              ),
              SizedBox(height: 22.h),
              Row(
                children: [
                  Expanded(
                    child: _heroStat(
                      value: '$paidCount',
                      label: 'Paid',
                      icon: LucideIcons.checkCircle2,
                      color: FeeColors.paidColor,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _heroStat(
                      value: '$pendingCount',
                      label: 'Pending',
                      icon: LucideIcons.clock3,
                      color: FeeColors.overdueColor,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _heroStat(
                      value: '$totalMonths',
                      label: 'Total',
                      icon: LucideIcons.calendar,
                      color: FeeColors.darkText,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ).animate(delay: 150.ms).fadeIn().slideY(begin: 0.15);
  });
}
  Widget _heroStat({
  required String value,
  required String label,
  required IconData icon,
  required Color color,
}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 8.w),
    decoration: BoxDecoration(
      color: color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(18.r),
      border: Border.all(color: color.withOpacity(0.12)),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 19.sp),
        SizedBox(height: 7.h),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 19.sp,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10.sp,
            color: color.withOpacity(0.8),
          ),
        ),
      ],
    ),
  );
}  // Widget _buildMonthTimeline(BuildContext context) {
  //   final months = [
  //     'April',
  //     'May',
  //     'June',
  //     'July',
  //     'August',
  //     'September',
  //     'October',
  //     'November',
  //     'December',
  //     'January',
  //     'February',
  //     'March',
  //   ];

  //   final statuses = [
  //     'Paid',
  //     'Paid',
  //     'Paid',
  //     'Paid',
  //     'Paid',
  //     'Paid',
  //     'Paid',
  //     'Paid',
  //     'Paid',
  //     'Pending',
  //     'Pending',
  //     'Pending',
  //   ];

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       _sectionHeader(
  //         title: 'Monthly Timeline',
  //         subtitle: 'Complete yearly fee record month wise',
  //       ),
  //       SizedBox(height: 14.h),
  //       ListView.separated(
  //         itemCount: months.length,
  //         shrinkWrap: true,
  //         physics: const NeverScrollableScrollPhysics(),
  //         separatorBuilder: (_, __) => SizedBox(height: 10.h),
  //         itemBuilder: (context, index) {
  //           final status = statuses[index];
  //           final color = _statusColor(status);

  //           return InkWell(
  //             onTap: () => Get.to(() => MonthlyFeeScreen()),
  //             borderRadius: BorderRadius.circular(20.r),
  //             child: Container(
  //               padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 14.h),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(20.r),
  //                 border: Border.all(color: color.withOpacity(0.12)),
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: Colors.black.withOpacity(0.035),
  //                     blurRadius: 12,
  //                     offset: const Offset(0, 5),
  //                   ),
  //                 ],
  //               ),
  //               child: Row(
  //                 children: [
  //                   Container(
  //                     width: 42.w,
  //                     height: 42.w,
  //                     decoration: BoxDecoration(
  //                       color: color.withOpacity(0.1),
  //                       borderRadius: BorderRadius.circular(14.r),
  //                     ),
  //                     child: Icon(
  //                       _statusIcon(status),
  //                       color: color,
  //                       size: 21.sp,
  //                     ),
  //                   ),
  //                   SizedBox(width: 14.w),
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           months[index],
  //                           maxLines: 1,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: GoogleFonts.poppins(
  //                             fontSize: 15.sp,
  //                             fontWeight: FontWeight.w800,
  //                             color: FeeColors.darkText,
  //                           ),
  //                         ),
  //                         SizedBox(height: 3.h),
  //                         Text(
  //                           status == 'Paid'
  //                               ? 'Payment record completed'
  //                               : 'Waiting for confirmation',
  //                           maxLines: 1,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: GoogleFonts.poppins(
  //                             fontSize: 11.sp,
  //                             color: FeeColors.lightText,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(width: 8.w),
  //                   _statusChip(status),
  //                   SizedBox(width: 4.w),
  //                   Icon(
  //                     LucideIcons.chevronRight,
  //                     size: 18.sp,
  //                     color: FeeColors.lightText.withOpacity(0.7),
  //                   ),
  //                 ],
  //               ),
  //             ).animate(delay: (index * 45).ms).fadeIn().slideX(begin: 0.08),
  //           );
  //         },
  //       ),
  //     ],
  //   );
  // }

  Widget _buildMonthTimeline(BuildContext context) {
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

  return Obx(() {
    final fees = feeController.fees.toList();
    final now = DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          title: 'Monthly Timeline',
          subtitle: 'Complete yearly fee record month wise',
        ),

        SizedBox(height: 14.h),

        ListView.separated(
          itemCount: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => SizedBox(height: 10.h),
          itemBuilder: (context, index) {
            final monthNumber = index + 1;

            final monthKey =
                '${now.year}-${monthNumber.toString().padLeft(2, '0')}';

            final fee = fees.firstWhereOrNull(
              (e) => e.month == monthKey,
            );

            final isFutureMonth = monthNumber > now.month;

            final isPaid =
                fee?.status.toLowerCase() == 'paid';

            final status = isFutureMonth
                ? 'Upcoming'
                : isPaid
                    ? 'Paid'
                    : 'Unpaid';

            final color = isFutureMonth
                ? Colors.grey
                : isPaid
                    ? FeeColors.paidColor
                    : FeeColors.overdueColor;

            final icon = isFutureMonth
                ? LucideIcons.clock
                : isPaid
                    ? LucideIcons.checkCircle2
                    : LucideIcons.alertCircle;

            return InkWell(
              onTap: isFutureMonth
                  ? null
                  : () {
                      Get.to(
                        () => MonthlyFeeScreen(),
                        arguments: {
                          'year': now.year,
                          'month': monthNumber,
                        },
                      );
                    },
              borderRadius: BorderRadius.circular(20.r),
              child: Opacity(
                opacity: isFutureMonth ? 0.55 : 1,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 14.h,
                  ),
                  decoration: BoxDecoration(
                    color: isFutureMonth
                        ? Colors.grey.shade100
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: color.withOpacity(0.12),
                    ),
                    boxShadow: [
                      if (!isFutureMonth)
                        BoxShadow(
                          color: Colors.black.withOpacity(0.035),
                          blurRadius: 12,
                          offset: const Offset(0, 5),
                        ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 42.w,
                        height: 42.w,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: 
                        
                        Icon(
                          icon,
                          color: color,
                          size: 21.sp,
                        ),
                      ),

                      SizedBox(width: 14.w),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${months[index]} ${now.year}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                                color: isFutureMonth
                                    ? Colors.grey
                                    : FeeColors.darkText,
                              ),
                            ),

                            SizedBox(height: 3.h),

                            Text(
                              status == 'Paid'
                                  ? 'Payment record completed'
                                  : status == 'Unpaid'
                                      ? 'Payment not marked paid'
                                      : 'Upcoming month',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 11.sp,
                                color: isFutureMonth
                                    ? Colors.grey
                                    : FeeColors.lightText,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 8.w),

                      _statusChip(status),

                      SizedBox(width: 4.w),

                      Icon(
                        LucideIcons.chevronRight,
                        size: 18.sp,
                        color: isFutureMonth
                            ? Colors.grey
                            : FeeColors.lightText.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
              ).animate(delay: (index * 45).ms).fadeIn().slideX(begin: 0.08),
            );
          },
        ),
      ],
    );
  });
}

  Widget _buildStatusLegend(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: _whiteCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            title: 'Status Guide',
            subtitle: 'Quick explanation of record status',
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _legendItem(
                  title: 'Paid',
                  subtitle: 'Confirmed',
                  icon: LucideIcons.checkCircle2,
                  color: FeeColors.paidColor,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _legendItem(
                  title: 'Pending',
                  subtitle: 'Not confirmed',
                  icon: LucideIcons.clock3,
                  color: FeeColors.pendingColor,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.12);
  }

  Widget _legendItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24.sp),
          SizedBox(height: 8.h),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
              color: FeeColors.darkText,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 10.sp,
              color: FeeColors.lightText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastYears(BuildContext context) {
    final years = ['2023-2024', '2024-2025', '2025-2026'];
    final records = ['10/12 Completed', '11/12 Completed', '9/12 Completed'];

    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: _whiteCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            title: 'Previous Records',
            subtitle: 'Academic year completion overview',
          ),
          SizedBox(height: 14.h),
          ...List.generate(years.length, (index) {
            return Container(
              margin: EdgeInsets.only(bottom: index == years.length - 1 ? 0 : 10.h),
              padding: EdgeInsets.all(13.w),
              decoration: BoxDecoration(
                color: FeeColors.lightOrangeTint.withOpacity(0.35),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Icon(
                    LucideIcons.folderCheck,
                    color: FeeColors.primaryOrange,
                    size: 22.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      years[index],
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: FeeColors.darkText,
                      ),
                    ),
                  ),
                  Text(
                    records[index],
                    style: GoogleFonts.poppins(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: FeeColors.lightText,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    ).animate(delay: 450.ms).fadeIn().slideY(begin: 0.12);
  }

  Widget _sectionHeader({
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: FeeColors.darkText,
          ),
        ),
        SizedBox(height: 3.h),
        Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: FeeColors.lightText,
          ),
        ),
      ],
    );
  }

  Widget _statusChip(String status) {
    final color = _statusColor(status);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Text(
        status,
        style: GoogleFonts.poppins(
          fontSize: 10.sp,
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Paid':
        return FeeColors.paidColor;
      case 'Pending':
        return FeeColors.pendingColor;
      case 'Overdue':
        return FeeColors.overdueColor;
      default:
        return FeeColors.lightText;
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'Paid':
        return LucideIcons.checkCircle2;
      case 'Pending':
        return LucideIcons.clock3;
      case 'Overdue':
        return LucideIcons.alertCircle;
      default:
        return LucideIcons.circle;
    }
  }

  BoxDecoration _whiteCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 16,
          offset: const Offset(0, 7),
        ),
      ],
    );
  }
}