// // import 'package:get/get_core/src/get_main.dart';
// // import 'package:get/get_instance/src/extension_instance.dart';
// // import 'package:get/get_navigation/src/root/parse_route.dart';
// // import 'package:get/get_rx/src/rx_types/rx_types.dart';
// // import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// // import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/attendance_controller.dart';
// // import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/fee_controller.dart';
// // import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/test_result_controller.dart';

// // class DashboardStatsController extends GetxController {
// //   final attendanceController = Get.put(AttendanceController());
// //   final testResultController = Get.put(TestResultController());
// //   final feeController = Get.put(FeesController());
// //   final isLoading = true.obs;

// //   double get thisWeekAttendance {
// //     final now = DateTime.now();
// //     final startWeek = now.subtract(Duration(days: now.weekday - 1));

// //     final weekDays = attendanceController.attendanceDays.where((e) {
// //       return e.date.isAfter(startWeek.subtract(const Duration(days: 1))) &&
// //           e.date.isBefore(now.add(const Duration(days: 1))) &&
// //           (e.status == 'present' || e.status == 'absent');
// //     }).toList();

// //     if (weekDays.isEmpty) return 0;

// //     final present = weekDays.where((e) => e.status == 'present').length;
// //     return (present / weekDays.length) * 100;
// //   }

// //   double get lastWeekAttendance {
// //     final now = DateTime.now();

// //     final startThisWeek = now.subtract(Duration(days: now.weekday - 1));
// //     final startLastWeek = startThisWeek.subtract(const Duration(days: 7));
// //     final endLastWeek = startThisWeek.subtract(const Duration(days: 1));

// //     final weekDays = attendanceController.attendanceDays.where((e) {
// //       return e.date.isAfter(startLastWeek.subtract(const Duration(days: 1))) &&
// //           e.date.isBefore(endLastWeek.add(const Duration(days: 1))) &&
// //           (e.status == 'present' || e.status == 'absent');
// //     }).toList();

// //     if (weekDays.isEmpty) return 0;

// //     final present = weekDays.where((e) => e.status == 'present').length;
// //     return (present / weekDays.length) * 100;
// //   }

// //   String get attendanceChange {
// //     final diff = thisWeekAttendance - lastWeekAttendance;

// //     if (diff == 0) return '0%';
// //     if (diff > 0) return '+${diff.toStringAsFixed(0)}%';
// //     return '${diff.toStringAsFixed(0)}%';
// //   }

// //   double get thisWeekAvgScore {
// //     final now = DateTime.now();
// //     final startWeek = now.subtract(Duration(days: now.weekday - 1));

// //     final weekTests = testResultController.results.where((e) {
// //       return e.testDate.isAfter(startWeek.subtract(const Duration(days: 1))) &&
// //           e.testDate.isBefore(now.add(const Duration(days: 1)));
// //     }).toList();

// //     if (weekTests.isEmpty) return 0;

// //     final total = weekTests.fold<double>(
// //       0,
// //       (sum, item) => sum + item.percentage,
// //     );

// //     return total / weekTests.length;
// //   }

// //   double get lastWeekAvgScore {
// //     final now = DateTime.now();

// //     final startThisWeek = now.subtract(Duration(days: now.weekday - 1));
// //     final startLastWeek = startThisWeek.subtract(const Duration(days: 7));
// //     final endLastWeek = startThisWeek.subtract(const Duration(days: 1));

// //     final weekTests = testResultController.results.where((e) {
// //       return e.testDate.isAfter(startLastWeek.subtract(const Duration(days: 1))) &&
// //           e.testDate.isBefore(endLastWeek.add(const Duration(days: 1)));
// //     }).toList();

// //     if (weekTests.isEmpty) return 0;

// //     final total = weekTests.fold<double>(
// //       0,
// //       (sum, item) => sum + item.percentage,
// //     );

// //     return total / weekTests.length;
// //   }

// //   String get scoreChange {
// //     final diff = thisWeekAvgScore - lastWeekAvgScore;

// //     if (diff == 0) return '0%';
// //     if (diff > 0) return '+${diff.toStringAsFixed(0)}%';
// //     return '${diff.toStringAsFixed(0)}%';
// //   }

// //   String get currentFeeStatus {
// //     final now = DateTime.now();

// //     final monthKey =
// //         '${now.year}-${now.month.toString().padLeft(2, '0')}';

// //     final fee = feeController.fees.firstWhereOrNull(
// //       (e) => e.month == monthKey,
// //     );

// //     if (fee?.status == 'paid') return 'Paid';

// //     return 'Unpaid';
// //   }

// //   String get feeChangeText {
// //     final now = DateTime.now();

// //     final monthKey =
// //         '${now.year}-${now.month.toString().padLeft(2, '0')}';

// //     final fee = feeController.fees.firstWhereOrNull(
// //       (e) => e.month == monthKey,
// //     );

// //     if (fee?.status != 'paid') return 'Pending';

// //     final paidAt = fee?.paidAt;

// //     if (paidAt == null) return 'Paid';

// //     if (paidAt.day <= 10) return 'On Time';

// //     return 'Late';
// //   }

// //   int get thisWeekRank {
// //     final now = DateTime.now();
// //     final startWeek = now.subtract(Duration(days: now.weekday - 1));

// //     final weekTests = testResultController.results.where((e) {
// //       return e.testDate.isAfter(startWeek.subtract(const Duration(days: 1))) &&
// //           e.testDate.isBefore(now.add(const Duration(days: 1))) &&
// //           e.rank > 0;
// //     }).toList();

// //     if (weekTests.isEmpty) return 0;

// //     final totalRank = weekTests.fold<int>(
// //       0,
// //       (sum, item) => sum + item.rank,
// //     );

// //     return (totalRank / weekTests.length).round();
// //   }

// //   String get rankChangeText {
// //     return thisWeekRank == 0 ? '--' : '#$thisWeekRank';
// //   }
// // }


// import 'package:get/get.dart';
// import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/attendance_controller.dart';
// import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/fee_controller.dart';
// import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/test_result_controller.dart';

// class DashboardStatsController extends GetxController {
//   final attendanceController = Get.put(AttendanceController());
//   final testResultController = Get.put(TestResultController());
//   final feeController = Get.put(FeesController());

//   final isLoading = true.obs;

//   final thisWeekAttendanceValue = 0.0.obs;
//   final thisWeekAvgScoreValue = 0.0.obs;

//   final attendanceChangeValue = '0%'.obs;
//   final scoreChangeValue = '0%'.obs;

//   final currentFeeStatusValue = 'Unpaid'.obs;
//   final feeChangeTextValue = 'Pending'.obs;
//   final rankChangeTextValue = '--'.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadDashboardStats();
//   }

//   Future<void> loadDashboardStats() async {
//     try {
//       isLoading.value = true;

//       await Future.delayed(const Duration(milliseconds: 500));

//       int counter = 0;

//       while (
//         attendanceController.attendanceDays.isEmpty &&
//         testResultController.results.isEmpty &&
//         feeController.fees.isEmpty &&
//         counter < 50
//       ) {
//         await Future.delayed(const Duration(milliseconds: 100));
//         counter++;
//       }

//       calculateStats();
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void calculateStats() {
//     thisWeekAttendanceValue.value = thisWeekAttendance;
//     thisWeekAvgScoreValue.value = thisWeekAvgScore;

//     attendanceChangeValue.value = attendanceChange;
//     scoreChangeValue.value = scoreChange;

//     currentFeeStatusValue.value = currentFeeStatus;
//     feeChangeTextValue.value = feeChangeText;
//     rankChangeTextValue.value = rankChangeText;
//   }

//   double get thisWeekAttendance {
//     final now = DateTime.now();
//     final startWeek = now.subtract(Duration(days: now.weekday - 1));

//     final weekDays = attendanceController.attendanceDays.where((e) {
//       return e.date.isAfter(startWeek.subtract(const Duration(days: 1))) &&
//           e.date.isBefore(now.add(const Duration(days: 1))) &&
//           (e.status == 'present' || e.status == 'absent');
//     }).toList();

//     if (weekDays.isEmpty) return 0;

//     final present = weekDays.where((e) => e.status == 'present').length;

//     return (present / weekDays.length) * 100;
//   }

//   double get lastWeekAttendance {
//     final now = DateTime.now();

//     final startThisWeek = now.subtract(Duration(days: now.weekday - 1));
//     final startLastWeek = startThisWeek.subtract(const Duration(days: 7));
//     final endLastWeek = startThisWeek.subtract(const Duration(days: 1));

//     final weekDays = attendanceController.attendanceDays.where((e) {
//       return e.date.isAfter(startLastWeek.subtract(const Duration(days: 1))) &&
//           e.date.isBefore(endLastWeek.add(const Duration(days: 1))) &&
//           (e.status == 'present' || e.status == 'absent');
//     }).toList();

//     if (weekDays.isEmpty) return 0;

//     final present = weekDays.where((e) => e.status == 'present').length;

//     return (present / weekDays.length) * 100;
//   }

//   String get attendanceChange {
//     final diff = thisWeekAttendance - lastWeekAttendance;

//     if (diff == 0) return '0%';
//     if (diff > 0) return '+${diff.toStringAsFixed(0)}%';

//     return '${diff.toStringAsFixed(0)}%';
//   }

//   double get thisWeekAvgScore {
//     final now = DateTime.now();
//     final startWeek = now.subtract(Duration(days: now.weekday - 1));

//     final weekTests = testResultController.results.where((e) {
//       return e.testDate.isAfter(startWeek.subtract(const Duration(days: 1))) &&
//           e.testDate.isBefore(now.add(const Duration(days: 1)));
//     }).toList();

//     if (weekTests.isEmpty) return 0;

//     final total = weekTests.fold<double>(
//       0,
//       (sum, item) => sum + item.percentage,
//     );

//     return total / weekTests.length;
//   }

//   double get lastWeekAvgScore {
//     final now = DateTime.now();

//     final startThisWeek = now.subtract(Duration(days: now.weekday - 1));
//     final startLastWeek = startThisWeek.subtract(const Duration(days: 7));
//     final endLastWeek = startThisWeek.subtract(const Duration(days: 1));

//     final weekTests = testResultController.results.where((e) {
//       return e.testDate
//               .isAfter(startLastWeek.subtract(const Duration(days: 1))) &&
//           e.testDate.isBefore(endLastWeek.add(const Duration(days: 1)));
//     }).toList();

//     if (weekTests.isEmpty) return 0;

//     final total = weekTests.fold<double>(
//       0,
//       (sum, item) => sum + item.percentage,
//     );

//     return total / weekTests.length;
//   }

//   String get scoreChange {
//     final diff = thisWeekAvgScore - lastWeekAvgScore;

//     if (diff == 0) return '0%';
//     if (diff > 0) return '+${diff.toStringAsFixed(0)}%';

//     return '${diff.toStringAsFixed(0)}%';
//   }

//   String get currentFeeStatus {
//     final now = DateTime.now();

//     final monthKey =
//         '${now.year}-${now.month.toString().padLeft(2, '0')}';

//     final fee = feeController.fees.firstWhereOrNull(
//       (e) => e.month == monthKey,
//     );

//     if (fee?.status == 'paid') return 'Paid';

//     return 'Unpaid';
//   }

//   String get feeChangeText {
//     final now = DateTime.now();

//     final monthKey =
//         '${now.year}-${now.month.toString().padLeft(2, '0')}';

//     final fee = feeController.fees.firstWhereOrNull(
//       (e) => e.month == monthKey,
//     );

//     if (fee?.status != 'paid') return 'Pending';

//     final paidAt = fee?.paidAt;

//     if (paidAt == null) return 'Paid';

//     if (paidAt.day <= 10) return 'On Time';

//     return 'Late';
//   }

//   int get thisWeekRank {
//     final now = DateTime.now();
//     final startWeek = now.subtract(Duration(days: now.weekday - 1));

//     final weekTests = testResultController.results.where((e) {
//       return e.testDate.isAfter(startWeek.subtract(const Duration(days: 1))) &&
//           e.testDate.isBefore(now.add(const Duration(days: 1))) &&
//           e.rank > 0;
//     }).toList();

//     if (weekTests.isEmpty) return 0;

//     final totalRank = weekTests.fold<int>(
//       0,
//       (sum, item) => sum + item.rank,
//     );

//     return (totalRank / weekTests.length).round();
//   }

//   String get rankChangeText {
//     return thisWeekRank == 0 ? '--' : '#$thisWeekRank';
//   }
// }


import 'package:get/get.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/attendance_controller.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/fee_controller.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/test_result_controller.dart';

class DashboardStatsController extends GetxController {
  final attendanceController = Get.put(AttendanceController());
  final testResultController = Get.put(TestResultController());
  final feeController = Get.put(FeesController());

  final isLoading = true.obs;

  final thisWeekAttendanceValue = 0.0.obs;
  final thisWeekAvgScoreValue = 0.0.obs;

  final attendanceChangeValue = '0%'.obs;
  final scoreChangeValue = '0%'.obs;

  final currentFeeStatusValue = 'Unpaid'.obs;
  final feeChangeTextValue = 'Pending'.obs;
  final rankChangeTextValue = '--'.obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardStats();
  }

  // Future<void> loadDashboardStats() async {
  //   try {
  //     isLoading.value = true;

  //     await Future.delayed(const Duration(milliseconds: 500));

  //     int counter = 0;

  //     while (
  //       attendanceController.attendanceDays.isEmpty &&
  //       testResultController.results.isEmpty &&
  //       feeController.fees.isEmpty &&
  //       counter < 50
  //     ) {
  //       await Future.delayed(const Duration(milliseconds: 100));
  //       counter++;
  //     }

  //     calculateStats();
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

Future<void> loadDashboardStats() async {
  try {
    isLoading.value = true;

    while (attendanceController.isLoading.value ||
        testResultController.isLoading.value ||
        feeController.isLoading.value) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    calculateStats();
  } finally {
    isLoading.value = false;
  }
}

  void calculateStats() {
    thisWeekAttendanceValue.value = thisWeekAttendance;
    thisWeekAvgScoreValue.value = thisWeekAvgScore;

    attendanceChangeValue.value = attendanceChange;
    scoreChangeValue.value = scoreChange;

    currentFeeStatusValue.value = currentFeeStatus;
    feeChangeTextValue.value = feeChangeText;
    rankChangeTextValue.value = rankChangeText;
  }

  DateTime get startThisWeek {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: now.weekday - 1));
  }

  DateTime get endThisWeek {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 23, 59, 59);
  }

  DateTime get startLastWeek {
    return startThisWeek.subtract(const Duration(days: 7));
  }

  DateTime get endLastWeek {
    return startThisWeek.subtract(const Duration(seconds: 1));
  }

  // double get thisWeekAttendance {
  //   final weekDays = attendanceController.attendanceDays.where((e) {
  //     return e.date.isAfter(startThisWeek.subtract(const Duration(seconds: 1))) &&
  //         e.date.isBefore(endThisWeek.add(const Duration(seconds: 1))) &&
  //         (e.status == 'present' || e.status == 'absent');
  //   }).toList();

  //   if (weekDays.isEmpty) return 0;

  //   final present = weekDays.where((e) => e.status == 'present').length;

  //   return (present / weekDays.length) * 100;
  // }

  // double get lastWeekAttendance {
  //   final weekDays = attendanceController.attendanceDays.where((e) {
  //     return e.date.isAfter(startLastWeek.subtract(const Duration(seconds: 1))) &&
  //         e.date.isBefore(endLastWeek.add(const Duration(seconds: 1))) &&
  //         (e.status == 'present' || e.status == 'absent');
  //   }).toList();

  //   if (weekDays.isEmpty) return 0;

  //   final present = weekDays.where((e) => e.status == 'present').length;

  //   return (present / weekDays.length) * 100;
  // }

  // String get attendanceChange {
  //   final diff = thisWeekAttendance - lastWeekAttendance;

  //   if (diff == 0) return '0%';
  //   if (diff > 0) return '+${diff.toStringAsFixed(0)}%';

  //   return '${diff.toStringAsFixed(0)}%';
  // }

double get thisWeekAttendance {
  final weekDays = attendanceController.attendanceDays.where((e) {
    return e.date.isAfter(
          startThisWeek.subtract(const Duration(seconds: 1)),
        ) &&
        e.date.isBefore(
          endThisWeek.add(const Duration(seconds: 1)),
        ) &&
        (e.status == 'present' || e.status == 'absent');
  }).toList();

  if (weekDays.isEmpty) return 0;

  final present = weekDays.where((e) => e.status == 'present').length;

  return (present / weekDays.length) * 100;
}

double get lastWeekAttendance {
  final weekDays = attendanceController.attendanceDays.where((e) {
    return e.date.isAfter(
          startLastWeek.subtract(const Duration(seconds: 1)),
        ) &&
        e.date.isBefore(
          endLastWeek.add(const Duration(seconds: 1)),
        ) &&
        (e.status == 'present' || e.status == 'absent');
  }).toList();

  if (weekDays.isEmpty) return 0;

  final present = weekDays.where((e) => e.status == 'present').length;

  return (present / weekDays.length) * 100;
}

String get attendanceChange {
  final diff = thisWeekAttendance - lastWeekAttendance;

  if (diff == 0) return '0%';
  if (diff > 0) return '+${diff.toStringAsFixed(0)}%';

  return '${diff.toStringAsFixed(0)}%';
}

  /// CURRENT WEEK AVG SCORE
  /// Example:
  /// 1 week me 3 tests: 60%, 70%, 80%
  /// Avg = 70%
  double get thisWeekAvgScore {
    final weekTests = testResultController.results.where((e) {
      return e.testDate.isAfter(startThisWeek.subtract(const Duration(seconds: 1))) &&
          e.testDate.isBefore(endThisWeek.add(const Duration(seconds: 1)));
    }).toList();

    if (weekTests.isEmpty) return 0;

    final totalPercentage = weekTests.fold<double>(
      0,
      (sum, item) => sum + item.percentage,
    );

    return totalPercentage / weekTests.length;
  }

  /// LAST WEEK AVG SCORE
  double get lastWeekAvgScore {
    final weekTests = testResultController.results.where((e) {
      return e.testDate.isAfter(startLastWeek.subtract(const Duration(seconds: 1))) &&
          e.testDate.isBefore(endLastWeek.add(const Duration(seconds: 1)));
    }).toList();

    if (weekTests.isEmpty) return 0;

    final totalPercentage = weekTests.fold<double>(
      0,
      (sum, item) => sum + item.percentage,
    );

    return totalPercentage / weekTests.length;
  }

  /// SHOW CHANGE:
  /// Last week 68%, this week 78% => +10%
  String get scoreChange {
    final diff = thisWeekAvgScore - lastWeekAvgScore;

    if (diff == 0) return '0%';
    if (diff > 0) return '+${diff.toStringAsFixed(0)}%';

    return '${diff.toStringAsFixed(0)}%';
  }

  String get currentFeeStatus {
    final now = DateTime.now();

    final monthKey =
        '${now.year}-${now.month.toString().padLeft(2, '0')}';

    final fee = feeController.fees.firstWhereOrNull(
      (e) => e.month == monthKey,
    );

    if (fee?.status == 'paid') return 'Paid';

    return 'Unpaid';
  }

  String get feeChangeText {
    final now = DateTime.now();

    final monthKey =
        '${now.year}-${now.month.toString().padLeft(2, '0')}';

    final fee = feeController.fees.firstWhereOrNull(
      (e) => e.month == monthKey,
    );

    if (fee?.status != 'paid') return 'Pending';

    final paidAt = fee?.paidAt;

    if (paidAt == null) return 'Paid';

    if (paidAt.day <= 10) return 'On Time';

    return 'Late';
  }

  /// WEEKLY RANK
  /// Ye current week ke tests ke basis pe rank calculate karega.
  ///
  /// Important:
  /// testResultController.results me class ke sab students ka data hona chahiye.
  /// Aur har result model me studentId hona chahiye.
  /// 
  /// 


int get thisWeekRank {
  final weekTests = testResultController.results.where((e) {
    return e.testDate.isAfter(
          startThisWeek.subtract(const Duration(seconds: 1)),
        ) &&
        e.testDate.isBefore(
          endThisWeek.add(const Duration(seconds: 1)),
        ) &&
        e.rank > 0;
  }).toList();

  if (weekTests.isEmpty) return 0;

  final totalRank = weekTests.fold<int>(
    0,
    (sum, item) => sum + item.rank,
  );

  return (totalRank / weekTests.length).round();
}

String get rankChangeText {
  return thisWeekRank == 0 ? '--' : '#$thisWeekRank';
}



//   int get thisWeekRank {
//     final weekTests = testResultController.results.where((e) {
//       return e.testDate.isAfter(startThisWeek.subtract(const Duration(seconds: 1))) &&
//           e.testDate.isBefore(endThisWeek.add(const Duration(seconds: 1)));
//     }).toList();

//     if (weekTests.isEmpty) return 0;

//     // final currentStudentId = testResultController.currentStudentId;
//     final currentRollNo =
//     testResultController.currentStudent?.rollNo.trim();

// if (currentRollNo == null || currentRollNo.isEmpty) return 0;

//     final Map<String, List<dynamic>> studentWiseTests = {};

//     for (final test in weekTests) {
//       // final studentId = test.rollNo;
//       final studentId = test.rollNo;

//       studentWiseTests.putIfAbsent(studentId, () => []);
//       studentWiseTests[studentId]!.add(test);
//     }

//     final List<Map<String, dynamic>> studentAverages = [];

//     studentWiseTests.forEach((studentId, tests) {
//       final total = tests.fold<double>(
//         0,
//         (sum, item) => sum + item.percentage,
//       );

//       final avg = total / tests.length;

//       studentAverages.add({
//         'studentId': studentId,
//         'avg': avg,
//       });
//     });

//     studentAverages.sort(
//       (a, b) => (b['avg'] as double).compareTo(a['avg'] as double),
//     );

//     final index = studentAverages.indexWhere(
//       (e) => e['studentId'] == currentStudentId,
//     );

//     if (index == -1) return 0;

//     return index + 1;
//   }

//   String get rankChangeText {
//     return thisWeekRank == 0 ? '--' : '#$thisWeekRank';
//   }
}