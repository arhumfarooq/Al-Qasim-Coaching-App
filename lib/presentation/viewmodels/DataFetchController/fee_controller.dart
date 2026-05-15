import 'package:get/get.dart';
import 'package:qr_code_scanner/data/models/datafetch/fee_model.dart';
import 'package:qr_code_scanner/data/models/datafetch/student_model.dart';
import 'package:qr_code_scanner/data/repositories/DataFetchRepo/fee_repository.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/student_controller.dart';

class FeesController extends GetxController {
  final FeeRepository _repository = FeeRepository();

  final StudentController _studentController =
      Get.isRegistered<StudentController>()
          ? Get.find<StudentController>()
          : Get.put(StudentController());

  final isLoading = true.obs;
  final fees = <FeeModel>[].obs;

  int get paidCount =>
      fees.where((e) => e.status == 'paid').length;

  int get unpaidCount =>
      fees.where((e) => e.status == 'unpaid').length;

  int get pendingCount =>
      fees.where((e) => e.status == 'pending').length;

  FeeModel? get latestFee {
    if (fees.isEmpty) return null;
    return fees.first;
  }

  @override
  void onInit() {
     setInitialMonthFromArgs();
    super.onInit();
    fetchFees();
  }

  Future<void> fetchFees() async {
    try {
      isLoading.value = true;

      if (_studentController.student.value == null) {
        await _studentController.fetchStudent();
      }

      final student = _studentController.student.value;

      if (student == null) {
        Get.snackbar('Error', 'Student data not found');
        return;
      }

      final data = await _repository.getStudentFees(
        studentId: student.uid.trim(),
      );

      fees.assignAll(data);
      loadAvailableYears();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }


List<FeeModel> get unpaidFees {
  return fees
      .where((e) => e.status != 'paid')
      .toList()
    ..sort((a, b) => a.month.compareTo(b.month));
}


  String formatMonth(String monthKey) {
    final parts = monthKey.split('-');

    if (parts.length != 2) return monthKey;

    final year = parts[0];
    final month = int.tryParse(parts[1]) ?? 1;

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

    return '${months[month - 1]} $year';
  }



StudentModel? get currentStudent =>
    _studentController.student.value;

List<Map<String, dynamic>> get pendingAndUpcomingMonths {
  final now = DateTime.now();
  final currentMonth = DateTime(now.year, now.month, 1);

  final paidMonthKeys = fees
      .where((e) => e.status == 'paid')
      .map((e) => e.month)
      .toSet();

  final List<Map<String, dynamic>> list = [];

  // Current year January se current month tak unpaid/pending check
  for (int m = 1; m <= now.month; m++) {
    final monthKey =
        '${now.year}-${m.toString().padLeft(2, '0')}';

    if (!paidMonthKeys.contains(monthKey)) {
      list.add({
        'monthKey': monthKey,
        'status': 'Unpaid',
        'date': DateTime(now.year, m, 1),
      });
    }
  }

  // Next 2 upcoming months
  for (int i = 1; i <= 2; i++) {
    final date = DateTime(now.year, now.month + i, 1);

    final monthKey =
        '${date.year}-${date.month.toString().padLeft(2, '0')}';

    if (!paidMonthKeys.contains(monthKey)) {
      list.add({
        'monthKey': monthKey,
        'status': 'Upcoming',
        'date': date,
      });
    }
  }

  return list;
}


final selectedYear = DateTime.now().year.obs;
final selectedMonth = DateTime.now().month.obs;

String get selectedMonthKey =>
    '${selectedYear.value}-${selectedMonth.value.toString().padLeft(2, '0')}';

FeeModel? get selectedFee {
  return fees.firstWhereOrNull(
    (e) => e.month == selectedMonthKey,
  );
}

void changeSelectedMonth(int month) {
  selectedMonth.value = month;
}

void setInitialMonthFromArgs() {
  final args = Get.arguments;

  if (args != null) {
    selectedYear.value = args['year'];
    selectedMonth.value = args['month'];
  }
}





// final selectedYear = DateTime.now().year.obs;
final availableYears = <int>[].obs;

String get selectedYearText =>
    '${selectedYear.value} - ${selectedYear.value + 1}';

bool get hasPreviousYear =>
    availableYears.any((year) => year < selectedYear.value);

bool get hasNextYear =>
    availableYears.any((year) => year > selectedYear.value);

int? get previousAvailableYear {
  final years = availableYears.where((year) => year < selectedYear.value).toList()
    ..sort();
  return years.isEmpty ? null : years.last;
}

int? get nextAvailableYear {
  final years = availableYears.where((year) => year > selectedYear.value).toList()
    ..sort();
  return years.isEmpty ? null : years.first;
}

void previousYear() {
  final year = previousAvailableYear;
  if (year == null) return;
  selectedYear.value = year;
}

void nextYear() {
  final year = nextAvailableYear;
  if (year == null) return;
  selectedYear.value = year;
}

void loadAvailableYears() {
  final years = fees.map((fee) {
    final parts = fee.month.split('-');
    return int.tryParse(parts.first) ?? DateTime.now().year;
  }).toSet().toList()
    ..sort();

  if (years.isEmpty) {
    availableYears.assignAll([DateTime.now().year]);
  } else {
    availableYears.assignAll(years);
  }

  if (!availableYears.contains(selectedYear.value)) {
    selectedYear.value = availableYears.last;
  }
}

}