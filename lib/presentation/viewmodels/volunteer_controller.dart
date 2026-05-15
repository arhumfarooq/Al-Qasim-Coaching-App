


import 'package:get/get.dart';
import 'package:qr_code_scanner/core/utils/app_toast.dart';
import '../../data/models/volunteer_model.dart';
import '../../domain/repositories/volunteer_repository.dart';

class VolunteerController extends GetxController {
  final VolunteerRepository repository;
  VolunteerController(this.repository);

  final RxList<Volunteer> volunteers = <Volunteer>[].obs;
  final RxSet<int> approvingIds = <int>{}.obs; 
  final RxBool isLoading = false.obs;
  final RxInt listCount = 0.obs;
  @override
  void onInit() {
    super.onInit();
    loadVolunteers();
  }

  Future<void> loadVolunteers() async {
    try {
      isLoading.value = true;
      volunteers.assignAll(await repository.fetchPendingVolunteers());
      listCount.value = volunteers.length;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> approveVolunteer(int id) async {
    approvingIds.add(id); // Start loading
    try {
      await repository.approveVolunteer(id);
      volunteers.removeWhere((v) => v.id == id);
    AppToast.success(
  'Volunteer approved successfully',
  title: 'Success',
);

    } catch (e) {
    AppToast.error(
  'Failed to approve volunteer',
  title: 'Error',
);

    } finally {
      approvingIds.remove(id); // Always stop loading
    }
  }
}