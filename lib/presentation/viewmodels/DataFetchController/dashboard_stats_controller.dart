import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/parse_route.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/attendance_controller.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/fee_controller.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/test_result_controller.dart';

class DashboardStatsController extends GetxController {
  final attendanceController = Get.put(AttendanceController());
  final testResultController = Get.put(TestResultController());
  final feeController = Get.put(FeesController());

  double get thisWeekAttendance {
    final now = DateTime.now();
    final startWeek = now.subtract(Duration(days: now.weekday - 1));

    final weekDays = attendanceController.attendanceDays.where((e) {
      return e.date.isAfter(startWeek.subtract(const Duration(days: 1))) &&
          e.date.isBefore(now.add(const Duration(days: 1))) &&
          (e.status == 'present' || e.status == 'absent');
    }).toList();

    if (weekDays.isEmpty) return 0;

    final present = weekDays.where((e) => e.status == 'present').length;
    return (present / weekDays.length) * 100;
  }

  double get lastWeekAttendance {
    final now = DateTime.now();

    final startThisWeek = now.subtract(Duration(days: now.weekday - 1));
    final startLastWeek = startThisWeek.subtract(const Duration(days: 7));
    final endLastWeek = startThisWeek.subtract(const Duration(days: 1));

    final weekDays = attendanceController.attendanceDays.where((e) {
      return e.date.isAfter(startLastWeek.subtract(const Duration(days: 1))) &&
          e.date.isBefore(endLastWeek.add(const Duration(days: 1))) &&
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

  double get thisWeekAvgScore {
    final now = DateTime.now();
    final startWeek = now.subtract(Duration(days: now.weekday - 1));

    final weekTests = testResultController.results.where((e) {
      return e.testDate.isAfter(startWeek.subtract(const Duration(days: 1))) &&
          e.testDate.isBefore(now.add(const Duration(days: 1)));
    }).toList();

    if (weekTests.isEmpty) return 0;

    final total = weekTests.fold<double>(
      0,
      (sum, item) => sum + item.percentage,
    );

    return total / weekTests.length;
  }

  double get lastWeekAvgScore {
    final now = DateTime.now();

    final startThisWeek = now.subtract(Duration(days: now.weekday - 1));
    final startLastWeek = startThisWeek.subtract(const Duration(days: 7));
    final endLastWeek = startThisWeek.subtract(const Duration(days: 1));

    final weekTests = testResultController.results.where((e) {
      return e.testDate.isAfter(startLastWeek.subtract(const Duration(days: 1))) &&
          e.testDate.isBefore(endLastWeek.add(const Duration(days: 1)));
    }).toList();

    if (weekTests.isEmpty) return 0;

    final total = weekTests.fold<double>(
      0,
      (sum, item) => sum + item.percentage,
    );

    return total / weekTests.length;
  }

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

  int get thisWeekRank {
    final now = DateTime.now();
    final startWeek = now.subtract(Duration(days: now.weekday - 1));

    final weekTests = testResultController.results.where((e) {
      return e.testDate.isAfter(startWeek.subtract(const Duration(days: 1))) &&
          e.testDate.isBefore(now.add(const Duration(days: 1))) &&
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
}