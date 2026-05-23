// // import 'package:get/get.dart';
// // import 'package:qr_code_scanner/data/models/datafetch/yearly_month_model.dart';
// // import 'package:qr_code_scanner/data/repositories/DataFetchRepo/attendance_repository.dart';
// // import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/student_controller.dart';

// // class YearlyAttendanceController extends GetxController {
// //   final AttendanceRepository _attendanceRepository = AttendanceRepository();

// //   final StudentController _studentController =
// //       Get.isRegistered<StudentController>()
// //           ? Get.find<StudentController>()
// //           : Get.put(StudentController());

// //   final isLoading = false.obs;
// //   final months = <YearlyMonthModel>[].obs;

// //   final selectedYear = DateTime.now().year.obs;

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchYearlyAttendance();
// //   }

// //   Future<void> fetchYearlyAttendance() async {
// //     try {
// //       isLoading.value = true;

// //       if (_studentController.student.value == null) {
// //         await _studentController.fetchStudent();
// //       }

// //       final student = _studentController.student.value;

// //       if (student == null) return;

// //       final list = <YearlyMonthModel>[];

// //       for (int month = 1; month <= 12; month++) {
// //         final records = await _attendanceRepository.getMonthlyAttendance(
// //           classId: student.grade.trim(),
// //           year: selectedYear.value,
// //           month: month,
// //           studentUid: student.uid.trim(),
// //         );

// //         int present = 0;
// //         int absent = 0;

// //         records.forEach((date, status) {
// //           if (status == 'present') present++;
// //           if (status == 'absent') absent++;
// //         });

// //         list.add(
// //           YearlyMonthModel(
// //             year: selectedYear.value,
// //             month: month,
// //             monthName: _monthName(month),
// //             present: present,
// //             absent: absent,
// //             holiday: 0,
// //             hasData: records.isNotEmpty,
// //           ),
// //         );
// //       }

// //       months.assignAll(list);
// //     } finally {
// //       isLoading.value = false;
// //     }
// //   }

// //   String _monthName(int month) {
// //     const names = [
// //       'January',
// //       'February',
// //       'March',
// //       'April',
// //       'May',
// //       'June',
// //       'July',
// //       'August',
// //       'September',
// //       'October',
// //       'November',
// //       'December',
// //     ];

// //     return names[month - 1];
// //   }
// // }







// // import 'package:get/get.dart';
// // import 'package:qr_code_scanner/data/models/datafetch/yearly_month_model.dart';
// // import 'package:qr_code_scanner/data/repositories/DataFetchRepo/attendance_repository.dart';
// // import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/student_controller.dart';

// // class YearlyAttendanceController extends GetxController {
// //   final AttendanceRepository _attendanceRepository = AttendanceRepository();

// //   final StudentController _studentController =
// //       Get.isRegistered<StudentController>()
// //           ? Get.find<StudentController>()
// //           : Get.put(StudentController());

// //   final isLoading = false.obs;
// //   final months = <YearlyMonthModel>[].obs;

// //   final selectedYear = DateTime.now().year.obs;

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchYearlyAttendance();
// //   }

// //   Future<void> fetchYearlyAttendance() async {
// //     try {
// //       isLoading.value = true;

// //       if (_studentController.student.value == null) {
// //         await _studentController.fetchStudent();
// //       }

// //       final student = _studentController.student.value;
// //       if (student == null) return;

// //       final summary =
// //           await _attendanceRepository.getYearlyAttendanceSummary(
// //         classId: student.grade.trim(),
// //         year: selectedYear.value,
// //         studentUid: student.uid.trim(),
// //       );

// //       final list = <YearlyMonthModel>[];

// //       for (int month = 1; month <= 12; month++) {
// //         final present = summary[month]?['present'] ?? 0;
// //         final absent = summary[month]?['absent'] ?? 0;

// //         list.add(
// //           YearlyMonthModel(
// //             year: selectedYear.value,
// //             month: month,
// //             monthName: _monthName(month),
// //             present: present,
// //             absent: absent,
// //             holiday: 0,
// //             hasData: present > 0 || absent > 0,
// //           ),
// //         );
// //       }

// //       months.assignAll(list);
// //     } catch (e) {
// //       Get.snackbar('Error', e.toString());
// //     } finally {
// //       isLoading.value = false;
// //     }
// //   }

// //   String _monthName(int month) {
// //     const names = [
// //       'January',
// //       'February',
// //       'March',
// //       'April',
// //       'May',
// //       'June',
// //       'July',
// //       'August',
// //       'September',
// //       'October',
// //       'November',
// //       'December',
// //     ];

// //     return names[month - 1];
// //   }
// // }


// import 'package:get/get.dart';
// import 'package:qr_code_scanner/data/models/datafetch/yearly_month_model.dart';
// import 'package:qr_code_scanner/data/repositories/DataFetchRepo/attendance_repository.dart';
// import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/student_controller.dart';

// class YearlyAttendanceController extends GetxController {
//   final AttendanceRepository _attendanceRepository = AttendanceRepository();

//   final StudentController _studentController =
//       Get.isRegistered<StudentController>()
//           ? Get.find<StudentController>()
//           : Get.put(StudentController());

//   final isLoading = true.obs;
//   int _requestId = 0;
//   final months = <YearlyMonthModel>[].obs;

//   final selectedYear = DateTime.now().year.obs;
//   final availableYears = <int>[].obs;

//   bool get hasPreviousYear {
//     return availableYears.any((year) => year < selectedYear.value);
//   }

//   bool get hasNextYear {
//     return availableYears.any((year) => year > selectedYear.value);
//   }

//   int? get previousAvailableYear {
//     final years = availableYears
//         .where((year) => year < selectedYear.value)
//         .toList()
//       ..sort();

//     return years.isEmpty ? null : years.last;
//   }

//   int? get nextAvailableYear {
//     final years = availableYears
//         .where((year) => year > selectedYear.value)
//         .toList()
//       ..sort();

//     return years.isEmpty ? null : years.first;
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     fetchYearlyAttendance();
//   }

//   // Future<void> fetchYearlyAttendance() async {
//   //   try {
//   //     isLoading.value = true;

//   //     if (_studentController.student.value == null) {
//   //       await _studentController.fetchStudent();
//   //     }

//   //     final student = _studentController.student.value;
//   //     if (student == null) return;

//   //     final years = await _attendanceRepository.getStudentAttendanceYears(
//   //       classId: student.grade.trim(),
//   //       studentUid: student.uid.trim(),
//   //     );

//   //     availableYears.assignAll(years);

//   //     if (availableYears.isNotEmpty &&
//   //         !availableYears.contains(selectedYear.value)) {
//   //       selectedYear.value = availableYears.last;
//   //     }

//   //     final summary = await _attendanceRepository.getYearlyAttendanceSummary(
//   //       classId: student.grade.trim(),
//   //       year: selectedYear.value,
//   //       studentUid: student.uid.trim(),
//   //     );

//   //     final list = <YearlyMonthModel>[];

//   //     for (int month = 1; month <= 12; month++) {
//   //       final present = summary[month]?['present'] ?? 0;
//   //       final absent = summary[month]?['absent'] ?? 0;

//   //       list.add(
//   //         YearlyMonthModel(
//   //           year: selectedYear.value,
//   //           month: month,
//   //           monthName: _monthName(month),
//   //           present: present,
//   //           absent: absent,
//   //           holiday: 0,
//   //           hasData: present > 0 || absent > 0,
//   //         ),
//   //       );
//   //     }

//   //     months.assignAll(list);
//   //   } catch (e) {
//   //     Get.snackbar('Error', e.toString());
//   //   } finally {
//   //     isLoading.value = false;
//   //   }
//   // }


// Future<void> fetchYearlyAttendance() async {
//   try {
//     isLoading.value = true;

//     if (_studentController.student.value == null) {
//       await _studentController.fetchStudent();
//     }

//     final student = _studentController.student.value;
//     if (student == null) return;

//     final years = await _attendanceRepository.getStudentAttendanceYears(
//       classId: student.grade.trim(),
//       studentUid: student.uid.trim(),
//     );

//     availableYears.assignAll(years);

//     if (availableYears.isNotEmpty &&
//         !availableYears.contains(selectedYear.value)) {
//       selectedYear.value = availableYears.last;
//     }

//     final summary = await _attendanceRepository.getYearlyAttendanceSummary(
//       classId: student.grade.trim(),
//       year: selectedYear.value,
//       studentUid: student.uid.trim(),
//     );

//     final list = <YearlyMonthModel>[];

//     for (int month = 1; month <= 12; month++) {
//       final present = summary[month]?['present'] ?? 0;
//       final absent = summary[month]?['absent'] ?? 0;

//       list.add(
//         YearlyMonthModel(
//           year: selectedYear.value,
//           month: month,
//           monthName: _monthName(month),
//           present: present,
//           absent: absent,
//           holiday: 0,
//           hasData: present > 0 || absent > 0,
//         ),
//       );
//     }

//     months.assignAll(list);
//   } catch (e) {
//     Get.snackbar('Error', e.toString());
//   } finally {
//     isLoading.value = false;
//   }
// }
//   // void previousYear() {
//   //   final year = previousAvailableYear;
//   //   if (year == null) return;

//   //   selectedYear.value = year;
//   //   fetchYearlyAttendance();
//   // }

//   // void nextYear() {
//   //   final year = nextAvailableYear;
//   //   if (year == null) return;

//   //   selectedYear.value = year;
//   //   fetchYearlyAttendance();
//   // }

//   void previousYear() {
//   final year = previousAvailableYear;
//   if (year == null) return;

//   selectedYear.value = year;
//   // months.clear();
//   fetchYearlyAttendance();
// }

// void nextYear() {
//   final year = nextAvailableYear;
//   if (year == null) return;

//   selectedYear.value = year;
//   // months.clear();
//   fetchYearlyAttendance();
// }

//   String _monthName(int month) {
//     const names = [
//       'January',
//       'February',
//       'March',
//       'April',
//       'May',
//       'June',
//       'July',
//       'August',
//       'September',
//       'October',
//       'November',
//       'December',
//     ];

//     return names[month - 1];
//   }
// }

// import 'package:get/get.dart';
// import 'package:qr_code_scanner/data/models/datafetch/yearly_month_model.dart';
// import 'package:qr_code_scanner/data/repositories/DataFetchRepo/attendance_repository.dart';
// import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/student_controller.dart';

// class YearlyAttendanceController extends GetxController {
//   final AttendanceRepository _attendanceRepository = AttendanceRepository();

//   final StudentController _studentController =
//       Get.isRegistered<StudentController>()
//           ? Get.find<StudentController>()
//           : Get.put(StudentController());

//   final isLoading = true.obs;
//   final months = <YearlyMonthModel>[].obs;

//   final selectedYear = DateTime.now().year.obs;
//   final availableYears = <int>[].obs;

//   int _requestId = 0;

//   bool get hasPreviousYear {
//     return availableYears.any((year) => year < selectedYear.value);
//   }

//   bool get hasNextYear {
//     return availableYears.any((year) => year > selectedYear.value);
//   }

//   int? get previousAvailableYear {
//     final years = availableYears
//         .where((year) => year < selectedYear.value)
//         .toList()
//       ..sort();

//     return years.isEmpty ? null : years.last;
//   }

//   int? get nextAvailableYear {
//     final years = availableYears
//         .where((year) => year > selectedYear.value)
//         .toList()
//       ..sort();

//     return years.isEmpty ? null : years.first;
//   }

//   @override
//   void onInit() {
//     super.onInit();

//     Future.microtask(() async {
//       await fetchYearlyAttendance();
//     });
//   }

//   Future<void> fetchYearlyAttendance() async {
//     final int requestId = ++_requestId;
//     final int yearToFetch = selectedYear.value;

//     try {
//       isLoading.value = true;

//       if (_studentController.student.value == null) {
//         await _studentController.fetchStudent();
//       }

//       final student = _studentController.student.value;
//       if (student == null) return;

//       final years = await _attendanceRepository.getStudentAttendanceYears(
//         classId: student.grade.trim(),
//         studentUid: student.uid.trim(),
//       );

//       if (requestId != _requestId) return;

//       availableYears.assignAll(years);

//       int finalYear = yearToFetch;

//       if (availableYears.isNotEmpty &&
//           !availableYears.contains(finalYear)) {
//         finalYear = availableYears.last;
//         selectedYear.value = finalYear;
//       }

//       final summary = await _attendanceRepository.getYearlyAttendanceSummary(
//         classId: student.grade.trim(),
//         year: finalYear,
//         studentUid: student.uid.trim(),
//       );

//       if (requestId != _requestId) return;

//       final list = <YearlyMonthModel>[];

//       for (int month = 1; month <= 12; month++) {
//         final present = summary[month]?['present'] ?? 0;
//         final absent = summary[month]?['absent'] ?? 0;

//         list.add(
//           YearlyMonthModel(
//             year: finalYear,
//             month: month,
//             monthName: _monthName(month),
//             present: present,
//             absent: absent,
//             holiday: 0,
//             hasData: present > 0 || absent > 0,
//           ),
//         );
//       }

//       months.assignAll(list);
//     } catch (e) {
//       Get.snackbar('Error', e.toString());
//     } finally {
//       if (requestId == _requestId) {
//         isLoading.value = false;
//       }
//     }
//   }

//   Future<void> previousYear() async {
//     final year = previousAvailableYear;
//     if (year == null) return;

//     selectedYear.value = year;
//     await fetchYearlyAttendance();
//   }

//   Future<void> nextYear() async {
//     final year = nextAvailableYear;
//     if (year == null) return;

//     selectedYear.value = year;
//     await fetchYearlyAttendance();
//   }

//   String _monthName(int month) {
//     const names = [
//       'January',
//       'February',
//       'March',
//       'April',
//       'May',
//       'June',
//       'July',
//       'August',
//       'September',
//       'October',
//       'November',
//       'December',
//     ];

//     return names[month - 1];
//   }
// }


import 'package:get/get.dart';
import 'package:qr_code_scanner/core/utils/app_toast.dart';
import 'package:qr_code_scanner/data/models/datafetch/yearly_month_model.dart';
import 'package:qr_code_scanner/data/repositories/DataFetchRepo/attendance_repository.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/student_controller.dart';

class YearlyAttendanceController extends GetxController {
  final AttendanceRepository _attendanceRepository = AttendanceRepository();

  final StudentController _studentController =
      Get.isRegistered<StudentController>()
          ? Get.find<StudentController>()
          : Get.put(StudentController());

  final isLoading = true.obs;
  final months = <YearlyMonthModel>[].obs;

  final selectedYear = DateTime.now().year.obs;
  final availableYears = <int>[].obs;

  int _requestId = 0;

  bool get hasPreviousYear =>
      availableYears.any((year) => year < selectedYear.value);

  bool get hasNextYear =>
      availableYears.any((year) => year > selectedYear.value);

  int? get previousAvailableYear {
    final years = availableYears
        .where((year) => year < selectedYear.value)
        .toList()
      ..sort();

    return years.isEmpty ? null : years.last;
  }

  int? get nextAvailableYear {
    final years = availableYears
        .where((year) => year > selectedYear.value)
        .toList()
      ..sort();

    return years.isEmpty ? null : years.first;
  }

  @override
  void onInit() {
    super.onInit();

    Future.microtask(() async {
      await fetchYearlyAttendance();
    });
  }

  Future<void> fetchYearlyAttendance() async {
    final int requestId = ++_requestId;
    final int requestedYear = selectedYear.value;

    try {
      isLoading.value = true;

      if (_studentController.student.value == null) {
        await _studentController.fetchStudent();
      }

      final student = _studentController.student.value;

      if (student == null) {
        months.assignAll(_emptyMonths(requestedYear));
        return;
      }

      final years = await _attendanceRepository.getStudentAttendanceYears(
        classId: student.grade.trim(),
        studentUid: student.uid.trim(),
      );

      if (requestId != _requestId) return;

      availableYears.assignAll(years);

      int yearToLoad = requestedYear;

      if (availableYears.isNotEmpty &&
          !availableYears.contains(yearToLoad)) {
        yearToLoad = availableYears.last;
        selectedYear.value = yearToLoad;
      }

      final summary = await _attendanceRepository.getYearlyAttendanceSummary(
        classId: student.grade.trim(),
        year: yearToLoad,
        studentUid: student.uid.trim(),
      );

      if (requestId != _requestId) return;

      final list = <YearlyMonthModel>[];

      for (int month = 1; month <= 12; month++) {
        final present = summary[month]?['present'] ?? 0;
        final absent = summary[month]?['absent'] ?? 0;

        list.add(
          YearlyMonthModel(
            year: yearToLoad,
            month: month,
            monthName: _monthName(month),
            present: present,
            absent: absent,
            holiday: 0,
            hasData: present > 0 || absent > 0,
          ),
        );
      }

      months.assignAll(list);
    } catch (e) {
      // Get.snackbar('Error', e.toString());
        AppToast.error(e.toString());
      months.assignAll(_emptyMonths(selectedYear.value));
    } finally {
      if (requestId == _requestId) {
        isLoading.value = false;
      }
    }
  }

  Future<void> previousYear() async {
    final year = previousAvailableYear;
    if (year == null || isLoading.value) return;

    selectedYear.value = year;
    await fetchYearlyAttendance();
  }

  Future<void> nextYear() async {
    final year = nextAvailableYear;
    if (year == null || isLoading.value) return;

    selectedYear.value = year;
    await fetchYearlyAttendance();
  }

  List<YearlyMonthModel> _emptyMonths(int year) {
    return List.generate(
      12,
      (index) {
        final month = index + 1;

        return YearlyMonthModel(
          year: year,
          month: month,
          monthName: _monthName(month),
          present: 0,
          absent: 0,
          holiday: 0,
          hasData: false,
        );
      },
    );
  }

  String _monthName(int month) {
    const names = [
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

    return names[month - 1];
  }
}