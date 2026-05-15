import 'package:get/get.dart';
import 'package:qr_code_scanner/data/repositories/DataFetchRepo/student_repositry.dart';
import 'package:qr_code_scanner/data/repositories/auth_repository.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/student_controller.dart';
import 'package:qr_code_scanner/presentation/viewmodels/auth_controller.dart';
import '../../core/network/api_client.dart';
import '../../data/repositories/qr_repository_impl.dart';
import '../../data/services/qr_api_service.dart';
import '../../domain/repositories/qr_repository.dart';
import '../../presentation/viewmodels/qr_viewmodel.dart';

class QrBinding extends Bindings {
  @override
  void dependencies() {
    // API client
    Get.lazyPut(() => ApiClient());

    // API service
    Get.lazyPut(() => QrApiService(Get.find()));
    Get.put<AuthRepository>(AuthRepository(), permanent: true);
    // Get.put<AuthController>(
    //   // AuthController(Get.find<AuthRepository>()),
      
    //   permanent: true,
    // );
    Get.put<AuthController>(
  AuthController(),
  permanent: true,
);
    // Repository: bind abstract type to implementation
    Get.lazyPut<QrRepository>(() => QrRepositoryImpl(Get.find()));

    // ViewModel depends on QrRepository
    Get.lazyPut(() => QrViewModel(Get.find<QrRepository>()));

//     Get.lazyPut<StudentRepository>(() => StudentRepository());
// Get.lazyPut<StudentController>(() => StudentController());
  }
}
