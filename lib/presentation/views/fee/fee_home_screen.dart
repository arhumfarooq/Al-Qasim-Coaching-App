// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lucide_icons/lucide_icons.dart';
// import 'package:qr_code_scanner/components/login_background_elements.dart';
// import 'package:qr_code_scanner/core/constants/fee_colors.dart';
// import 'package:qr_code_scanner/presentation/views/fee/monthly_fee_screen.dart';
// import 'package:qr_code_scanner/presentation/views/fee/yearly_fee_screen.dart';


// class FeeHomeScreen extends StatelessWidget {
//   final FeeController controller = Get.put(FeeController());
  
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
     
//             const BackgroundElements(),
          
//             SafeArea(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Header
//                     _buildHeaderSection(context),
//                     SizedBox(height: 32.h),
                    
//                     // Overall Fee Status Card
//                     _buildOverallFeeCard(context),
//                     SizedBox(height: 24.h),
                    
//                     // Current Month Status
//                     _buildCurrentMonthCard(context),
//                     SizedBox(height: 24.h),
                    
//                     // Upcoming Payments
//                     _buildUpcomingPayments(context),
//                     SizedBox(height: 32.h),
                    
//                     // Recent Transactions
//                     _buildRecentTransactions(context),

//                     SizedBox(height: 80.h),
//                   ],
//                 ),
//               ),
//             ),
            
//             // Quick Action Button
//             Positioned(
//               bottom: 24.h,
//               right: 24.w,
//               child: FloatingActionButton(
//                 onPressed: () => Get.to(() => YearlyFeeScreen()),
//                 backgroundColor: FeeColors.primaryOrange,
//                 child: Icon(LucideIcons.wallet, color: Colors.white, size: 24.sp),
//               ).animate().scale(delay: 300.ms).fadeIn(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
  


//   Widget _buildHeaderSection(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Fee Status',
//                   style: FeeTypography.headlineLarge(context),
//                 ).animate().fadeIn(delay: 100.ms),
//                 SizedBox(height: 4.h),
//                 Text(
//                   'December 2024',
//                   style: FeeTypography.bodyMedium(context),
//                 ).animate().fadeIn(delay: 200.ms),
//               ],
//             ),
//             Container(
//               padding: EdgeInsets.all(12.w),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     spreadRadius: 1,
//                   ),
//                 ],
//               ),
//               child: Icon(LucideIcons.receipt, 
//                 color: FeeColors.primaryOrange, 
//                 size: 24.sp
//               ),
//             ).animate().scale(delay: 300.ms),
//           ],
//         ),
//         SizedBox(height: 8.h),
//         Text(
//           'Al-Qasim Academy • Class 10th',
//           style: FeeTypography.caption(context),
//         ).animate().fadeIn(delay: 400.ms),
//       ],
//     );
//   }

//   Widget _buildOverallFeeCard(BuildContext context) {
//     return Obx(() => Container(
//       padding: EdgeInsets.all(24.w),
//       decoration: BoxDecoration(
//         gradient: FeeColors.primaryGradient,
//         borderRadius: BorderRadius.circular(24.r),
//         boxShadow: [
//           BoxShadow(
//             color: FeeColors.primaryOrange.withOpacity(0.3),
//             blurRadius: 20,
//             spreadRadius: 2,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Annual Fee 2024-25',
//                     style: GoogleFonts.poppins(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white.withOpacity(0.9),
//                     ),
//                   ),
//                   SizedBox(height: 4.h),
//                   Text(
//                     'Due by June 30, 2025',
//                     style: GoogleFonts.poppins(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.white.withOpacity(0.7),
//                     ),
//                   ),
//                 ],
//               ),
//               Icon(LucideIcons.wallet, color: Colors.white, size: 24.sp),
//             ],
//           ),
//           SizedBox(height: 20.h),
          
//           // Progress Bar
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     '₹${controller.paidAmount.value}',
//                     style: GoogleFonts.poppins(
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white,
//                     ),
//                   ),
//                   Text(
//                     '₹${controller.totalAmount.value}',
//                     style: GoogleFonts.poppins(
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white.withOpacity(0.8),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 8.h),
//               Container(
//                 height: 8.h,
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(4.r),
//                 ),
//                 child: AnimatedFractionallySizedBox(
//                   duration: 1500.ms,
//                   alignment: Alignment.centerLeft,
//                   widthFactor: controller.progressPercentage / 100,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       gradient:  LinearGradient(
//                         colors: [Colors.white, Colors.white.withOpacity(0.8)],
//                       ),
//                       borderRadius: BorderRadius.circular(4.r),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 8.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Paid',
//                     style: GoogleFonts.poppins(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.white.withOpacity(0.8),
//                     ),
//                   ),
//                   Text(
//                     '${controller.progressPercentage.toStringAsFixed(0)}% Completed',
//                     style: GoogleFonts.poppins(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 20.h),
          
//           // Quick Stats
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildStatItem(
//                 title: 'Paid',
//                 value: '₹${controller.paidAmount.value}',
//                 color: Colors.white,
//                 icon: LucideIcons.checkCircle,
//               ),
//               _buildStatItem(
//                 title: 'Due',
//                 value: '₹${controller.dueAmount.value}',
//                 color: Colors.white.withOpacity(0.8),
//                 icon: LucideIcons.clock,
//               ),
//               _buildStatItem(
//                 title: 'Overdue',
//                 value: '₹${controller.overdueAmount.value}',
//                 color: Colors.white.withOpacity(0.9),
//                 icon: LucideIcons.alertCircle,
//               ),
//             ],
//           ),
//         ],
//       ),
//     ).animate(delay: 500.ms).fadeIn().slideY(begin: 0.2, end: 0));
//   }
  
//   Widget _buildStatItem({
//     required String title,
//     required String value,
//     required Color color,
//     required IconData icon,
//   }) {
//     return Column(
//       children: [
//         Icon(icon, size: 20.sp, color: color),
//         SizedBox(height: 8.h),
//         Text(
//           value,
//           style: GoogleFonts.poppins(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w700,
//             color: color,
//           ),
//         ),
//         SizedBox(height: 4.h),
//         Text(
//           title,
//           style: GoogleFonts.poppins(
//             fontSize: 11.sp,
//             fontWeight: FontWeight.w400,
//             color: color.withOpacity(0.7),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCurrentMonthCard(BuildContext context) {
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
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'December Fee',
//                 style: FeeTypography.headlineMedium(context),
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                 decoration: BoxDecoration(
//                   gradient: FeeColors.paidGradient,
//                   borderRadius: BorderRadius.circular(20.r),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(LucideIcons.check, size: 14.sp, color: Colors.white),
//                     SizedBox(width: 4.w),
//                     Text(
//                       'Paid',
//                       style: GoogleFonts.poppins(
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.h),
          
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Amount',
//                     style: FeeTypography.caption(context),
//                   ),
//                   SizedBox(height: 4.h),
//                   Text(
//                     '₹5,000',
//                     style: FeeTypography.amount(context),
//                   ),
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     'Paid on',
//                     style: FeeTypography.caption(context),
//                   ),
//                   SizedBox(height: 4.h),
//                   Text(
//                     'Dec 5, 2024',
//                     style: GoogleFonts.poppins(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w600,
//                       color: FeeColors.paidColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 20.h),
          
//           InkWell(
//             onTap: () => Get.to(() => MonthlyFeeScreen()),
//             borderRadius: BorderRadius.circular(16.r),
//             child: Container(
//               padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
//               decoration: BoxDecoration(
//                 color: FeeColors.primaryOrange.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(16.r),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'View All Monthly Fees',
//                     style: GoogleFonts.poppins(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w600,
//                       color: FeeColors.primaryOrange,
//                     ),
//                   ),
//                   SizedBox(width: 8.w),
//                   Icon(LucideIcons.chevronRight, 
//                     color: FeeColors.primaryOrange, 
//                     size: 16.sp
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ).animate(delay: 600.ms).fadeIn().slideY(begin: 0.2, end: 0);
//   }

//   Widget _buildUpcomingPayments(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Upcoming Payments',
//               style: FeeTypography.headlineMedium(context),
//             ).animate(delay: 700.ms).fadeIn(),
//             TextButton(
//               onPressed: () => Get.to(() => MonthlyFeeScreen()),
//               child: Text(
//                 'See All',
//                 style: GoogleFonts.poppins(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w600,
//                   color: FeeColors.primaryOrange,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 16.h),
        
//         ...List.generate(3, (index) => _buildUpcomingItem(index))
//             .animate(interval: 100.ms)
//             .fadeIn()
//             .slideX(begin: 0.1),
//       ],
//     );
//   }
  
//   Widget _buildUpcomingItem(int index) {
//     final months = ['January', 'February', 'March'];
//     final amounts = ['₹5,000', '₹5,000', '₹5,000'];
//     final dueDates = ['Jan 5, 2025', 'Feb 5, 2025', 'Mar 5, 2025'];
    
//     return Container(
//       margin: EdgeInsets.only(bottom: 12.h),
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.03),
//             blurRadius: 8,
//             spreadRadius: 1,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: EdgeInsets.all(12.w),
//             decoration: BoxDecoration(
//               color: FeeColors.pendingColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//             child: Icon(
//               LucideIcons.clock,
//               color: FeeColors.pendingColor,
//               size: 24.sp,
//             ),
//           ),
//           SizedBox(width: 16.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   months[index],
//                   style: GoogleFonts.poppins(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.w600,
//                     color: FeeColors.darkText,
//                   ),
//                 ),
//                 SizedBox(height: 4.h),
//                 Text(
//                   'Due by ${dueDates[index]}',
//                   style: GoogleFonts.poppins(
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.w400,
//                     color: FeeColors.lightText,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 amounts[index],
//                 style: GoogleFonts.poppins(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w700,
//                   color: FeeColors.darkText,
//                 ),
//               ),
//               SizedBox(height: 4.h),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
//                 decoration: BoxDecoration(
//                   color: FeeColors.pendingColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 child: Text(
//                   'Pending',
//                   style: GoogleFonts.poppins(
//                     fontSize: 10.sp,
//                     fontWeight: FontWeight.w600,
//                     color: FeeColors.pendingColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildRecentTransactions(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Recent Transactions',
//           style: FeeTypography.headlineMedium(context),
//         ).animate(delay: 1000.ms).fadeIn(),
//         SizedBox(height: 16.h),
        
//         ...List.generate(3, (index) => _buildTransactionItem(index))
//             .animate(interval: 100.ms)
//             .fadeIn()
//             .slideX(begin: 0.1),
//       ],
//     );
//   }
  
//   Widget _buildTransactionItem(int index) {
//     final descriptions = ['December Fee', 'November Fee', 'October Fee'];
//     final dates = ['Dec 5, 2024', 'Nov 5, 2024', 'Oct 5, 2024'];
//     final amounts = ['₹5,000', '₹5,000', '₹5,000'];
    
//     return Container(
//       margin: EdgeInsets.only(bottom: 12.h),
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.03),
//             blurRadius: 8,
//             spreadRadius: 1,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: EdgeInsets.all(12.w),
//             decoration: BoxDecoration(
//               color: FeeColors.paidColor.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               LucideIcons.checkCircle,
//               color: FeeColors.paidColor,
//               size: 20.sp,
//             ),
//           ),
//           SizedBox(width: 16.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   descriptions[index],
//                   style: GoogleFonts.poppins(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w600,
//                     color: FeeColors.darkText,
//                   ),
//                 ),
//                 SizedBox(height: 4.h),
//                 Text(
//                   dates[index],
//                   style: GoogleFonts.poppins(
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.w400,
//                     color: FeeColors.lightText,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 amounts[index],
//                 style: GoogleFonts.poppins(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w700,
//                   color: FeeColors.darkText,
//                 ),
//               ),
//               SizedBox(height: 4.h),
//               Text(
//                 'Online Payment',
//                 style: GoogleFonts.poppins(
//                   fontSize: 10.sp,
//                   fontWeight: FontWeight.w400,
//                   color: FeeColors.lightText,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FeeController extends GetxController {
//   var totalAmount = 60000.obs;
//   var paidAmount = 45000.obs;
//   var dueAmount = 15000.obs;
//   var overdueAmount = 0.obs;
  
//   double get progressPercentage => (paidAmount.value / totalAmount.value) * 100;
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:qr_code_scanner/components/login_background_elements.dart';
import 'package:qr_code_scanner/components/test_constants.dart';
import 'package:qr_code_scanner/core/constants/fee_colors.dart';
import 'package:qr_code_scanner/data/models/datafetch/fee_model.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/fee_controller.dart';
import 'package:qr_code_scanner/presentation/views/fee/monthly_fee_screen.dart';
import 'package:qr_code_scanner/presentation/views/fee/yearly_fee_screen.dart';

class FeeHomeScreen extends StatelessWidget {
  FeeHomeScreen({super.key});


final FeesController feeController = Get.put(FeesController());
  // final FeeController controller = Get.put(FeeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => YearlyFeeScreen()),
        backgroundColor: FeeColors.primaryOrange,
        icon: Icon(LucideIcons.calendarDays, color: Colors.white, size: 20.sp),
        label: Text(
          'Year View',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ).animate().scale(delay: 300.ms).fadeIn(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              FeeColors.backgroundWhite,
              FeeColors.warmWhite,
              FeeColors.lightOrangeTint,
            ],
          ),
        ),
        child: Stack(
          children: [
            const BackgroundElements(),
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderSection(context),
                    SizedBox(height: 28.h),
                    _buildStatusOverviewCard(context),
                    SizedBox(height: 22.h),
                    _buildCurrentMonthCard(context),
                    // SizedBox(height: 22.h),
                    // _buildSummaryTiles(context),
                    SizedBox(height: 26.h),
                    _buildUpcomingPayments(context),
                    SizedBox(height: 26.h),
                    _buildRecentActivity(context),
                    SizedBox(height: 90.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildHeaderSection(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Expanded(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text('Fee Status', style: FeeTypography.headlineLarge(context))
  //                 .animate()
  //                 .fadeIn(delay: 100.ms),
  //             SizedBox(height: 6.h),
  //             Text(
  //               'Track monthly fee records and payment status',
  //               style: FeeTypography.bodyMedium(context),
  //             ).animate().fadeIn(delay: 180.ms),
  //             SizedBox(height: 10.h),
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
  //               decoration: BoxDecoration(
  //                 color: Colors.white.withOpacity(0.85),
  //                 borderRadius: BorderRadius.circular(50.r),
  //                 border: Border.all(
  //                   color: FeeColors.primaryOrange.withOpacity(0.15),
  //                 ),
  //               ),
  //               child: Text(
  //                 'Al-Qasim Academy • Class 10th',
  //                 style: FeeTypography.caption(context),
  //               ),
  //             ).animate().fadeIn(delay: 250.ms).slideX(begin: -0.08),
  //           ],
  //         ),
  //       ),
  //       SizedBox(width: 12.w),
  //       Container(
  //         padding: EdgeInsets.all(13.w),
  //         decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           color: Colors.white,
  //           boxShadow: [
  //             BoxShadow(
  //               color: FeeColors.primaryOrange.withOpacity(0.12),
  //               blurRadius: 18,
  //               offset: const Offset(0, 8),
  //             ),
  //           ],
  //         ),
  //         child: Icon(
  //           LucideIcons.receipt,
  //           color: FeeColors.primaryOrange,
  //           size: 25.sp,
  //         ),
  //       ).animate().scale(delay: 300.ms),
  //     ],
  //   );
  // }


// Widget _buildHeaderSection(BuildContext context) {
//   return Obx(() {

//     final student =
//         feeController.currentStudent;

//     return Row(
//       mainAxisAlignment:
//           MainAxisAlignment.spaceBetween,
//       children: [

//         Expanded(
//           child: Column(
//             crossAxisAlignment:
//                 CrossAxisAlignment.start,
//             children: [

//               Text(
//                 'Fee Status',
//                 style: FeeTypography
//                     .headlineLarge(context),
//               )
//                   .animate()
//                   .fadeIn(delay: 100.ms),

//               SizedBox(height: 6.h),

//               Text(
//                 'Track monthly fee records and payment status',
//                 style:
//                     FeeTypography.bodyMedium(context),
//               ).animate().fadeIn(delay: 180.ms),

//               SizedBox(height: 10.h),

//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 12.w,
//                   vertical: 7.h,
//                 ),
//                 decoration: BoxDecoration(
//                   color:
//                       Colors.white.withOpacity(0.85),
//                   borderRadius:
//                       BorderRadius.circular(50.r),
//                   border: Border.all(
//                     color: FeeColors.primaryOrange
//                         .withOpacity(0.15),
//                   ),
//                 ),
//                 child: Text(
//                   'Al-Qasim Academy • Class ${student?.grade ?? '--'}th',
//                   style:
//                       FeeTypography.caption(context),
//                 ),
//               )
//                   .animate()
//                   .fadeIn(delay: 250.ms)
//                   .slideX(begin: -0.08),
//             ],
//           ),
//         ),

//         SizedBox(width: 12.w),

//         Container(
//           padding: EdgeInsets.all(13.w),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: FeeColors.primaryOrange
//                     .withOpacity(0.12),
//                 blurRadius: 18,
//                 offset: const Offset(0, 8),
//               ),
//             ],
//           ),
//           child: Icon(
//             LucideIcons.receipt,
//             color: FeeColors.primaryOrange,
//             size: 25.sp,
//           ),
//         ).animate().scale(delay: 300.ms),
//       ],
//     );
//   });
// }


Widget _buildHeaderSection(BuildContext context) {
  return Obx(() {

    final student =
        feeController.currentStudent;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(
              LucideIcons.arrowLeft,
              color: FeeColors.darkText,
              size: 20.sp,
            ),
          ),
        ).animate().scale(delay: 100.ms),

        SizedBox(width: 14.w),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Text(
                'Fee Status',
                style: FeeTypography
                    .headlineLarge(context),
              )
                  .animate()
                  .fadeIn(delay: 100.ms),

              SizedBox(height: 6.h),

              Text(
                'Track monthly fee records and payment status',
                style:
                    FeeTypography.bodyMedium(context),
              ).animate().fadeIn(delay: 180.ms),

              SizedBox(height: 10.h),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 7.h,
                ),
                decoration: BoxDecoration(
                  color:
                      Colors.white.withOpacity(0.85),
                  borderRadius:
                      BorderRadius.circular(50.r),
                  border: Border.all(
                    color: FeeColors.primaryOrange
                        .withOpacity(0.15),
                  ),
                ),
                child: Text(
                  'Al-Qasim Academy • Class ${student?.grade ?? '--'}th',
                  style:
                      FeeTypography.caption(context),
                ),
              )
                  .animate()
                  .fadeIn(delay: 250.ms)
                  .slideX(begin: -0.08),
            ],
          ),
        ),
      ],
    );
  });
}


  // Widget _buildStatusOverviewCard(BuildContext context) {
  //   return Container(
  //     padding: EdgeInsets.all(22.w),
  //     decoration: BoxDecoration(
  //       gradient: FeeColors.primaryGradient,
  //       borderRadius: BorderRadius.circular(26.r),
  //       boxShadow: [
  //         BoxShadow(
  //           color: FeeColors.primaryOrange.withOpacity(0.28),
  //           blurRadius: 24,
  //           offset: const Offset(0, 10),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Container(
  //               padding: EdgeInsets.all(12.w),
  //               decoration: BoxDecoration(
  //                 color: Colors.white.withOpacity(0.18),
  //                 borderRadius: BorderRadius.circular(16.r),
  //               ),
  //               child: Icon(
  //                 LucideIcons.shieldCheck,
  //                 color: Colors.white,
  //                 size: 24.sp,
  //               ),
  //             ),
  //             SizedBox(width: 14.w),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     controller.academicYear.value,
  //                     style: GoogleFonts.poppins(
  //                       fontSize: 17.sp,
  //                       fontWeight: FontWeight.w700,
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                   SizedBox(height: 3.h),
  //                   Text(
  //                     'Overall fee record summary',
  //                     style: GoogleFonts.poppins(
  //                       fontSize: 12.sp,
  //                       color: Colors.white.withOpacity(0.75),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
  //               decoration: BoxDecoration(
  //                 color: Colors.white.withOpacity(0.18),
  //                 borderRadius: BorderRadius.circular(30.r),
  //               ),
  //               child: Text(
  //                 controller.overallStatus.value,
  //                 style: GoogleFonts.poppins(
  //                   fontSize: 12.sp,
  //                   fontWeight: FontWeight.w700,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 22.h),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: _buildWhiteStat(
  //                 icon: LucideIcons.checkCircle2,
  //                 title: 'Paid Months',
  //                 value: '${controller.paidMonths.value}',
  //               ),
  //             ),
  //             SizedBox(width: 12.w),
  //             Expanded(
  //               child: _buildWhiteStat(
  //                 icon: LucideIcons.clock3,
  //                 title: 'Pending',
  //                 value: '${controller.pendingMonths.value}',
  //               ),
  //             ),
  //             SizedBox(width: 12.w),
  //             Expanded(
  //               child: _buildWhiteStat(
  //                 icon: LucideIcons.calendar,
  //                 title: 'Total',
  //                 value: '${controller.totalMonths.value}',
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.18, end: 0);
  // }


Widget _buildStatusOverviewCard(BuildContext context) {
  return Obx(() {
    final now = DateTime.now();

    final paidMonths = feeController.paidCount;
    final totalMonths = now.month;
    final pendingMonths = totalMonths - paidMonths;

    final overallStatus =
        pendingMonths == 0 ? 'Clear' : 'Pending';

    return Container(
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        gradient: FeeColors.primaryGradient,
        borderRadius: BorderRadius.circular(26.r),
        boxShadow: [
          BoxShadow(
            color: FeeColors.primaryOrange.withOpacity(0.28),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(
                  LucideIcons.shieldCheck,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),

              SizedBox(width: 14.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Academic Year ${now.year}',
                      style: GoogleFonts.poppins(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      'Overall fee record summary',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: Colors.white.withOpacity(0.75),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 7.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                 "Active",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 22.h),

          Row(
            children: [
              Expanded(
                child: _buildWhiteStat(
                  icon: LucideIcons.checkCircle2,
                  title: 'Paid Months',
                  value: '$paidMonths',
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: _buildWhiteStat(
                  icon: LucideIcons.clock3,
                  title: 'Pending',
                  value: '$pendingMonths',
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: _buildWhiteStat(
                  icon: LucideIcons.calendar,
                  title: 'Total',
                  value: '$totalMonths',
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.18, end: 0);
  });
}

  Widget _buildWhiteStat({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 13.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.14),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20.sp, color: Colors.white),
          SizedBox(height: 8.h),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 10.sp,
              color: Colors.white.withOpacity(0.75),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildCurrentMonthCard(BuildContext context) {
  //   return Container(
  //     padding: EdgeInsets.all(20.w),
  //     decoration: _cardDecoration(),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Container(
  //               padding: EdgeInsets.all(11.w),
  //               decoration: BoxDecoration(
  //                 color: FeeColors.paidColor.withOpacity(0.1),
  //                 borderRadius: BorderRadius.circular(14.r),
  //               ),
  //               child: Icon(
  //                 LucideIcons.badgeCheck,
  //                 color: FeeColors.paidColor,
  //                 size: 23.sp,
  //               ),
  //             ),
  //             SizedBox(width: 14.w),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text('Current Month', style: FeeTypography.caption(context)),
  //                   SizedBox(height: 3.h),
  //                   Text(
  //                     controller.currentMonth.value,
  //                     style: FeeTypography.headlineMedium(context),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             _statusBadge(
  //               text: controller.currentMonthStatus.value,
  //               color: FeeColors.paidColor,
  //               icon: LucideIcons.check,
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 18.h),
  //         Divider(color: Colors.grey.withOpacity(0.12)),
  //         SizedBox(height: 14.h),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: _infoBlock(
  //                 context,
  //                 icon: LucideIcons.calendarClock,
  //                 label: 'Due Date',
  //                 value: controller.currentDueDate.value,
  //               ),
  //             ),
  //             SizedBox(width: 12.w),
  //             Expanded(
  //               child: _infoBlock(
  //                 context,
  //                 icon: LucideIcons.calendarCheck,
  //                 label: 'Paid Date',
  //                 value: controller.currentPaidDate.value,
  //                 valueColor: FeeColors.paidColor,
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 18.h),
  //         InkWell(
  //           onTap: () => Get.to(() => MonthlyFeeScreen()),
  //           borderRadius: BorderRadius.circular(16.r),
  //           child: Container(
  //             padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 16.w),
  //             decoration: BoxDecoration(
  //               color: FeeColors.primaryOrange.withOpacity(0.09),
  //               borderRadius: BorderRadius.circular(16.r),
  //             ),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text(
  //                   'View Monthly Records',
  //                   style: GoogleFonts.poppins(
  //                     fontSize: 14.sp,
  //                     fontWeight: FontWeight.w700,
  //                     color: FeeColors.primaryOrange,
  //                   ),
  //                 ),
  //                 SizedBox(width: 8.w),
  //                 Icon(
  //                   LucideIcons.chevronRight,
  //                   color: FeeColors.primaryOrange,
  //                   size: 17.sp,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   ).animate(delay: 550.ms).fadeIn().slideY(begin: 0.18, end: 0);
  // }

Widget _buildCurrentMonthCard(BuildContext context) {
  return Obx(() {



    final now = DateTime.now();

    

    final currentMonthKey =
        '${now.year}-${now.month.toString().padLeft(2, '0')}';

    final currentFee = feeController.fees.firstWhereOrNull(
      (e) => e.month == currentMonthKey,
    );

    final isPaid =
        currentFee?.status.toLowerCase() == 'paid';

    final statusText =
        isPaid ? 'Paid' : 'Unpaid';

    final statusColor =
        isPaid
            ? FeeColors.paidColor
            : FeeColors.overdueColor;

    final statusIcon =
        isPaid
            ? LucideIcons.check
            : LucideIcons.alertCircle;



            final dueDate = DateTime(now.year, now.month, 10);

final paidLabel = isPaid ? 'Paid Date' : 'Status';

final paidValue = isPaid && currentFee?.paidAt != null
    ? AppDateUtils.formatDate(currentFee!.paidAt!)
    : 'Not Paid Yet';

final paidIcon = isPaid
    ? LucideIcons.calendarCheck
    : LucideIcons.alertCircle;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              Container(
                padding: EdgeInsets.all(11.w),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(14.r),
                ),
                child: Icon(
                  statusIcon,
                  color: statusColor,
                  size: 23.sp,
                ),
              ),

              SizedBox(width: 14.w),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(
                      'Current Month',
                      style:
                          FeeTypography.caption(context),
                    ),

                    SizedBox(height: 3.h),

                    Text(
                      feeController.formatMonth(
                        currentMonthKey,
                      ),
                      style: FeeTypography
                          .headlineMedium(context),
                    ),
                  ],
                ),
              ),

              _statusBadge(
                text: statusText,
                color: statusColor,
                icon: statusIcon,
              ),
            ],
          ),

          SizedBox(height: 18.h),

          Divider(
            color: Colors.grey.withOpacity(0.12),
          ),

          SizedBox(height: 14.h),

          Row(
            children: [

              // Expanded(
              //   child: _infoBlock(
              //     context,
              //     icon: LucideIcons.calendarClock,
              //     label: 'Due Date',
              //     value: currentFee?.dueDate != null
              //         ? AppDateUtils.formatDate(
              //             currentFee!.dueDate!,
              //           )
              //         : '--',
              //   ),
              // ),


Expanded(
  child: _infoBlock(
    context,
    icon: LucideIcons.calendarClock,
    label: 'Due Date',
    value: AppDateUtils.formatDate(dueDate),
  ),
),
              SizedBox(width: 12.w),

              // Expanded(
              //   child: _infoBlock(
              //     context,
              //     icon: LucideIcons.calendarCheck,
              //     label: 'Paid Date',
              //     value: currentFee?.paidAt != null
              //         ? AppDateUtils.formatDate(
              //             currentFee!.paidAt!,
              //           )
              //         : '--',
              //     valueColor: statusColor,
              //   ),
              // ),

              Expanded(
  child: _infoBlock(
    context,
    icon: paidIcon,
    label: paidLabel,
    value: paidValue,
    valueColor: statusColor,
  ),
),
            ],
          ),

          SizedBox(height: 18.h),

          InkWell(
            onTap: () => Get.to(
              () => MonthlyFeeScreen(),
              arguments: {
'year': now.year,
                'month': now.month,
              
              },
            ),
            borderRadius:
                BorderRadius.circular(16.r),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 13.h,
                horizontal: 16.w,
              ),
              decoration: BoxDecoration(
                color: FeeColors.primaryOrange
                    .withOpacity(0.09),
                borderRadius:
                    BorderRadius.circular(16.r),
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [

                  Text(
                    'View Monthly Records',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color:
                          FeeColors.primaryOrange,
                    ),
                  ),

                  SizedBox(width: 8.w),

                  Icon(
                    LucideIcons.chevronRight,
                    color:
                        FeeColors.primaryOrange,
                    size: 17.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate(delay: 550.ms)
        .fadeIn()
        .slideY(begin: 0.18, end: 0);
  });
}

  // Widget _buildSummaryTiles(BuildContext context) {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: _smallSummaryTile(
  //           icon: LucideIcons.userCheck,
  //           title: 'Student',
  //           value: controller.studentName.value,
  //           color: FeeColors.primaryOrange,
  //         ),
  //       ),
  //       SizedBox(width: 12.w),
  //       Expanded(
  //         child: _smallSummaryTile(
  //           icon: LucideIcons.graduationCap,
  //           title: 'Class',
  //           value: controller.className.value,
  //           color: FeeColors.paidColor,
  //         ),
  //       ),
  //     ],
  //   ).animate(delay: 650.ms).fadeIn().slideY(begin: 0.12, end: 0);
  // }

  Widget _smallSummaryTile({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(icon, color: color, size: 21.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    color: FeeColors.lightText,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: FeeColors.darkText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//   Widget _buildUpcomingPayments(BuildContext context) {
//   return Obx(() {
//     final items = feeController.unpaidFees.take(5).toList();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _sectionHeader(
//           title: 'Upcoming Records',
//           actionText: 'See All',
//           onTap: () => Get.to(() => MonthlyFeeScreen()),
//         ).animate(delay: 750.ms).fadeIn(),

//         SizedBox(height: 14.h),

//         if (feeController.isLoading.value)
//           const Center(child: CircularProgressIndicator()),

//         if (!feeController.isLoading.value && items.isEmpty)
//           const Text('No upcoming or unpaid records'),

//         if (!feeController.isLoading.value)
//           ...items.map((item) {
//             return _buildUpcomingItem(item);
//           }).toList()
//               .animate(interval: 90.ms)
//               .fadeIn()
//               .slideX(begin: 0.08),
//       ],
//     );
//   });
// }

Widget _buildUpcomingPayments(BuildContext context) {
  return Obx(() {
    // final items = feeController.unpaidFees.take(5).toList();
    final items = feeController.pendingAndUpcomingMonths;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          title: 'Upcoming Records',
          actionText: 'See All',
          onTap: () => Get.to(() => MonthlyFeeScreen()),
        ).animate(delay: 750.ms).fadeIn(),

        SizedBox(height: 14.h),

        if (feeController.isLoading.value)
          const Center(child: CircularProgressIndicator()),

        if (!feeController.isLoading.value && items.isEmpty)
          const Text('No upcoming or unpaid records'),

        if (!feeController.isLoading.value)
          ...items.map((item) {
            return _buildUpcomingItem(item);
          }).toList()
              .animate(interval: 90.ms)
              .fadeIn()
              .slideX(begin: 0.08),
      ],
    );
  });
}
  // Widget _buildUpcomingPayments(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       _sectionHeader(
  //         title: 'Upcoming Records',
  //         actionText: 'See All',
  //         onTap: () => Get.to(() => MonthlyFeeScreen()),
  //       ).animate(delay: 750.ms).fadeIn(),
  //       SizedBox(height: 14.h),
  //       ...List.generate(3, (index) => _buildUpcomingItem(index))
  //           .animate(interval: 90.ms)
  //           .fadeIn()
  //           .slideX(begin: 0.08),
  //     ],
  //   );
  // }

  // Widget _buildUpcomingItem(int index) {
  //   final months = ['January', 'February', 'March'];
  //   final dueDates = ['Jan 10, 2026', 'Feb 10, 2026', 'Mar 10, 2026'];
  //   final statuses = ['Pending', 'Upcoming', 'Upcoming'];

  //   return Container(
  //     margin: EdgeInsets.only(bottom: 12.h),
  //     padding: EdgeInsets.all(16.w),
  //     decoration: _cardDecoration(),
  //     child: Row(
  //       children: [
  //         Container(
  //           padding: EdgeInsets.all(12.w),
  //           decoration: BoxDecoration(
  //             color: FeeColors.pendingColor.withOpacity(0.1),
  //             borderRadius: BorderRadius.circular(15.r),
  //           ),
  //           child: Icon(
  //             LucideIcons.clock,
  //             color: FeeColors.pendingColor,
  //             size: 23.sp,
  //           ),
  //         ),
  //         SizedBox(width: 15.w),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 months[index],
  //                 style: GoogleFonts.poppins(
  //                   fontSize: 15.sp,
  //                   fontWeight: FontWeight.w700,
  //                   color: FeeColors.darkText,
  //                 ),
  //               ),
  //               SizedBox(height: 4.h),
  //               Text(
  //                 'Due by ${dueDates[index]}',
  //                 style: GoogleFonts.poppins(
  //                   fontSize: 12.sp,
  //                   color: FeeColors.lightText,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         _statusBadge(
  //           text: statuses[index],
  //           color: FeeColors.pendingColor,
  //           icon: LucideIcons.hourglass,
  //           light: true,
  //         ),
  //       ],
  //     ),
  //   );
  // }


Widget _buildUpcomingItem(Map<String, dynamic> item) {
  final monthKey = item['monthKey'] as String;
  final statusText = item['status'] as String;
  final date = item['date'] as DateTime;

  final isUpcoming = statusText == 'Upcoming';

  final color = isUpcoming
      ? FeeColors.pendingColor
      : FeeColors.overdueColor;

  final icon = isUpcoming
      ? LucideIcons.hourglass
      : LucideIcons.alertCircle;

  return Container(
    margin: EdgeInsets.only(bottom: 12.h),
    padding: EdgeInsets.all(16.w),
    decoration: _cardDecoration(),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Icon(icon, color: color, size: 23.sp),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                feeController.formatMonth(monthKey),
                style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: FeeColors.darkText,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                isUpcoming
                    ? 'Upcoming fee record'
                    : 'Payment not marked paid',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: FeeColors.lightText,
                ),
              ),
            ],
          ),
        ),
        _statusBadge(
          text: statusText,
          color: color,
          icon: icon,
          light: true,
        ),
      ],
    ),
  );
}
  
  // Widget _buildRecentActivity(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         'Recent Activity',
  //         style: FeeTypography.headlineMedium(context),
  //       ).animate(delay: 950.ms).fadeIn(),
  //       SizedBox(height: 14.h),
  //       ...List.generate(3, (index) => _buildActivityItem(index))
  //           .animate(interval: 90.ms)
  //           .fadeIn()
  //           .slideX(begin: 0.08),
  //     ],
  //   );
  // }

  Widget _buildRecentActivity(BuildContext context) {
  return Obx(() {

    final paidFees = feeController.fees
        .where((e) => e.status == 'paid')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          'Recent Activity',
          style: FeeTypography.headlineMedium(context),
        ).animate(delay: 950.ms).fadeIn(),

        SizedBox(height: 14.h),

        if (feeController.isLoading.value)
          const Center(
            child: CircularProgressIndicator(),
          ),

        if (!feeController.isLoading.value &&
            paidFees.isEmpty)
          const Text(
            'No paid activity found',
          ),

        if (!feeController.isLoading.value)
          ...paidFees.take(3).map(
            (item) => _buildActivityItem(item),
          ).toList()
              .animate(interval: 90.ms)
              .fadeIn()
              .slideX(begin: 0.08),
      ],
    );
  });
}

  // Widget _buildActivityItem(int index) {
  //   final titles = ['December Fee Marked Paid', 'November Fee Verified', 'October Record Updated'];
  //   final dates = ['Dec 5, 2024', 'Nov 5, 2024', 'Oct 5, 2024'];
  //   final icons = [LucideIcons.checkCircle2, LucideIcons.badgeCheck, LucideIcons.fileCheck2];

  //   return Container(
  //     margin: EdgeInsets.only(bottom: 12.h),
  //     padding: EdgeInsets.all(16.w),
  //     decoration: _cardDecoration(),
  //     child: Row(
  //       children: [
  //         Container(
  //           padding: EdgeInsets.all(11.w),
  //           decoration: BoxDecoration(
  //             color: FeeColors.paidColor.withOpacity(0.1),
  //             shape: BoxShape.circle,
  //           ),
  //           child: Icon(
  //             icons[index],
  //             color: FeeColors.paidColor,
  //             size: 21.sp,
  //           ),
  //         ),
  //         SizedBox(width: 15.w),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 titles[index],
  //                 style: GoogleFonts.poppins(
  //                   fontSize: 14.sp,
  //                   fontWeight: FontWeight.w700,
  //                   color: FeeColors.darkText,
  //                 ),
  //               ),
  //               SizedBox(height: 4.h),
  //               Text(
  //                 dates[index],
  //                 style: GoogleFonts.poppins(
  //                   fontSize: 12.sp,
  //                   color: FeeColors.lightText,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Icon(
  //           LucideIcons.chevronRight,
  //           color: FeeColors.lightText.withOpacity(0.7),
  //           size: 18.sp,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildActivityItem(FeeModel item) {

  return Container(
    margin: EdgeInsets.only(bottom: 12.h),
    padding: EdgeInsets.all(16.w),
    decoration: _cardDecoration(),
    child: Row(
      children: [

        Container(
          padding: EdgeInsets.all(11.w),
          decoration: BoxDecoration(
            color: FeeColors.paidColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            LucideIcons.checkCircle2,
            color: FeeColors.paidColor,
            size: 21.sp,
          ),
        ),

        SizedBox(width: 15.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                '${feeController.formatMonth(item.month)} Fee Paid',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: FeeColors.darkText,
                ),
              ),

              SizedBox(height: 4.h),

              Text(
                item.paidAt != null
                    ? AppDateUtils.formatDate(item.paidAt!)
                    : 'Payment Verified',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: FeeColors.lightText,
                ),
              ),
            ],
          ),
        ),

        Icon(
          LucideIcons.chevronRight,
          color: FeeColors.lightText.withOpacity(0.7),
          size: 18.sp,
        ),
      ],
    ),
  );
}

  Widget _sectionHeader({
    required String title,
    required String actionText,
    required VoidCallback onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: FeeColors.darkText,
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            actionText,
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: FeeColors.primaryOrange,
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoBlock(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: FeeColors.lightOrangeTint.withOpacity(0.45),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: FeeColors.primaryOrange, size: 19.sp),
          SizedBox(height: 9.h),
          Text(label, style: FeeTypography.caption(context)),
          SizedBox(height: 4.h),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: valueColor ?? FeeColors.darkText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge({
    required String text,
    required Color color,
    required IconData icon,
    bool light = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: light ? color.withOpacity(0.1) : color,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13.sp, color: light ? color : Colors.white),
          SizedBox(width: 5.w),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: light ? color : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.045),
          blurRadius: 16,
          offset: const Offset(0, 7),
        ),
      ],
    );
  }
}

// class FeeController extends GetxController {
//   final academicYear = 'Academic Year 2026'.obs;
//   final overallStatus = 'Active'.obs;

//   final studentName = 'Student Record'.obs;
//   final className = 'Class 10'.obs;

//   final totalMonths = 12.obs;
//   final paidMonths = 8.obs;
//   final pendingMonths = 4.obs;

//   final currentMonth = 'December Fee'.obs;
//   final currentMonthStatus = 'Paid'.obs;
//   final currentDueDate = 'Dec 10, 2024'.obs;
//   final currentPaidDate = 'Dec 5, 2024'.obs;
// }