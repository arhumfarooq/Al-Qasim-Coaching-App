// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:qr_code_scanner/core/constants/attendance_Colors.dart';
// import 'package:lucide_icons/lucide_icons.dart';

// class YearSummaryChart extends StatelessWidget {
//   final int selectedYear;
//   final List<int> percentages;
//   final List<String> months;

//   const YearSummaryChart({
//     super.key,
//     required this.selectedYear,
//     this.percentages = const [88, 90, 89, 92, 91, 93, 95, 94, 96, 95, 97, 96],
//     this.months = const ['J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'],
//   });

//   @override
//   Widget build(BuildContext context) {
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
//           // Header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Year Overview - $selectedYear',
//                 style: AttendanceTypography.headlineMedium(context),
//               ),
//               Icon(LucideIcons.barChart3, color: AttendanceColors.primaryOrange),
//             ],
//           ),
//           SizedBox(height: 20.h),

//           // Bar Chart
//           SizedBox(
//             height: 150.h,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: months.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   width: 40.w,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         '${percentages[index]}%',
//                         style: GoogleFonts.poppins(
//                           fontSize: 10.sp,
//                           fontWeight: FontWeight.w500,
//                           color: AttendanceColors.lightText,
//                         ),
//                       ),
//                       SizedBox(height: 8.h),
//                       Container(
//                         height: (percentages[index] / 100 * 100).h,
//                         width: 20.w,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               AttendanceColors.primaryOrange,
//                               AttendanceColors.secondaryOrange,
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
//                         months[index],
//                         style: GoogleFonts.poppins(
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.w500,
//                           color: AttendanceColors.darkText,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           SizedBox(height: 20.h),

//           // Summary Stats
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: const [
//               YearStatItem(
//                 icon: LucideIcons.trendingUp,
//                 value: '94.5%',
//                 label: 'Average',
//               ),
//               YearStatItem(
//                 icon: LucideIcons.target,
//                 value: '97%',
//                 label: 'Highest',
//               ),
//               YearStatItem(
//                 icon: LucideIcons.trendingDown,
//                 value: '88%',
//                 label: 'Lowest',
//               ),
//             ],
//           ),
//         ],
//       ),
//     ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2, end: 0);
//   }
// }

// // Reusable year stat item
// class YearStatItem extends StatelessWidget {
//   final IconData icon;
//   final String value;
//   final String label;

//   const YearStatItem({
//     super.key,
//     required this.icon,
//     required this.value,
//     required this.label,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Icon(icon, color: AttendanceColors.primaryOrange, size: 20.sp),
//         SizedBox(height: 4.h),
//         Text(
//           value,
//           style: GoogleFonts.poppins(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w700,
//             color: AttendanceColors.darkText,
//           ),
//         ),
//         SizedBox(height: 2.h),
//         Text(
//           label,
//           style: GoogleFonts.poppins(
//             fontSize: 12.sp,
//             fontWeight: FontWeight.w500,
//             color: AttendanceColors.lightText,
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:qr_code_scanner/core/constants/attendance_Colors.dart';
import 'package:qr_code_scanner/data/models/datafetch/yearly_month_model.dart';

class YearSummaryChart extends StatelessWidget {
  final int selectedYear;
  final List<YearlyMonthModel> months;

  const YearSummaryChart({
    super.key,
    required this.selectedYear,
    required this.months,
  });

  bool _isFutureMonth(int month) {
    final now = DateTime.now();

    if (selectedYear > now.year) return true;
    if (selectedYear == now.year && month > now.month) return true;

    return false;
  }

  List<YearlyMonthModel> get _validMonths {
    return months.where((m) {
      return !_isFutureMonth(m.month) && m.hasData;
    }).toList();
  }

  double get averagePercentage {
    final valid = _validMonths;

    if (valid.isEmpty) return 0;

    final total = valid.fold<double>(
      0,
      (sum, item) => sum + item.percentage,
    );

    return total / valid.length;
  }

  double get highestPercentage {
    final valid = _validMonths;

    if (valid.isEmpty) return 0;

    valid.sort((a, b) => b.percentage.compareTo(a.percentage));
    return valid.first.percentage;
  }

  double get lowestPercentage {
    final valid = _validMonths;

    if (valid.isEmpty) return 0;

    valid.sort((a, b) => a.percentage.compareTo(b.percentage));
    return valid.first.percentage;
  }

  @override
  Widget build(BuildContext context) {
    const monthLetters = [
      'J', 'F', 'M', 'A', 'M', 'J',
      'J', 'A', 'S', 'O', 'N', 'D',
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
                'Year Overview - $selectedYear',
                style: AttendanceTypography.headlineMedium(context),
              ),
              Icon(
                LucideIcons.barChart3,
                color: AttendanceColors.primaryOrange,
              ),
            ],
          ),

          SizedBox(height: 20.h),

          SizedBox(
            height: 150.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: months.length,
              itemBuilder: (context, index) {
                final item = months[index];

                final isFuture = _isFutureMonth(item.month);
                final isDisabled = isFuture || !item.hasData;

                final percentage = item.percentage;

                return SizedBox(
                  width: 40.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        isDisabled
                            ? '--'
                            : '${percentage.toStringAsFixed(0)}%',
                        style: GoogleFonts.poppins(
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
                            ? 18.h
                            : (percentage / 100 * 100).h,
                        width: 20.w,
                        decoration: BoxDecoration(
                          color: isDisabled ? Colors.grey.shade300 : null,
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

                      Text(
                        monthLetters[index],
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: isDisabled
                              ? Colors.grey
                              : AttendanceColors.darkText,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 20.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              YearStatItem(
                icon: LucideIcons.trendingUp,
                value: '${averagePercentage.toStringAsFixed(1)}%',
                label: 'Average',
              ),
              YearStatItem(
                icon: LucideIcons.target,
                value: '${highestPercentage.toStringAsFixed(0)}%',
                label: 'Highest',
              ),
              YearStatItem(
                icon: LucideIcons.trendingDown,
                value: '${lowestPercentage.toStringAsFixed(0)}%',
                label: 'Lowest',
              ),
            ],
          ),
        ],
      ),
    ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2, end: 0);
  }
}

class YearStatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const YearStatItem({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AttendanceColors.primaryOrange, size: 20.sp),
        SizedBox(height: 4.h),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AttendanceColors.darkText,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AttendanceColors.lightText,
          ),
        ),
      ],
    );
  }
}