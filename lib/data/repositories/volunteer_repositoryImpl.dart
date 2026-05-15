import 'package:qr_code_scanner/data/models/volunteer_model.dart';
import 'package:qr_code_scanner/data/services/volunteer_api_service.dart';
import 'package:qr_code_scanner/domain/repositories/volunteer_repository.dart';

class VolunteerRepositoryImpl implements VolunteerRepository {
  final VolunteerApiService service;

  VolunteerRepositoryImpl(this.service);

  @override
  Future<List<Volunteer>> fetchPendingVolunteers() async {
    final all = await service.fetchVolunteers();

    return all
        .where((v) => v.userStatus == 'Pending')
        .toList();
  }
    @override
  Future<void> approveVolunteer(int id) {
    return service.approveVolunteer(id);
  }
}
