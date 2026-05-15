import 'package:get/get.dart';
import 'package:qr_code_scanner/core/network/api_client.dart';
import 'package:qr_code_scanner/data/repositories/tokens_repository_impl.dart';
import 'package:qr_code_scanner/data/repositories/volunteer_repositoryImpl.dart';
import 'package:qr_code_scanner/data/services/tokens_api_service.dart';
import 'package:qr_code_scanner/data/services/volunteer_api_service.dart';
import 'package:qr_code_scanner/domain/repositories/tokens_repository.dart';
import 'package:qr_code_scanner/domain/repositories/volunteer_repository.dart';
import 'package:qr_code_scanner/presentation/viewmodels/tokens_controller.dart';
import 'package:qr_code_scanner/presentation/viewmodels/volunteer_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => ApiClient());
    // API service
    Get.lazyPut<PendingTokensApiService>(
      () => PendingTokensApiService(Get.find()),
    );

    // Repository (IMPORTANT PART)
    Get.lazyPut<PendingTokensRepository>(
      () => PendingTokensRepositoryImpl(Get.find()),
    );

    // Controller
    Get.lazyPut<PendingTokensController>(
      () => PendingTokensController(Get.find()),
    );

   // API Service
    Get.lazyPut(() => VolunteerApiService(Get.find<ApiClient>()));

    // Repository (abstract → implementation)
    Get.lazyPut<VolunteerRepository>(
      () => VolunteerRepositoryImpl(Get.find<VolunteerApiService>()),
    );

    // Controller / ViewModel
    Get.lazyPut(
      () => VolunteerController(Get.find<VolunteerRepository>()),
    );

  }
}
