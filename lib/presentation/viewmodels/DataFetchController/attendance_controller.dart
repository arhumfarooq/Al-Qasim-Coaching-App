// // // // // // import 'package:get/get.dart';
// // // // // // import 'package:qr_code_scanner/core/constants/enums.dart';
// // // // // // // import 'package:qr_code_scanner/data/models/attendance_day_model.dart';
// // // // // // import 'package:qr_code_scanner/data/models/datafetch/attendance_day_model.dart';
// // // // // // import 'package:qr_code_scanner/data/repositories/DataFetchRepo/attendance_repository.dart' show AttendanceRepository;
// // // // // // // import 'package:qr_code_scanner/data/repositories/attendance_repository.dart';
// // // // // // import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/student_controller.dart';
// // // // // // // import 'package:qr_code_scanner/presentation/viewmodels/student_controller.dart';

// // // // // // class AttendanceController extends GetxController {
// // // // // //   final AttendanceRepository _attendanceRepository = Get.put(AttendanceRepository());

// // // // // //   final StudentController _studentController =
// // // // // //       Get.find<StudentController>();

// // // // // //   final isLoading = false.obs;

// // // // // //   final selectedDate = DateTime.now().obs;
// // // // // //   final attendanceDays = <AttendanceDayModel>[].obs;

// // // // // //   int get year => selectedDate.value.year;
// // // // // //   int get month => selectedDate.value.month;

// // // // // //   int get totalDays => DateTime(year, month + 1, 0).day;

// // // // // //   int get startOffset {
// // // // // //     final firstDay = DateTime(year, month, 1);
// // // // // //     return firstDay.weekday % 7;
// // // // // //   }

// // // // // //   int get presentCount =>
// // // // // //       attendanceDays.where((e) => e.status == 'present').length;

// // // // // //   int get absentCount =>
// // // // // //       attendanceDays.where((e) => e.status == 'absent').length;

// // // // // //   int get holidayCount =>
// // // // // //       attendanceDays.where((e) => e.status == 'holiday').length;

// // // // // //   int get workingDays => presentCount + absentCount;

// // // // // //   String get percentage {
// // // // // //     if (workingDays == 0) return '0%';
// // // // // //     return '${((presentCount / workingDays) * 100).round()}%';
// // // // // //   }

// // // // // //   String get monthName {
// // // // // //     const months = [
// // // // // //       'January',
// // // // // //       'February',
// // // // // //       'March',
// // // // // //       'April',
// // // // // //       'May',
// // // // // //       'June',
// // // // // //       'July',
// // // // // //       'August',
// // // // // //       'September',
// // // // // //       'October',
// // // // // //       'November',
// // // // // //       'December',
// // // // // //     ];

// // // // // //     return months[month - 1];
// // // // // //   }

// // // // // //   @override
// // // // // //   void onInit() {
// // // // // //     super.onInit();
// // // // // //     fetchMonthlyAttendance();
// // // // // //   }

// // // // // //   Future<void> fetchMonthlyAttendance() async {
// // // // // //     try {
// // // // // //       isLoading.value = true;

// // // // // //       final student = _studentController.student.value;

// // // // // //       if (student == null) {
// // // // // //         await _studentController.fetchStudent();
// // // // // //       }

// // // // // //       final currentStudent = _studentController.student.value;

// // // // // //       if (currentStudent == null) {
// // // // // //         Get.snackbar('Error', 'Student data not found');
// // // // // //         return;
// // // // // //       }

// // // // // //       final records =
// // // // // //           await _attendanceRepository.getMonthlyAttendance(
// // // // // //         classId: currentStudent.grade,
// // // // // //         year: year,
// // // // // //         month: month,
// // // // // //         studentUid: currentStudent.uid,
// // // // // //       );

// // // // // //       final List<AttendanceDayModel> days = [];

// // // // // //       for (int day = 1; day <= totalDays; day++) {
// // // // // //         final date = DateTime(year, month, day);
// // // // // //         final dateStr =
// // // // // //             '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

// // // // // //         if (date.weekday == DateTime.sunday) {
// // // // // //           days.add(
// // // // // //             AttendanceDayModel(
// // // // // //               date: date,
// // // // // //               dateStr: dateStr,
// // // // // //               status: 'holiday',
// // // // // //             ),
// // // // // //           );
// // // // // //         } else {
// // // // // //           days.add(
// // // // // //             AttendanceDayModel(
// // // // // //               date: date,
// // // // // //               dateStr: dateStr,
// // // // // //               status: records[dateStr] ?? 'absent',
// // // // // //             ),
// // // // // //           );
// // // // // //         }
// // // // // //       }

// // // // // //       attendanceDays.assignAll(days);
// // // // // //     } catch (e) {
// // // // // //       Get.snackbar('Error', e.toString());
// // // // // //     } finally {
// // // // // //       isLoading.value = false;
// // // // // //     }
// // // // // //   }

// // // // // //   CalendarDayStatus getDayStatus(int day) {
// // // // // //     final item = attendanceDays.firstWhereOrNull(
// // // // // //       (e) => e.date.day == day,
// // // // // //     );

// // // // // //     switch (item?.status) {
// // // // // //       case 'present':
// // // // // //         return CalendarDayStatus.present;
// // // // // //       case 'absent':
// // // // // //         return CalendarDayStatus.absent;
// // // // // //       case 'holiday':
// // // // // //         return CalendarDayStatus.holiday;
// // // // // //       default:
// // // // // //         return CalendarDayStatus.absent;
// // // // // //     }
// // // // // //   }

// // // // // //   void previousMonth() {
// // // // // //     selectedDate.value = DateTime(year, month - 1, 1);
// // // // // //     fetchMonthlyAttendance();
// // // // // //   }

// // // // // //   void nextMonth() {
// // // // // //     selectedDate.value = DateTime(year, month + 1, 1);
// // // // // //     fetchMonthlyAttendance();
// // // // // //   }
// // // // // // }

// // // // // import 'package:get/get.dart';
// // // // // import 'package:qr_code_scanner/core/constants/enums.dart';
// // // // // import 'package:qr_code_scanner/data/models/datafetch/attendance_day_model.dart';
// // // // // import 'package:qr_code_scanner/data/repositories/DataFetchRepo/attendance_repository.dart';
// // // // // import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/student_controller.dart';

// // // // // class AttendanceController extends GetxController {
// // // // //   // final AttendanceRepository _attendanceRepository =
// // // // //   //     Get.find<AttendanceRepository>();
// // // // //   final AttendanceRepository _attendanceRepository =
// // // // //     AttendanceRepository();

// // // // //   final StudentController _studentController =
// // // // //       Get.find<StudentController>();

// // // // //   final isLoading = false.obs;

// // // // //   final selectedDate = DateTime.now().obs;
// // // // //   final attendanceDays = <AttendanceDayModel>[].obs;

// // // // //   int get year => selectedDate.value.year;
// // // // //   int get month => selectedDate.value.month;

// // // // //   int get totalDays => DateTime(year, month + 1, 0).day;

// // // // //   int get startOffset {
// // // // //     final firstDay = DateTime(year, month, 1);
// // // // //     return firstDay.weekday % 7;
// // // // //   }

// // // // //   int get presentCount =>
// // // // //       attendanceDays.where((e) => e.status == 'present').length;

// // // // //   int get absentCount =>
// // // // //       attendanceDays.where((e) => e.status == 'absent').length;

// // // // //   int get holidayCount =>
// // // // //       attendanceDays.where((e) => e.status == 'holiday').length;

// // // // //   int get notMarkedCount =>
// // // // //       attendanceDays.where((e) => e.status == 'not_marked').length;

// // // // //   int get workingDays => presentCount + absentCount;

// // // // //   String get percentage {
// // // // //     if (workingDays == 0) return '0%';
// // // // //     return '${((presentCount / workingDays) * 100).round()}%';
// // // // //   }

// // // // //   String get monthName {
// // // // //     const months = [
// // // // //       'January',
// // // // //       'February',
// // // // //       'March',
// // // // //       'April',
// // // // //       'May',
// // // // //       'June',
// // // // //       'July',
// // // // //       'August',
// // // // //       'September',
// // // // //       'October',
// // // // //       'November',
// // // // //       'December',
// // // // //     ];

// // // // //     return months[month - 1];
// // // // //   }

// // // // //   @override
// // // // //   void onInit() {
// // // // //     super.onInit();
// // // // //     fetchMonthlyAttendance();
// // // // //   }

// // // // //   Future<void> fetchMonthlyAttendance() async {
// // // // //     try {
// // // // //       isLoading.value = true;

// // // // //       if (_studentController.student.value == null) {
// // // // //         await _studentController.fetchStudent();
// // // // //       }

// // // // //       final currentStudent = _studentController.student.value;

// // // // //       if (currentStudent == null) {
// // // // //         Get.snackbar('Error', 'Student data not found');
// // // // //         return;
// // // // //       }

// // // // //       final records = await _attendanceRepository.getMonthlyAttendance(
// // // // //         classId: currentStudent.grade,
// // // // //         year: year,
// // // // //         month: month,
// // // // //         studentUid: currentStudent.uid,
// // // // //       );

// // // // //       final List<AttendanceDayModel> days = [];

// // // // //       for (int day = 1; day <= totalDays; day++) {
// // // // //         final date = DateTime(year, month, day);

// // // // //         final dateStr =
// // // // //             '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

// // // // //         if (date.weekday == DateTime.sunday) {
// // // // //           days.add(
// // // // //             AttendanceDayModel(
// // // // //               date: date,
// // // // //               dateStr: dateStr,
// // // // //               status: 'holiday',
// // // // //             ),
// // // // //           );
// // // // //         } else {
// // // // //           days.add(
// // // // //             AttendanceDayModel(
// // // // //               date: date,
// // // // //               dateStr: dateStr,
// // // // //               status: records[dateStr] ?? 'not_marked',
// // // // //             ),
// // // // //           );
// // // // //         }
// // // // //       }

// // // // //       attendanceDays.assignAll(days);
// // // // //     } catch (e) {
// // // // //       Get.snackbar('Error', e.toString());
// // // // //     } finally {
// // // // //       isLoading.value = false;
// // // // //     }
// // // // //   }

// // // // //   CalendarDayStatus getDayStatus(int day) {
// // // // //     final item = attendanceDays.firstWhereOrNull(
// // // // //       (e) => e.date.day == day,
// // // // //     );

// // // // //     switch (item?.status) {
// // // // //       case 'present':
// // // // //         return CalendarDayStatus.present;
// // // // //       case 'absent':
// // // // //         return CalendarDayStatus.absent;
// // // // //       case 'holiday':
// // // // //         return CalendarDayStatus.holiday;
// // // // //       default:
// // // // //         return CalendarDayStatus.none;
// // // // //     }
// // // // //   }

// // // // //   void previousMonth() {
// // // // //     selectedDate.value = DateTime(year, month - 1, 1);
// // // // //     fetchMonthlyAttendance();
// // // // //   }

// // // // //   void nextMonth() {
// // // // //     selectedDate.value = DateTime(year, month + 1, 1);
// // // // //     fetchMonthlyAttendance();
// // // // //   }
// // // // // }

// // // // import 'package:get/get.dart';
// // // // import 'package:qr_code_scanner/core/constants/enums.dart';
// // // // import 'package:qr_code_scanner/data/models/datafetch/attendance_day_model.dart';
// // // // import 'package:qr_code_scanner/data/repositories/DataFetchRepo/attendance_repository.dart';
// // // // import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/student_controller.dart';

// // // // class AttendanceController extends GetxController {

// // // //   final AttendanceRepository _attendanceRepository =
// // // //       AttendanceRepository();

// // // //   final StudentController _studentController =
// // // //       Get.isRegistered<StudentController>()
// // // //           ? Get.find<StudentController>()
// // // //           : Get.put(StudentController());

// // // //   final isLoading = false.obs;

// // // //   final selectedDate = DateTime.now().obs;

// // // //   final attendanceDays = <AttendanceDayModel>[].obs;

// // // //   int get year => selectedDate.value.year;

// // // //   int get month => selectedDate.value.month;

// // // //   int get totalDays =>
// // // //       DateTime(year, month + 1, 0).day;

// // // //   int get startOffset {
// // // //     final firstDay = DateTime(year, month, 1);
// // // //     return firstDay.weekday % 7;
// // // //   }

// // // //   int get presentCount =>
// // // //       attendanceDays
// // // //           .where((e) => e.status == 'present')
// // // //           .length;

// // // //   int get absentCount =>
// // // //       attendanceDays
// // // //           .where((e) => e.status == 'absent')
// // // //           .length;

// // // //   int get holidayCount =>
// // // //       attendanceDays
// // // //           .where((e) => e.status == 'holiday')
// // // //           .length;

// // // //   int get notMarkedCount =>
// // // //       attendanceDays
// // // //           .where((e) => e.status == 'not_marked')
// // // //           .length;

// // // //   int get workingDays =>
// // // //       presentCount + absentCount;

// // // //   String get percentage {
// // // //     if (workingDays == 0) return '0%';

// // // //     return '${((presentCount / workingDays) * 100).round()}%';
// // // //   }

// // // //   String get monthName {
// // // //     const months = [
// // // //       'January',
// // // //       'February',
// // // //       'March',
// // // //       'April',
// // // //       'May',
// // // //       'June',
// // // //       'July',
// // // //       'August',
// // // //       'September',
// // // //       'October',
// // // //       'November',
// // // //       'December',
// // // //     ];

// // // //     return months[month - 1];
// // // //   }

// // // //   @override
// // // //   void onInit() {
// // // //     super.onInit();

// // // //     fetchMonthlyAttendance();
// // // //   }

// // // //   Future<void> fetchMonthlyAttendance() async {
// // // //     try {
// // // //       isLoading.value = true;

// // // //       /// FETCH STUDENT
// // // //       if (_studentController.student.value == null) {
// // // //         await _studentController.fetchStudent();
// // // //       }

// // // //       final currentStudent =
// // // //           _studentController.student.value;

// // // //       if (currentStudent == null) {
// // // //         Get.snackbar(
// // // //           'Error',
// // // //           'Student data not found',
// // // //         );
// // // //         return;
// // // //       }

// // // //       print(
// // // //           'CURRENT STUDENT UID: ${currentStudent.uid}');

// // // //       final records =
// // // //           await _attendanceRepository.getMonthlyAttendance(
// // // //         classId: currentStudent.grade,
// // // //         year: year,
// // // //         month: month,
// // // //         studentUid: currentStudent.uid,
// // // //       );

// // // //       print('ATTENDANCE RECORDS: $records');

// // // //       final List<AttendanceDayModel> days = [];

// // // //       for (int day = 1; day <= totalDays; day++) {

// // // //         final date = DateTime(year, month, day);

// // // //         final dateStr =
// // // //             '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

// // // //         /// SUNDAY HOLIDAY
// // // //         if (date.weekday == DateTime.sunday) {

// // // //           days.add(
// // // //             AttendanceDayModel(
// // // //               date: date,
// // // //               dateStr: dateStr,
// // // //               status: 'holiday',
// // // //             ),
// // // //           );

// // // //         } else {

// // // //           final status =
// // // //               records[dateStr] ?? 'not_marked';

// // // //           print(
// // // //               'DATE: $dateStr | STATUS: $status');

// // // //           days.add(
// // // //             AttendanceDayModel(
// // // //               date: date,
// // // //               dateStr: dateStr,
// // // //               status: status,
// // // //             ),
// // // //           );
// // // //         }
// // // //       }

// // // //       attendanceDays.assignAll(days);

// // // //       print('PRESENT COUNT: $presentCount');
// // // //       print('ABSENT COUNT: $absentCount');

// // // //     } catch (e) {

// // // //       print('ATTENDANCE ERROR: $e');

// // // //       Get.snackbar(
// // // //         'Error',
// // // //         e.toString(),
// // // //       );

// // // //     } finally {

// // // //       isLoading.value = false;
// // // //     }
// // // //   }

// // // //   CalendarDayStatus getDayStatus(int day) {

// // // //     final item = attendanceDays.firstWhereOrNull(
// // // //       (e) => e.date.day == day,
// // // //     );

// // // //     switch (item?.status) {

// // // //       case 'present':
// // // //         return CalendarDayStatus.present;

// // // //       case 'absent':
// // // //         return CalendarDayStatus.absent;

// // // //       case 'holiday':
// // // //         return CalendarDayStatus.holiday;

// // // //       default:
// // // //         return CalendarDayStatus.none;
// // // //     }
// // // //   }

// // // //   void previousMonth() {

// // // //     selectedDate.value =
// // // //         DateTime(year, month - 1, 1);

// // // //     fetchMonthlyAttendance();
// // // //   }

// // // //   void nextMonth() {

// // // //     selectedDate.value =
// // // //         DateTime(year, month + 1, 1);

// // // //     fetchMonthlyAttendance();
// // // //   }
// // // // }

// // // import 'package:get/get.dart';
// // // import 'package:qr_code_scanner/core/constants/enums.dart';
// // // import 'package:qr_code_scanner/data/models/datafetch/attendance_day_model.dart';
// // // import 'package:qr_code_scanner/data/repositories/DataFetchRepo/attendance_repository.dart';
// // // import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/student_controller.dart';

// // // class AttendanceController extends GetxController {
// // //   final AttendanceRepository _attendanceRepository = AttendanceRepository();

// // //   final StudentController _studentController =
// // //       Get.isRegistered<StudentController>()
// // //           ? Get.find<StudentController>()
// // //           : Get.put(StudentController());

// // //   final isLoading = false.obs;
// // //   final selectedDate = DateTime.now().obs;
// // //   final attendanceDays = <AttendanceDayModel>[].obs;

// // //   int get year => selectedDate.value.year;
// // //   int get month => selectedDate.value.month;

// // //   int get totalDays => DateTime(year, month + 1, 0).day;

// // //   int get startOffset {
// // //     final firstDay = DateTime(year, month, 1);
// // //     return firstDay.weekday % 7;
// // //   }

// // //   int get presentCount =>
// // //       attendanceDays.where((e) => e.status == 'present').length;

// // //   int get absentCount =>
// // //       attendanceDays.where((e) => e.status == 'absent').length;

// // //   int get holidayCount =>
// // //       attendanceDays.where((e) => e.status == 'holiday').length;

// // //   int get notMarkedCount =>
// // //       attendanceDays.where((e) => e.status == 'not_marked').length;

// // //   int get workingDays => presentCount + absentCount;

// // //   String get percentage {
// // //     if (workingDays == 0) return '0%';
// // //     return '${((presentCount / workingDays) * 100).round()}%';
// // //   }

// // //   String get monthName {
// // //     const months = [
// // //       'January', 'February', 'March', 'April', 'May', 'June',
// // //       'July', 'August', 'September', 'October', 'November', 'December',
// // //     ];

// // //     return months[month - 1];
// // //   }

// // //   @override
// // //   void onInit() {
// // //     super.onInit();

// // //     Future.delayed(Duration.zero, () {
// // //       fetchMonthlyAttendance();
// // //     });
// // //   }

// // //   Future<void> fetchMonthlyAttendance() async {
// // //     try {
// // //       isLoading.value = true;

// // //       if (_studentController.student.value == null) {
// // //         await _studentController.fetchStudent();
// // //       }

// // //       final currentStudent = _studentController.student.value;

// // //       if (currentStudent == null) {
// // //         Get.snackbar('Error', 'Student data not found');
// // //         return;
// // //       }

// // //       final records = await _attendanceRepository.getMonthlyAttendance(
// // //         classId: currentStudent.grade.trim(),
// // //         year: year,
// // //         month: month,
// // //         studentUid: currentStudent.uid.trim(),
// // //       );

// // //       final List<AttendanceDayModel> days = [];

// // //       for (int day = 1; day <= totalDays; day++) {
// // //         final date = DateTime(year, month, day);

// // //         final dateStr =
// // //             '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

// // //         if (date.weekday == DateTime.sunday) {
// // //           days.add(
// // //             AttendanceDayModel(
// // //               date: date,
// // //               dateStr: dateStr,
// // //               status: 'holiday',
// // //             ),
// // //           );
// // //         } else {
// // //           days.add(
// // //             AttendanceDayModel(
// // //               date: date,
// // //               dateStr: dateStr,
// // //               status: records[dateStr] ?? 'not_marked',
// // //             ),
// // //           );
// // //         }
// // //       }

// // //       attendanceDays.assignAll(days);
// // //     } catch (e) {
// // //       Get.snackbar('Error', e.toString());
// // //     } finally {
// // //       isLoading.value = false;
// // //     }
// // //   }

// // //  CalendarDayStatus getDayStatus(int day) {
// // //   final item = attendanceDays.firstWhereOrNull(
// // //     (e) => e.date.day == day,
// // //   );

// // //   if (item == null) {
// // //     return CalendarDayStatus.absent;
// // //   }

// // //   switch (item.status) {
// // //     case 'present':
// // //       return CalendarDayStatus.present;

// // //     case 'absent':
// // //       return CalendarDayStatus.absent;

// // //     case 'holiday':
// // //       return CalendarDayStatus.holiday;

// // //     default:
// // //       return CalendarDayStatus.absent;
// // //   }
// // // }


// // //   void previousMonth() {
// // //     selectedDate.value = DateTime(year, month - 1, 1);
// // //     fetchMonthlyAttendance();
// // //   }

// // //   void nextMonth() {
// // //     selectedDate.value = DateTime(year, month + 1, 1);
// // //     fetchMonthlyAttendance();
// // //   }

// // //   void refreshAttendance() {
// // //     fetchMonthlyAttendance();
// // //   }
// // // }

// // import 'package:get/get.dart';
// // import 'package:qr_code_scanner/core/constants/enums.dart';
// // import 'package:qr_code_scanner/data/models/datafetch/attendance_day_model.dart';
// // import 'package:qr_code_scanner/data/repositories/DataFetchRepo/attendance_repository.dart';
// // import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/student_controller.dart';

// // class AttendanceController extends GetxController {
// //   final AttendanceRepository _attendanceRepository = AttendanceRepository();

// //   final StudentController _studentController =
// //       Get.isRegistered<StudentController>()
// //           ? Get.find<StudentController>()
// //           : Get.put(StudentController());

// //   final isLoading = false.obs;
// //   final selectedDate = DateTime.now().obs;
// //   final attendanceDays = <AttendanceDayModel>[].obs;

// //   int get year => selectedDate.value.year;
// //   int get month => selectedDate.value.month;

// //   int get totalDays => DateTime(year, month + 1, 0).day;

// //   int get startOffset {
// //     final firstDay = DateTime(year, month, 1);
// //     return firstDay.weekday % 7;
// //   }

// //   int get presentCount =>
// //       attendanceDays.where((e) => e.status == 'present').length;

// //   int get absentCount =>
// //       attendanceDays.where((e) => e.status == 'absent').length;

// //   int get holidayCount =>
// //       attendanceDays.where((e) => e.status == 'holiday').length;

// //   int get notMarkedCount =>
// //       attendanceDays.where((e) => e.status == 'not_marked').length;

// //   int get workingDays => presentCount + absentCount;

// //   String get percentage {
// //     if (workingDays == 0) return '0%';
// //     return '${((presentCount / workingDays) * 100).round()}%';
// //   }

// //   String get monthName {
// //     const months = [
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

// //     return months[month - 1];
// //   }

// //   @override
// //   void onInit() {
// //     super.onInit();

// //     Future.delayed(Duration.zero, () {
// //       fetchMonthlyAttendance();
// //     });
// //   }

// //   Future<void> fetchMonthlyAttendance() async {
// //     try {
// //       isLoading.value = true;

// //       if (_studentController.student.value == null) {
// //         await _studentController.fetchStudent();
// //       }

// //       final currentStudent = _studentController.student.value;

// //       if (currentStudent == null) {
// //         Get.snackbar('Error', 'Student data not found');
// //         return;
// //       }

// //       final records = await _attendanceRepository.getMonthlyAttendance(
// //         classId: currentStudent.grade.trim(),
// //         year: year,
// //         month: month,
// //         studentUid: currentStudent.uid.trim(),
// //       );

// //       final List<AttendanceDayModel> days = [];

// //       for (int day = 1; day <= totalDays; day++) {
// //         final date = DateTime(year, month, day);

// //         final dateStr =
// //             '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

// //         if (date.weekday == DateTime.sunday) {
// //           days.add(
// //             AttendanceDayModel(
// //               date: date,
// //               dateStr: dateStr,
// //               status: 'holiday',
// //             ),
// //           );
// //         } else {
// //           days.add(
// //             AttendanceDayModel(
// //               date: date,
// //               dateStr: dateStr,
// //               status: records[dateStr] ?? 'not_marked',
// //             ),
// //           );
// //         }
// //       }

// //       attendanceDays.assignAll(days);
// //     } catch (e) {
// //       Get.snackbar('Error', e.toString());
// //     } finally {
// //       isLoading.value = false;
// //     }
// //   }

// //   CalendarDayStatus getDayStatus(int day) {
// //     final item = attendanceDays.firstWhereOrNull(
// //       (e) => e.date.day == day,
// //     );

// //     switch (item?.status) {
// //       case 'present':
// //         return CalendarDayStatus.present;

// //       case 'absent':
// //         return CalendarDayStatus.absent;

// //       case 'holiday':
// //         return CalendarDayStatus.holiday;

// //       case 'not_marked':
// //         return CalendarDayStatus.none;

// //       default:
// //         return CalendarDayStatus.none;
// //     }
// //   }

// //   void previousMonth() {
// //     selectedDate.value = DateTime(year, month - 1, 1);
// //     fetchMonthlyAttendance();
// //   }

// //   void nextMonth() {
// //     selectedDate.value = DateTime(year, month + 1, 1);
// //     fetchMonthlyAttendance();
// //   }

// //   void refreshAttendance() {
// //     fetchMonthlyAttendance();
// //   }
// // }

// // import 'package:get/get.dart';
// // import 'package:qr_code_scanner/core/constants/enums.dart';
// // import 'package:qr_code_scanner/data/models/datafetch/attendance_day_model.dart';
// // import 'package:qr_code_scanner/data/repositories/DataFetchRepo/attendance_repository.dart';
// // import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/student_controller.dart';

// // class AttendanceController extends GetxController {
// //   final AttendanceRepository _attendanceRepository = AttendanceRepository();

// //   final StudentController _studentController =
// //       Get.isRegistered<StudentController>()
// //           ? Get.find<StudentController>()
// //           : Get.put(StudentController());

// //   final isLoading = true.obs;
// //   final selectedDate = DateTime.now().obs;
// //   final attendanceDays = <AttendanceDayModel>[].obs;
// //   final availableMonths = <String>[].obs;
// //   final selectedFilter = 'all'.obs;


// //   int get year => selectedDate.value.year;
// //   int get month => selectedDate.value.month;


// // String get currentMonthKey => '${year}_$month';

// // bool get hasPreviousMonth {
// //   final previous = DateTime(year, month - 1, 1);
// //   final key = '${previous.year}_${previous.month}';
// //   return availableMonths.contains(key);
// // }

// // bool get hasNextMonth {
// //   final next = DateTime(year, month + 1, 1);
// //   final key = '${next.year}_${next.month}';
// //   return availableMonths.contains(key);
// // }


// //   int get totalDays => DateTime(year, month + 1, 0).day;

// //   int get startOffset {
// //     final firstDay = DateTime(year, month, 1);
// //     return firstDay.weekday % 7;
// //   }

// //   int get presentCount =>
// //       attendanceDays.where((e) => e.status == 'present').length;

// //   int get absentCount =>
// //       attendanceDays.where((e) => e.status == 'absent').length;

// //   int get holidayCount =>
// //       attendanceDays.where((e) => e.status == 'holiday').length;

// //   int get notMarkedCount =>
// //       attendanceDays.where((e) => e.status == 'not_marked').length;

// //   int get workingDays => presentCount + absentCount;

// //   String get percentage {
// //     if (workingDays == 0) return '0%';
// //     return '${((presentCount / workingDays) * 100).round()}%';
// //   }

// //   String get monthName {
// //     const months = [
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

// //     return months[month - 1];
// //   }

// //   List<AttendanceDayModel> get markedDays {
// //     final list = attendanceDays
// //         .where((e) => e.status != 'not_marked')
// //         .toList();

// //     list.sort((a, b) => b.date.compareTo(a.date));

// //     return list;
// //   }

// //   String getDayName(DateTime date) {
// //     const days = [
// //       'Monday',
// //       'Tuesday',
// //       'Wednesday',
// //       'Thursday',
// //       'Friday',
// //       'Saturday',
// //       'Sunday',
// //     ];

// //     return days[date.weekday - 1];
// //   }

// //   String getDateText(DateTime date) {
// //     const months = [
// //       'Jan',
// //       'Feb',
// //       'Mar',
// //       'Apr',
// //       'May',
// //       'Jun',
// //       'Jul',
// //       'Aug',
// //       'Sep',
// //       'Oct',
// //       'Nov',
// //       'Dec',
// //     ];

// //     return '${date.day} ${months[date.month - 1]}';
// //   }

// //   String getStatusText(String status) {
// //     switch (status) {
// //       case 'present':
// //         return 'Present';
// //       case 'absent':
// //         return 'Absent';
// //       case 'holiday':
// //         return 'Holiday';
// //       default:
// //         return 'Not Marked';
// //     }
// //   }



// //   List<AttendanceDayModel> get filteredMarkedDays {
// //   var list = attendanceDays
// //       .where((e) => e.status != 'not_marked')
// //       .toList();

// //   if (selectedFilter.value != 'all') {
// //     list = list
// //         .where((e) => e.status == selectedFilter.value)
// //         .toList();
// //   }

// //   list.sort((a, b) => a.date.compareTo(b.date));

// //   return list;
// // }

// //   String getAttendanceTime(String status) {
// //     switch (status) {
// //       case 'holiday':
// //         return 'Sunday Holiday';
// //       case 'present':
// //         return 'Attendance Marked';
// //       case 'absent':
// //         return 'Marked Absent';
// //       default:
// //         return 'Not Marked';
// //     }
// //   }

// //   // @override
// //   // void onInit() {
// //   //   super.onInit();

// //   //   Future.delayed(Duration.zero, () {
// //   //     fetchMonthlyAttendance();
// //   //   });
// //   // }

// // @override
// // void onInit() {
// //   super.onInit();


// //  final args = Get.arguments;

// //   if (args != null) {
// //     selectedDate.value = DateTime(
// //       args['year'],
// //       args['month'],
// //       1,
// //     );
// //   }
// //    loadInitialData();
// // }



// // Future<void> loadInitialData() async {
// //   try {
// //     isLoading.value = true;

// //     await fetchAvailableMonths();
// //     await fetchMonthlyAttendance();
// //   } finally {
// //     isLoading.value = false;
// //   }
// // }

// //   Future<void> fetchMonthlyAttendance() async {
// //     try {
// //       isLoading.value = true;

// //       if (_studentController.student.value == null) {
// //         await _studentController.fetchStudent();
// //       }

// //       final currentStudent = _studentController.student.value;

// //       if (currentStudent == null) {
// //         Get.snackbar('Error', 'Student data not found');
// //         return;
// //       }

// //       final records = await _attendanceRepository.getMonthlyAttendance(
// //         classId: currentStudent.grade.trim(),
// //         year: year,
// //         month: month,
// //         studentUid: currentStudent.uid.trim(),
// //       );

// //       final List<AttendanceDayModel> days = [];

// //       for (int day = 1; day <= totalDays; day++) {
// //         final date = DateTime(year, month, day);

// //         final dateStr =
// //             '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

// //         if (date.weekday == DateTime.sunday) {
// //           days.add(
// //             AttendanceDayModel(
// //               date: date,
// //               dateStr: dateStr,
// //               status: 'holiday',
// //             ),
// //           );
// //         } else {
// //           days.add(
// //             AttendanceDayModel(
// //               date: date,
// //               dateStr: dateStr,
// //               status: records[dateStr] ?? 'not_marked',
// //             ),
// //           );
// //         }
// //       }

// //       attendanceDays.assignAll(days);
// //     } catch (e) {
// //       Get.snackbar('Error', e.toString());
// //     } finally {
// //       isLoading.value = false;
// //     }
// //   }


// //   void changeFilter(String filter) {
// //   selectedFilter.value = filter;
// // }

// //   CalendarDayStatus getDayStatus(int day) {
// //     final item = attendanceDays.firstWhereOrNull(
// //       (e) => e.date.day == day,
// //     );

// //     switch (item?.status) {
// //       case 'present':
// //         return CalendarDayStatus.present;
// //       case 'absent':
// //         return CalendarDayStatus.absent;
// //       case 'holiday':
// //         return CalendarDayStatus.holiday;
// //       case 'not_marked':
// //         return CalendarDayStatus.none;
// //       default:
// //         return CalendarDayStatus.none;
// //     }
// //   }

// //   // void previousMonth() {
// //   //   selectedDate.value = DateTime(year, month - 1, 1);
// //   //   fetchMonthlyAttendance();
// //   // }

// // void previousMonth() {
// //   if (!hasPreviousMonth) return;

// //   selectedDate.value = DateTime(year, month - 1, 1);
// //   fetchMonthlyAttendance();
// // }

// //   // void nextMonth() {
// //   //   selectedDate.value = DateTime(year, month + 1, 1);
// //   //   fetchMonthlyAttendance();
// //   // }



// // void nextMonth() {
// //   if (!hasNextMonth) return;

// //   selectedDate.value = DateTime(year, month + 1, 1);
// //   fetchMonthlyAttendance();
// // }

// //   void refreshAttendance() {
// //     fetchMonthlyAttendance();
// //   }


// //   Future<void> fetchAvailableMonths() async {
// //   if (_studentController.student.value == null) {
// //     await _studentController.fetchStudent();
// //   }

// //   final student = _studentController.student.value;

// //   if (student == null) return;

// //   final months = await _attendanceRepository.getStudentAttendanceMonths(
// //     classId: student.grade.trim(),
// //     studentUid: student.uid.trim(),
// //   );

// //   availableMonths.assignAll(months);
// // }
// // }


// import 'package:get/get.dart';
// import 'package:qr_code_scanner/core/constants/enums.dart';
// import 'package:qr_code_scanner/data/models/datafetch/attendance_day_model.dart';
// import 'package:qr_code_scanner/data/repositories/DataFetchRepo/attendance_repository.dart';
// import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/student_controller.dart';

// class AttendanceController extends GetxController {
//   final AttendanceRepository _attendanceRepository = AttendanceRepository();

//   final StudentController _studentController =
//       Get.isRegistered<StudentController>()
//           ? Get.find<StudentController>()
//           : Get.put(StudentController());

//   final isLoading = true.obs;
//   final selectedDate = DateTime.now().obs;
//   final attendanceDays = <AttendanceDayModel>[].obs;
//   final availableMonths = <String>[].obs;
//   final selectedFilter = 'all'.obs;

//   int get year => selectedDate.value.year;
//   int get month => selectedDate.value.month;

//   String get currentMonthKey => '${year}_$month';

//   bool get hasPreviousMonth {
//     final previous = DateTime(year, month - 1, 1);
//     final key = '${previous.year}_${previous.month}';
//     return availableMonths.contains(key);
//   }

//   bool get hasNextMonth {
//     final next = DateTime(year, month + 1, 1);
//     final key = '${next.year}_${next.month}';
//     return availableMonths.contains(key);
//   }

//   int get totalDays => DateTime(year, month + 1, 0).day;

//   int get startOffset {
//     final firstDay = DateTime(year, month, 1);
//     return firstDay.weekday % 7;
//   }

//   int get presentCount =>
//       attendanceDays.where((e) => e.status == 'present').length;

//   int get absentCount =>
//       attendanceDays.where((e) => e.status == 'absent').length;

//   int get holidayCount =>
//       attendanceDays.where((e) => e.status == 'holiday').length;

//   int get notMarkedCount =>
//       attendanceDays.where((e) => e.status == 'not_marked').length;

//   int get workingDays => presentCount + absentCount;

//   String get percentage {
//     if (workingDays == 0) return '0%';
//     return '${((presentCount / workingDays) * 100).round()}%';
//   }

//   String get monthName {
//     const months = [
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

//     return months[month - 1];
//   }

//   List<AttendanceDayModel> get markedDays {
//     final list = attendanceDays
//         .where((e) => e.status != 'not_marked')
//         .toList();

//     list.sort((a, b) => b.date.compareTo(a.date));

//     return list;
//   }

//   String getDayName(DateTime date) {
//     const days = [
//       'Monday',
//       'Tuesday',
//       'Wednesday',
//       'Thursday',
//       'Friday',
//       'Saturday',
//       'Sunday',
//     ];

//     return days[date.weekday - 1];
//   }

//   String getDateText(DateTime date) {
//     const months = [
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'May',
//       'Jun',
//       'Jul',
//       'Aug',
//       'Sep',
//       'Oct',
//       'Nov',
//       'Dec',
//     ];

//     return '${date.day} ${months[date.month - 1]}';
//   }

//   String getStatusText(String status) {
//     switch (status) {
//       case 'present':
//         return 'Present';
//       case 'absent':
//         return 'Absent';
//       case 'holiday':
//         return 'Holiday';
//       default:
//         return 'Not Marked';
//     }
//   }

//   List<AttendanceDayModel> get filteredMarkedDays {
//     var list = attendanceDays
//         .where((e) => e.status != 'not_marked')
//         .toList();

//     if (selectedFilter.value != 'all') {
//       list = list
//           .where((e) => e.status == selectedFilter.value)
//           .toList();
//     }

//     list.sort((a, b) => a.date.compareTo(b.date));

//     return list;
//   }

//   String getAttendanceTime(String status) {
//     switch (status) {
//       case 'holiday':
//         return 'Sunday Holiday';
//       case 'present':
//         return 'Attendance Marked';
//       case 'absent':
//         return 'Marked Absent';
//       default:
//         return 'Not Marked';
//     }
//   }

//   @override
//   void onInit() {
//     super.onInit();

//     final args = Get.arguments;

//     if (args != null) {
//       selectedDate.value = DateTime(
//         args['year'],
//         args['month'],
//         1,
//       );
//     }

//     loadInitialData();
//   }

//   Future<void> loadInitialData() async {
//     try {
//       isLoading.value = true;

//       await fetchAvailableMonths();
//       await fetchMonthlyAttendance();
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> fetchMonthlyAttendance() async {
//     try {
//       isLoading.value = true;

//       if (_studentController.student.value == null) {
//         await _studentController.fetchStudent();
//       }

//       final currentStudent = _studentController.student.value;

//       if (currentStudent == null) {
//         Get.snackbar('Error', 'Student data not found');
//         return;
//       }

//       final records = await _attendanceRepository.getMonthlyAttendance(
//         classId: currentStudent.grade.trim(),
//         year: year,
//         month: month,
//         studentUid: currentStudent.uid.trim(),
//       );

//       final List<AttendanceDayModel> days = [];

//       for (int day = 1; day <= totalDays; day++) {
//         final date = DateTime(year, month, day);

//         final dateStr =
//             '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

//         if (date.weekday == DateTime.sunday) {
//           days.add(
//             AttendanceDayModel(
//               date: date,
//               dateStr: dateStr,
//               status: 'holiday',
//             ),
//           );
//         } else {
//           days.add(
//             AttendanceDayModel(
//               date: date,
//               dateStr: dateStr,
//               status: records[dateStr] ?? 'not_marked',
//             ),
//           );
//         }
//       }

//       attendanceDays.assignAll(days);
//     } catch (e) {
//       Get.snackbar('Error', e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void changeFilter(String filter) {
//     selectedFilter.value = filter;
//   }

//   CalendarDayStatus getDayStatus(int day) {
//     final item = attendanceDays.firstWhereOrNull(
//       (e) => e.date.day == day,
//     );

//     switch (item?.status) {
//       case 'present':
//         return CalendarDayStatus.present;
//       case 'absent':
//         return CalendarDayStatus.absent;
//       case 'holiday':
//         return CalendarDayStatus.holiday;
//       case 'not_marked':
//         return CalendarDayStatus.none;
//       default:
//         return CalendarDayStatus.none;
//     }
//   }

//   void previousMonth() {
//     if (!hasPreviousMonth) return;

//     selectedDate.value = DateTime(year, month - 1, 1);
//     fetchMonthlyAttendance();
//   }

//   void nextMonth() {
//     if (!hasNextMonth) return;

//     selectedDate.value = DateTime(year, month + 1, 1);
//     fetchMonthlyAttendance();
//   }

//   void refreshAttendance() {
//     fetchMonthlyAttendance();
//   }

//   Future<void> fetchAvailableMonths() async {
//     if (_studentController.student.value == null) {
//       await _studentController.fetchStudent();
//     }

//     final student = _studentController.student.value;

//     if (student == null) return;

//     final months = await _attendanceRepository.getStudentAttendanceMonths(
//       classId: student.grade.trim(),
//       studentUid: student.uid.trim(),
//     );

//     availableMonths.assignAll(months);
//   }
// }

import 'package:get/get.dart';
import 'package:qr_code_scanner/core/constants/enums.dart';
import 'package:qr_code_scanner/data/models/datafetch/attendance_day_model.dart';
import 'package:qr_code_scanner/data/repositories/DataFetchRepo/attendance_repository.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/student_controller.dart';

class AttendanceController extends GetxController {
  final AttendanceRepository _attendanceRepository = AttendanceRepository();

  final StudentController _studentController =
      Get.isRegistered<StudentController>()
          ? Get.find<StudentController>()
          : Get.put(StudentController());

  final isLoading = true.obs;
  final selectedDate = DateTime.now().obs;
  final attendanceDays = <AttendanceDayModel>[].obs;
  final availableMonths = <String>[].obs;
  final selectedFilter = 'all'.obs;

  int get year => selectedDate.value.year;
  int get month => selectedDate.value.month;

  String get currentMonthKey => '${year}_$month';

  bool get hasPreviousMonth {
    final previous = DateTime(year, month - 1, 1);
    final key = '${previous.year}_${previous.month}';
    return availableMonths.contains(key);
  }

  bool get hasNextMonth {
    final next = DateTime(year, month + 1, 1);
    final key = '${next.year}_${next.month}';
    return availableMonths.contains(key);
  }

  int get totalDays => DateTime(year, month + 1, 0).day;

  int get startOffset {
    final firstDay = DateTime(year, month, 1);
    return firstDay.weekday % 7;
  }

  String _studentClassId(String grade, String section) {
    final cleanGrade = grade.trim();
    final cleanSection = section.trim().toLowerCase();

    if (cleanSection == 'boys') return '${cleanGrade}B';
    if (cleanSection == 'girls') return '${cleanGrade}G';

    return cleanGrade;
  }

  int get presentCount =>
      attendanceDays.where((e) => e.status == 'present').length;

  int get absentCount =>
      attendanceDays.where((e) => e.status == 'absent').length;

  int get holidayCount =>
      attendanceDays.where((e) => e.status == 'holiday').length;

  int get notMarkedCount =>
      attendanceDays.where((e) => e.status == 'not_marked').length;

  int get workingDays => presentCount + absentCount;

  String get percentage {
    if (workingDays == 0) return '0%';
    return '${((presentCount / workingDays) * 100).round()}%';
  }

  String get monthName {
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

    return months[month - 1];
  }

  List<AttendanceDayModel> get markedDays {
    final list =
        attendanceDays.where((e) => e.status != 'not_marked').toList();

    list.sort((a, b) => b.date.compareTo(a.date));

    return list;
  }

  String getDayName(DateTime date) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    return days[date.weekday - 1];
  }

  String getDateText(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${date.day} ${months[date.month - 1]}';
  }

  String getStatusText(String status) {
    switch (status) {
      case 'present':
        return 'Present';
      case 'absent':
        return 'Absent';
      case 'holiday':
        return 'Holiday';
      default:
        return 'Not Marked';
    }
  }

  List<AttendanceDayModel> get filteredMarkedDays {
    var list =
        attendanceDays.where((e) => e.status != 'not_marked').toList();

    if (selectedFilter.value != 'all') {
      list = list.where((e) => e.status == selectedFilter.value).toList();
    }

    list.sort((a, b) => a.date.compareTo(b.date));

    return list;
  }

  String getAttendanceTime(String status) {
    switch (status) {
      case 'holiday':
        return 'Sunday Holiday';
      case 'present':
        return 'Attendance Marked';
      case 'absent':
        return 'Marked Absent';
      default:
        return 'Not Marked';
    }
  }

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    if (args != null) {
      selectedDate.value = DateTime(
        args['year'],
        args['month'],
        1,
      );
    }

    loadInitialData();
  }

  Future<void> loadInitialData() async {
    try {
      isLoading.value = true;

      await fetchAvailableMonths();
      await fetchMonthlyAttendance();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMonthlyAttendance() async {
    try {
      isLoading.value = true;

      if (_studentController.student.value == null) {
        await _studentController.fetchStudent();
      }

      final currentStudent = _studentController.student.value;

      if (currentStudent == null) {
        Get.snackbar('Error', 'Student data not found');
        return;
      }

      final classId = _studentClassId(
        currentStudent.grade,
        currentStudent.section,
      );

      final records = await _attendanceRepository.getMonthlyAttendance(
        classId: classId,
        year: year,
        month: month,
        studentUid: currentStudent.uid.trim(),
      );

      print('GRADE: ${currentStudent.grade}');
print('SECTION: ${currentStudent.section}');
print('CLASS ID: $classId');
print('UID: ${currentStudent.uid}');
print('RECORDS: $records');

      final List<AttendanceDayModel> days = [];

      for (int day = 1; day <= totalDays; day++) {
        final date = DateTime(year, month, day);

        final dateStr =
            '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

        if (date.weekday == DateTime.sunday) {
          days.add(
            AttendanceDayModel(
              date: date,
              dateStr: dateStr,
              status: 'holiday',
            ),
          );
        } else {
          days.add(
            AttendanceDayModel(
              date: date,
              dateStr: dateStr,
              status: records[dateStr] ?? 'not_marked',
            ),
          );
        }
      }

      attendanceDays.assignAll(days);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
  }

  CalendarDayStatus getDayStatus(int day) {
    final item = attendanceDays.firstWhereOrNull(
      (e) => e.date.day == day,
    );

    switch (item?.status) {
      case 'present':
        return CalendarDayStatus.present;
      case 'absent':
        return CalendarDayStatus.absent;
      case 'holiday':
        return CalendarDayStatus.holiday;
      case 'not_marked':
        return CalendarDayStatus.none;
      default:
        return CalendarDayStatus.none;
    }
  }

  void previousMonth() {
    if (!hasPreviousMonth) return;

    selectedDate.value = DateTime(year, month - 1, 1);
    fetchMonthlyAttendance();
  }

  void nextMonth() {
    if (!hasNextMonth) return;

    selectedDate.value = DateTime(year, month + 1, 1);
    fetchMonthlyAttendance();
  }

  void refreshAttendance() {
    fetchMonthlyAttendance();
  }

  Future<void> fetchAvailableMonths() async {
    if (_studentController.student.value == null) {
      await _studentController.fetchStudent();
    }

    final student = _studentController.student.value;

    if (student == null) return;

    final classId = _studentClassId(
      student.grade,
      student.section
    );

    final months = await _attendanceRepository.getStudentAttendanceMonths(
      classId: classId,
      studentUid: student.uid.trim(),
    );

    availableMonths.assignAll(months);
  }
}