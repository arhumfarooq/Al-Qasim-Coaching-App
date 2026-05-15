import 'package:get/get.dart';
import 'package:qr_code_scanner/data/models/datafetch/student_model.dart';
// import 'package:qr_code_scanner/data/models/student_model.dart';
import 'package:qr_code_scanner/data/repositories/DataFetchRepo/student_repositry.dart';
// import 'package:qr_code_scanner/data/repositories/student_repository.dart';
import 'package:qr_code_scanner/data/services/local_storage_service.dart';

class StudentController extends GetxController {
  final StudentRepository _studentRepository = Get.put(StudentRepository());

  final isLoading = false.obs;
  final student = Rxn<StudentModel>();

  @override
  void onInit() {
    super.onInit();
    fetchStudent();
  }

  Future<void> fetchStudent() async {
    try {
      isLoading.value = true;

      final email = await LocalStorageService.getUserEmail();
          print("SAVED EMAIL: $email");


      if (email == null || email.isEmpty) {
        Get.snackbar('Error', 'User email not found');
        return;
      }

      final result = await _studentRepository.getStudentByEmail(email);
          print("STUDENT RESULT: $result");


      if (result == null) {
        Get.snackbar('Error', 'Student data not found');
        return;
      }

      student.value = result;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}