
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lucide_icons/lucide_icons.dart';
// import 'package:qr_code_scanner/core/constants/fee_colors.dart';
// import 'package:qr_code_scanner/presentation/views/fee/fee_home_screen.dart';

// class MonthlyFeeScreen extends StatelessWidget {
//   final FeeController controller = Get.put(FeeController());

//   final RxString selectedMonth = 'December 2024'.obs;
  
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
                  
//                   Expanded(
//                     child: SingleChildScrollView(
//                       padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
//                       child: Column(
//                         children: [
//                           // Month Summary
//                           _buildMonthSummary(),
//                           SizedBox(height: 24.h),
                          
//                           // Month Navigation
//                           _buildMonthNavigation(),
//                           SizedBox(height: 24.h),
                          
//                           // Fee Details Card
//                           _buildFeeDetailsCard(context),
//                           SizedBox(height: 24.h),
                          
//                           // Payment History
//                           _buildPaymentHistory(context),
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
//           top: -100,
//           left: -80,
//           child: Container(
//             width: 240.w,
//             height: 240.h,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: LinearGradient(
//                 colors: [
//                   FeeColors.darkOrange.withOpacity(0.03),
//                   FeeColors.darkOrange.withOpacity(0.01),
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
//                     'Monthly Fees',
//                     style: FeeTypography.headlineLarge(context),
//                   ).animate().fadeIn(),
//                 ),
//               ),
//               // IconButton(
//               //   onPressed: () {},
//               //   icon: Icon(LucideIcons.download, size: 24.sp),
//               // ),
//             ],
//           ),
//           SizedBox(height: 8.h),
//           Obx(() => Text(
//             selectedMonth.value,
//             style: FeeTypography.bodyMedium(context),
//           )),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildMonthSummary() {
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
//       child: Row(
//         children: [
//           Expanded(
//             child: _buildSummaryItem(
//               icon: LucideIcons.wallet,
//               value: '₹5,000',
//               label: 'Monthly Fee',
//               color: FeeColors.primaryOrange,
//             ),
//           ),
//           Container(
//             width: 1.w,
//             height: 40.h,
//             color: Colors.grey.shade200,
//           ),
//           Expanded(
//             child: _buildSummaryItem(
//               icon: LucideIcons.calendar,
//               value: 'Dec 5',
//               label: 'Due Date',
//               color: FeeColors.upcomingColor,
//             ),
//           ),
//           Container(
//             width: 1.w,
//             height: 40.h,
//             color: Colors.grey.shade200,
//           ),
//           Expanded(
//             child: _buildSummaryItem(
//               icon: LucideIcons.checkCircle,
//               value: 'Paid',
//               label: 'Status',
//               color: FeeColors.paidColor,
//             ),
//           ),
//         ],
//       ),
//     ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2, end: 0);
//   }
  
//   Widget _buildSummaryItem({required IconData icon, required String value, required String label, required Color color}) {
//     return Column(
//       children: [
//         Icon(icon, size: 24.sp, color: color),
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
//           label,
//           style: GoogleFonts.poppins(
//             fontSize: 11.sp,
//             fontWeight: FontWeight.w500,
//             color: FeeColors.lightText,
//           ),
//         ),
//       ],
//     );
//   }
  
//   Widget _buildMonthNavigation() {
//     final months = ['Oct', 'Nov', 'Dec', 'Jan', 'Feb'];
    
//     return SizedBox(
//       height: 60.h,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: months.length,
//         itemBuilder: (context, index) {
//           final isSelected = months[index] == 'Dec';
          
//           return GestureDetector(
//             onTap: () => selectedMonth.value = '${months[index]} 2024',
//             child: Container(
//               margin: EdgeInsets.only(right: 12.w),
//               padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
//               decoration: BoxDecoration(
//                 gradient: isSelected 
//                     ? FeeColors.primaryGradient
//                     : LinearGradient(colors: [Colors.grey.shade100, Colors.grey.shade100]),
//                 borderRadius: BorderRadius.circular(30.r),
//               ),
//               child: Center(
//                 child: Text(
//                   months[index],
//                   style: GoogleFonts.poppins(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.w600,
//                     color: isSelected ? Colors.white : FeeColors.lightText,
//                   ),
//                 ),
//               ),
//             ).animate(delay: (index * 100 + 300).ms)
//               .fadeIn()
//               .scale(begin: Offset(0.9, 0.9)),
//           );
//         },
//       ),
//     );
//   }
  
//   Widget _buildFeeDetailsCard(context) {
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
//             'Fee Breakdown',
//             style: FeeTypography.headlineMedium(context),
//           ),
//           SizedBox(height: 16.h),
          
//           ..._buildFeeBreakdownItems(),
          
//           Divider(height: 32.h, color: Colors.grey.shade200),
          
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Total Amount',
//                 style: GoogleFonts.poppins(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.w700,
//                   color: FeeColors.darkText,
//                 ),
//               ),
//               Text(
//                 '₹5,000',
//                 style: GoogleFonts.poppins(
//                   fontSize: 22.sp,
//                   fontWeight: FontWeight.w800,
//                   color: FeeColors.primaryOrange,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ).animate(delay: 600.ms).fadeIn().slideY(begin: 0.2, end: 0);
//   }
  
//   List<Widget> _buildFeeBreakdownItems() {
//     final items = [
//       {'title': 'Tuition Fee', 'amount': '₹4,000'},
//       {'title': 'Library Fee', 'amount': '₹500'},
//       {'title': 'Sports Fee', 'amount': '₹300'},
//       {'title': 'Lab Fee', 'amount': '₹200'},
//     ];
    
//     return items
//         .asMap()
//         .entries
//         .map((entry) => Padding(
//           padding: EdgeInsets.only(bottom: 16.h),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 entry.value['title']!,
//                 style: GoogleFonts.poppins(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w500,
//                   color: FeeColors.darkText,
//                 ),
//               ),
//               Text(
//                 entry.value['amount']!,
//                 style: GoogleFonts.poppins(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w600,
//                   color: FeeColors.darkText,
//                 ),
//               ),
//             ],
//           ),
//         )).toList();
//   }

//   Widget _buildPaymentHistory(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Payment History',
//           style: FeeTypography.headlineMedium(context),
//         ).animate(delay: 800.ms).fadeIn(),
//         SizedBox(height: 16.h),
        
//         Container(
//           padding: EdgeInsets.all(16.w),
//           decoration: BoxDecoration(
//             color: FeeColors.paidColor.withOpacity(0.05),
//             borderRadius: BorderRadius.circular(16.r),
//             border: Border.all(
//               color: FeeColors.paidColor.withOpacity(0.2),
//               width: 1.w,
//             ),
//           ),
//           child: Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(12.w),
//                 decoration: BoxDecoration(
//                   color: FeeColors.paidColor.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(LucideIcons.checkCircle, 
//                   color: FeeColors.paidColor, 
//                   size: 24.sp
//                 ),
//               ),
//               SizedBox(width: 16.w),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Payment Successful',
//                       style: GoogleFonts.poppins(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w600,
//                         color: FeeColors.darkText,
//                       ),
//                     ),
//                     SizedBox(height: 4.h),
//                     Text(
//                       'Paid on Dec 5, 2024 • Transaction ID: TXN789012',
//                       style: GoogleFonts.poppins(
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.w400,
//                         color: FeeColors.lightText,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     '₹5,000',
//                     style: GoogleFonts.poppins(
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.w700,
//                       color: FeeColors.paidColor,
//                     ),
//                   ),
//                   SizedBox(height: 4.h),
//                   Text(
//                     'Online',
//                     style: GoogleFonts.poppins(
//                       fontSize: 11.sp,
//                       fontWeight: FontWeight.w500,
//                       color: FeeColors.lightText,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ).animate(delay: 900.ms).fadeIn().slideX(begin: 0.1),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:qr_code_scanner/components/test_constants.dart';
import 'package:qr_code_scanner/core/constants/app_colors.dart';
import 'package:qr_code_scanner/core/constants/fee_colors.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/fee_controller.dart';
import 'package:qr_code_scanner/presentation/views/fee/fee_home_screen.dart';

class MonthlyFeeScreen extends StatelessWidget {
  MonthlyFeeScreen({super.key});

  // final FeeController controller = Get.put(FeeController());
  final FeesController feeController = Get.find<FeesController>();
  final RxString selectedMonth = 'December 2024'.obs;

  final List<String> months = ['Oct', 'Nov', 'Dec', 'Jan', 'Feb'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FeeColors.backgroundWhite,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              FeeColors.backgroundWhite,
              FeeColors.warmWhite,
              FeeColors.lightOrangeTint,
            ],
          ),
        ),
        child: Stack(
          children: [
            _buildBackgroundElements(),
            SafeArea(
              child: Column(
                children: [
                  _buildTopHeader(context),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 24.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMonthSelector(),
                          SizedBox(height: 20.h),
                          _buildStatusCard(context),
                          SizedBox(height: 22.h),
                          _buildRecordDetails(context),
                          // SizedBox(height: 22.h),
                          // _buildTimeline(context),
                          SizedBox(height: 22.h),
                          _buildNotesCard(context),
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
          top: -70.h,
          right: -50.w,
          child: Container(
            width: 180.w,
            height: 180.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: FeeColors.primaryOrange.withOpacity(0.08),
            ),
          ),
        ),
        Positioned(
          bottom: 120.h,
          left: -55.w,
          child: Container(
            width: 130.w,
            height: 130.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: FeeColors.pendingColor.withOpacity(0.07),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 10.h, 14.w, 6.h),
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
              'Monthly Record',
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
              LucideIcons.fileText,
              color: FeeColors.primaryOrange,
              size: 21.sp,
            ),
          ),
        ],
      ),
    );
  }

//   Widget _buildMonthSelector() {
//   return SizedBox(
//     height: 48.h,
//     child: ListView.separated(
//       scrollDirection: Axis.horizontal,
//       itemCount: months.length,
//       separatorBuilder: (_, __) => SizedBox(width: 10.w),
//       itemBuilder: (context, index) {
//         final month = months[index];

//         return Obx(() {
//           final isSelected =
//               selectedMonth.value.startsWith(month);

//           return GestureDetector(
//             onTap: () => selectedMonth.value = '$month 2024',
//             child: AnimatedContainer(
//               duration: 250.ms,
//               padding: EdgeInsets.symmetric(horizontal: 20.w),

//               // ✅ UPDATED COLORS
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16.r),
//                 border: Border.all(
//                   color: isSelected
//                       ? FeeColors.primaryOrange
//                       : FeeColors.primaryOrange.withOpacity(0.12),
//                   width: isSelected ? 1.5 : 1,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.04),
//                     blurRadius: 10,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),

//               child: Center(
//                 child: Text(
//                   month,
//                   style: GoogleFonts.poppins(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w800,

//                     // ✅ BLACK TEXT
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             )
//                 .animate(delay: (index * 70).ms)
//                 .fadeIn()
//                 .slideX(begin: 0.08),
//           );
//         });
//       },
//     ),
//   );
// }
// Widget _buildMonthSelector() {
//   const months = [
//     'January', 'February', 'March', 'April',
//     'May', 'June', 'July', 'August',
//     'September', 'October', 'November', 'December',
//   ];

//   return SizedBox(
//     height: 48.h,
//     child: Obx(() => ListView.separated(
//           scrollDirection: Axis.horizontal,
//           itemCount: months.length,
//           separatorBuilder: (_, __) => SizedBox(width: 10.w),
//           itemBuilder: (context, index) {
//             final monthNumber = index + 1;
//             final isSelected =
//                 feeController.selectedMonth.value == monthNumber;

//             return GestureDetector(
//               onTap: () => feeController.changeSelectedMonth(monthNumber),
//               child: AnimatedContainer(
//                 duration: 250.ms,
//                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16.r),
//                   border: Border.all(
//                     color: isSelected
//                         ? FeeColors.primaryOrange
//                         : FeeColors.primaryOrange.withOpacity(0.12),
//                     width: isSelected ? 1.8 : 1,
//                   ),
//                 ),
//                 child: Center(
//                   child: Text(
//                     months[index],
//                     style: GoogleFonts.poppins(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w800,
//                       color: isSelected
//                           ? FeeColors.primaryOrange
//                           : Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         )),
//   );
// }



Widget _buildMonthSelector() {
  const allMonths = [
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

  final joiningMonth =
      feeController.studentStartMonth.month;

  final visibleMonths =
      allMonths.sublist(joiningMonth - 1);

  return SizedBox(
    height: 48.h,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: visibleMonths.length,
      separatorBuilder: (_, __) =>
          SizedBox(width: 10.w),
      itemBuilder: (context, index) {

        final monthNumber =
            joiningMonth + index;

        return Obx(() {

          final isSelected =
              feeController.selectedMonth.value ==
                  monthNumber;

          return GestureDetector(
            onTap: () => feeController
                .changeSelectedMonth(monthNumber),

            child: AnimatedContainer(
              duration: 250.ms,
              padding:
                  EdgeInsets.symmetric(horizontal: 20.w),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(16.r),

                border: Border.all(
                  color: isSelected
                      ? FeeColors.primaryOrange
                      : FeeColors.primaryOrange
                          .withOpacity(0.12),

                  width: isSelected ? 1.8 : 1,
                ),
              ),

              child: Center(
                child: Text(
                  visibleMonths[index],

                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,

                    color: isSelected
                        ? FeeColors.primaryOrange
                        : Colors.black,
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
// Widget _buildMonthSelector() {
//   const months = [
//     'January', 'February', 'March', 'April',
//     'May', 'June', 'July', 'August',
//     'September', 'October', 'November', 'December',
//   ];

//   return SizedBox(
//     height: 48.h,
//     child: ListView.separated(
//       scrollDirection: Axis.horizontal,
//       itemCount: months.length,
//       separatorBuilder: (_, __) => SizedBox(width: 10.w),
//       itemBuilder: (context, index) {
//         final monthNumber = index + 1;
// //         final isDisabled = feeController.isBeforeStudentJoinMonth(
// //   feeController.selectedYear.value,
// //   monthNumber,
// // );
// final isDisabled = feeController.isBeforeStudentJoinMonth(
//   feeController.selectedYear.value,
//   monthNumber,
// );

//         return Obx(() {
//           final isSelected =
//               feeController.selectedMonth.value == monthNumber;

//           return 
//           GestureDetector(
//             // onTap: () => feeController.changeSelectedMonth(monthNumber),
// onTap: isDisabled
//     ? null
//     : () => feeController.changeSelectedMonth(monthNumber),
//             child: AnimatedContainer(
//               duration: 250.ms,
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16.r),
//                 border: Border.all(
//                   // color: isSelected
//                   //     ? FeeColors.primaryOrange
//                   //     : FeeColors.primaryOrange.withOpacity(0.12),
// color: isDisabled
//     ? Colors.grey
//     : isSelected
//         ? FeeColors.primaryOrange
//         : Colors.black,
                  
//                   width: isSelected ? 1.8 : 1,
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   months[index],
//                   style: GoogleFonts.poppins(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w800,
//                     color: isSelected
//                         ? FeeColors.primaryOrange
//                         : Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         });
//       },
//     ),
//   );
// }

//   Widget _buildStatusCard(BuildContext context) {
//     return Obx(
//       () => Container(
//         width: double.infinity,
//         padding: EdgeInsets.all(22.w),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(28.r),
//        gradient: LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: [
//     Colors.white,
//     const Color(0xffFFF8F3),
//   ],
// ),
//           boxShadow: [
//             BoxShadow(
//               color: FeeColors.darkText.withOpacity(0.18),
//               blurRadius: 24,
//               offset: const Offset(0, 12),
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             Positioned(
//               right: -28.w,
//               top: -28.h,
//               child: Container(
//                 width: 115.w,
//                 height: 115.w,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: FeeColors.primaryOrange.withOpacity(0.16),
//                 ),
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(12.w),
//                   decoration: BoxDecoration(
//                     color: FeeColors.paidColor.withOpacity(0.14),
//                     borderRadius: BorderRadius.circular(16.r),
//                   ),
//                   child: Icon(
//                     LucideIcons.badgeCheck,
//                     color: FeeColors.paidColor,
//                     size: 28.sp,
//                   ),
//                 ),
//                 SizedBox(height: 16.h),
//                 Text(
//                   selectedMonth.value,
//                   style: GoogleFonts.poppins(
//                     fontSize: 22.sp,
//                     fontWeight: FontWeight.w800,
//                     color: FeeColors.darkText,
//                   ),
//                 ),
//                 SizedBox(height: 5.h),
//                 Text(
//                   'Fee record has been verified successfully',
//                   style: GoogleFonts.poppins(
//                     fontSize: 12.sp,
//                     color: FeeColors.darkText.withOpacity(0.66),
//                   ),
//                 ),
//                 SizedBox(height: 20.h),
//                 Row(
//                   children: [
//                     _miniInfo(
//                       icon: LucideIcons.checkCircle2,
//                       title: 'Status',
//                       value: 'Paid',
//                     ),
//                     SizedBox(width: 10.w),
//                     _miniInfo(
//                       icon: LucideIcons.calendarCheck,
//                       title: 'Paid On',
//                       value: 'Dec 5',
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ).animate(delay: 180.ms).fadeIn().slideY(begin: 0.16),
//     );
//   }
Widget _buildStatusCard(BuildContext context) {
  return Obx(() {
    final monthKey = feeController.selectedMonthKey;
    final fee = feeController.selectedFee;

    final isPaid = fee?.status.toLowerCase() == 'paid';

    final statusText = isPaid ? 'Paid' : 'Unpaid';
    final statusColor =
        isPaid ? FeeColors.paidColor : FeeColors.overdueColor;

    final statusIcon =
        isPaid ? LucideIcons.badgeCheck : LucideIcons.alertCircle;

    final paidDateText = isPaid && fee?.paidAt != null
        ? AppDateUtils.formatDate(fee!.paidAt!)
        : 'Not Paid Yet';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Color(0xffFFF8F3),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: FeeColors.darkText.withOpacity(0.18),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -28.w,
            top: -28.h,
            child: Container(
              width: 115.w,
              height: 115.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: statusColor.withOpacity(0.16),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(
                  statusIcon,
                  color: statusColor,
                  size: 28.sp,
                ),
              ),

              SizedBox(height: 16.h),

              Text(
                feeController.formatMonth(monthKey),
                style: GoogleFonts.poppins(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: FeeColors.darkText,
                ),
              ),

              SizedBox(height: 5.h),

              Text(
                isPaid
                    ? 'Fee record has been verified successfully'
                    : 'Fee record is not marked paid yet',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: FeeColors.darkText.withOpacity(0.66),
                ),
              ),

              SizedBox(height: 20.h),

              Row(
                children: [
                  _miniInfo(
                    icon: isPaid
                        ? LucideIcons.checkCircle2
                        : LucideIcons.alertCircle,
                    title: 'Status',
                    value: statusText,
                  ),

                  SizedBox(width: 10.w),

                  _miniInfo(
                    icon: isPaid
                        ? LucideIcons.calendarCheck
                        : LucideIcons.calendarClock,
                    title: isPaid ? 'Paid On' : 'Due Date',
                    value: isPaid
                        ? paidDateText
                        : AppDateUtils.formatDate(
                            DateTime(
                              feeController.selectedYear.value,
                              feeController.selectedMonth.value,
                              10,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ).animate(delay: 180.ms).fadeIn().slideY(begin: 0.16);
  });
}


  Widget _miniInfo({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(13.w),
        decoration: BoxDecoration(
          color: FeeColors.darkText.withOpacity(0.08),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: FeeColors.darkText.withOpacity(0.08)),
        ),
        child: Row(
          children: [
            Icon(icon, color: FeeColors.darkText, size: 19.sp),
            SizedBox(width: 9.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      // color: Colors.white.withOpacity(0.6),
                      color: FeeColors.darkText
                    ),
                  ),
                  Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w800,
                      color: FeeColors.darkText
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



Widget _buildRecordDetails(BuildContext context) {
  return Obx(() {
    final monthKey = feeController.selectedMonthKey;
    final fee = feeController.selectedFee;
    final student = feeController.currentStudent;

    final isPaid = fee?.status.toLowerCase() == 'paid';

    final dueDate = DateTime(
      feeController.selectedYear.value,
      feeController.selectedMonth.value,
      10,
    );

    final paidDateText = isPaid && fee?.paidAt != null
        ? AppDateUtils.formatDate(fee!.paidAt!)
        : 'Not Paid Yet';

    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            title: 'Record Details',
            subtitle: feeController.formatMonth(monthKey),
          ),

          SizedBox(height: 16.h),

          _detailTile(
            icon: LucideIcons.calendarClock,
            title: 'Due Date',
            value: AppDateUtils.formatDate(dueDate),
            color: FeeColors.upcomingColor,
          ),

          SizedBox(height: 12.h),

          _detailTile(
            icon: isPaid
                ? LucideIcons.calendarCheck
                : LucideIcons.alertCircle,
            title: isPaid ? 'Paid Date' : 'Payment Status',
            value: paidDateText,
            color: isPaid
                ? FeeColors.paidColor
                : FeeColors.overdueColor,
          ),

          SizedBox(height: 12.h),

          _detailTile(
            icon: LucideIcons.graduationCap,
            title: 'Class',
            value: 'Class ${student?.grade ?? '--'}',
            color: FeeColors.primaryOrange,
          ),

          // SizedBox(height: 12.h),

          // _detailTile(
          //   icon: isPaid
          //       ? LucideIcons.userCheck
          //       : LucideIcons.userX,
          //   title: 'Student Record',
          //   value: isPaid ? 'Verified Student' : 'Pending Verification',
          //   color: isPaid
          //       ? FeeColors.paidColor
          //       : FeeColors.overdueColor,
          // ),
        ],
      ),
    ).animate(delay: 320.ms).fadeIn().slideY(begin: 0.13);
  });
}
  // Widget _buildRecordDetails(BuildContext context) {
  //   return Container(
  //     padding: EdgeInsets.all(18.w),
  //     decoration: _cardDecoration(),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         _sectionHeader(
  //           title: 'Record Details',
  //           subtitle: 'Monthly fee status information',
  //         ),
  //         SizedBox(height: 16.h),
  //         _detailTile(
  //           icon: LucideIcons.calendarClock,
  //           title: 'Due Date',
  //           value: 'Dec 10, 2024',
  //           color: FeeColors.upcomingColor,
  //         ),
  //         SizedBox(height: 12.h),
  //         _detailTile(
  //           icon: LucideIcons.calendarCheck,
  //           title: 'Paid Date',
  //           value: 'Dec 5, 2024',
  //           color: FeeColors.paidColor,
  //         ),
  //         SizedBox(height: 12.h),
  //         _detailTile(
  //           icon: LucideIcons.graduationCap,
  //           title: 'Class',
  //           value: 'Class 10',
  //           color: FeeColors.primaryOrange,
  //         ),
  //         SizedBox(height: 12.h),
  //         _detailTile(
  //           icon: LucideIcons.userCheck,
  //           title: 'Student Record',
  //           value: 'Verified Student',
  //           color: FeeColors.paidColor,
  //         ),
  //       ],
  //     ),
  //   ).animate(delay: 320.ms).fadeIn().slideY(begin: 0.13);
  // }

  Widget _detailTile({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(icon, color: color, size: 21.sp),
          ),
          SizedBox(width: 13.w),
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
                SizedBox(height: 2.h),
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
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

  // Widget _buildTimeline(BuildContext context) {
  //   final items = [
  //     {
  //       'title': 'Record Created',
  //       'subtitle': 'Monthly fee record was generated',
  //       'icon': LucideIcons.filePlus,
  //       'color': FeeColors.primaryOrange,
  //     },
  //     {
  //       'title': 'Status Updated',
  //       'subtitle': 'Payment marked as paid',
  //       'icon': LucideIcons.refreshCcw,
  //       'color': FeeColors.upcomingColor,
  //     },
  //     {
  //       'title': 'Record Verified',
  //       'subtitle': 'Final verification completed',
  //       'icon': LucideIcons.shieldCheck,
  //       'color': FeeColors.paidColor,
  //     },
  //   ];

  //   return Container(
  //     padding: EdgeInsets.all(18.w),
  //     decoration: _cardDecoration(),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         _sectionHeader(
  //           title: 'Monthly Timeline',
  //           subtitle: 'Activity flow for this month',
  //         ),
  //         SizedBox(height: 18.h),
  //         ...List.generate(items.length, (index) {
  //           final item = items[index];
  //           final color = item['color'] as Color;

  //           return Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Column(
  //                 children: [
  //                   Container(
  //                     width: 38.w,
  //                     height: 38.w,
  //                     decoration: BoxDecoration(
  //                       color: color.withOpacity(0.12),
  //                       shape: BoxShape.circle,
  //                     ),
  //                     child: Icon(
  //                       item['icon'] as IconData,
  //                       color: color,
  //                       size: 19.sp,
  //                     ),
  //                   ),
  //                   if (index != items.length - 1)
  //                     Container(
  //                       width: 2.w,
  //                       height: 34.h,
  //                       color: color.withOpacity(0.16),
  //                     ),
  //                 ],
  //               ),
  //               SizedBox(width: 13.w),
  //               Expanded(
  //                 child: Padding(
  //                   padding: EdgeInsets.only(top: 2.h),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         item['title'] as String,
  //                         style: GoogleFonts.poppins(
  //                           fontSize: 14.sp,
  //                           fontWeight: FontWeight.w800,
  //                           color: FeeColors.darkText,
  //                         ),
  //                       ),
  //                       SizedBox(height: 2.h),
  //                       Text(
  //                         item['subtitle'] as String,
  //                         style: GoogleFonts.poppins(
  //                           fontSize: 11.sp,
  //                           color: FeeColors.lightText,
  //                         ),
  //                       ),
  //                       if (index != items.length - 1) SizedBox(height: 18.h),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           );
  //         }),
  //       ],
  //     ),
  //   ).animate(delay: 460.ms).fadeIn().slideY(begin: 0.13);
  // }

  Widget _buildNotesCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: FeeColors.primaryOrange.withOpacity(0.08),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(
          color: FeeColors.primaryOrange.withOpacity(0.14),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(11.w),
            decoration: BoxDecoration(
              color: FeeColors.primaryOrange.withOpacity(0.12),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Icon(
              LucideIcons.info,
              color: FeeColors.primaryOrange,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 13.w),
          Expanded(
            child: Text(
              'This screen only shows monthly fee record status.',
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: FeeColors.darkText,
              ),
            ),
          ),
        ],
      ),
    ).animate(delay: 580.ms).fadeIn().slideY(begin: 0.1);
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

  BoxDecoration _cardDecoration() {
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