import 'package:qr_code_scanner/data/models/volunteer_model.dart';

abstract class VolunteerRepository {
  Future<List<Volunteer>> fetchPendingVolunteers();
    Future<void> approveVolunteer(int id);

}
