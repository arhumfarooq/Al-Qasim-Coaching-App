import 'package:get/get.dart';
import 'package:qr_code_scanner/data/models/datafetch/student_model.dart';
import 'package:qr_code_scanner/data/models/datafetch/test_result_model.dart';
import 'package:qr_code_scanner/data/repositories/DataFetchRepo/test_result_repository.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/student_controller.dart';

class TestResultController extends GetxController {
  final TestResultRepository _repository = TestResultRepository();

  final StudentController _studentController =
      Get.isRegistered<StudentController>()
          ? Get.find<StudentController>()
          : Get.put(StudentController());

  final isLoading = true.obs;
  final results = <TestResultModel>[].obs;

  int get totalTests => results.length;

  double get averagePercentage {
    if (results.isEmpty) return 0;

    final total = results.fold<double>(
      0,
      (sum, item) => sum + item.percentage,
    );

    return total / results.length;
  }

  TestResultModel? get highestResult {
    if (results.isEmpty) return null;

    final list = [...results];
    list.sort((a, b) => b.percentage.compareTo(a.percentage));

    return list.first;
  }

  @override
  void onInit() {
    super.onInit();
    fetchResults();
  }

  Future<void> fetchResults() async {
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

      // final data = await _repository.getStudentResults(
      //   classId: student.grade.trim(),
      //   studentUid: student.uid.trim(),
      // );

      final data = await _repository.getStudentResults(
  classId: student.grade.trim(),
  rollNo: student.rollNo.trim(),
);

      results.assignAll(data);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  double get averageScore {
  if (results.isEmpty) return 0;

  final total = results.fold<double>(
    0,
    (sum, item) => sum + item.percentage,
  );

  return total / results.length;
}

int get testsTaken => results.length;

int get bestScore {
  if (results.isEmpty) return 0;

  final best = results
      .map((e) => e.percentage)
      .reduce((a, b) => a > b ? a : b);

  return best.round();
}

int get averageRank {
  // Rank data DB me nahi hai
  // temporary dummy calculation
  if (averageScore >= 90) return 1;
  if (averageScore >= 80) return 3;
  if (averageScore >= 70) return 5;
  return 10;
}

Map<int, double> get monthlyAverageScores {
  final Map<int, List<double>> grouped = {};

  for (final item in results) {
    final month = item.testDate.month;

    grouped.putIfAbsent(month, () => []);
    grouped[month]!.add(item.percentage);
  }

  final Map<int, double> averages = {};

  grouped.forEach((month, scores) {
    final total = scores.fold<double>(0, (sum, score) => sum + score);
    averages[month] = total / scores.length;
  });

  return averages;
}



List<TestResultModel> get recentMonthResults {
  if (results.isEmpty) return [];

  final now = DateTime.now();

  final currentMonthResults = results.where((item) {
    return item.testDate.year == now.year &&
        item.testDate.month == now.month;
  }).toList();

  if (currentMonthResults.isNotEmpty) {
    currentMonthResults.sort(
      (a, b) => b.testDate.compareTo(a.testDate),
    );

    return currentMonthResults.take(3).toList();
  }

  final previousResults = results.where((item) {
    final itemMonth = DateTime(
      item.testDate.year,
      item.testDate.month,
    );

    final currentMonth = DateTime(
      now.year,
      now.month,
    );

    return itemMonth.isBefore(currentMonth);
  }).toList();

  previousResults.sort(
    (a, b) => b.testDate.compareTo(a.testDate),
  );

  if (previousResults.isEmpty) return [];

  final latest = previousResults.first;

  final latestMonthResults = previousResults.where((item) {
    return item.testDate.year == latest.testDate.year &&
        item.testDate.month == latest.testDate.month;
  }).toList();

  return latestMonthResults.take(3).toList();
}


TestResultModel? get latestResult {
  if (results.isEmpty) return null;

  final sorted = [...results];

  sorted.sort(
    (a, b) => b.testDate.compareTo(a.testDate),
  );

  return sorted.first;
}


StudentModel? get currentStudent =>
    _studentController.student.value;




    // Montthly Test section


    final selectedMonth = DateTime.now().month.obs;
final selectedYear = DateTime.now().year.obs;

String get selectedMonthName {
  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  return months[selectedMonth.value - 1];
}

List<TestResultModel> get selectedMonthResults {
  return results.where((item) {
    return item.testDate.year == selectedYear.value &&
        item.testDate.month == selectedMonth.value;
  }).toList();
}

bool isFutureMonth(int month) {
  final now = DateTime.now();

  return selectedYear.value == now.year && month > now.month;
}

void changeMonth(int month) {
  if (isFutureMonth(month)) return;

  selectedMonth.value = month;
}

}