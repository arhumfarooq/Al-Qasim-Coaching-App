import 'dart:convert';
import 'package:qr_code_scanner/core/constants/api_constants.dart';

import '../../core/network/api_client.dart';
import '../models/volunteer_model.dart';

class VolunteerApiService {
  final ApiClient _client;

  VolunteerApiService(this._client);

  Future<List<Volunteer>> fetchVolunteers() async {
 final response = await _client.get(
  "${ApiConstants.baseUrl}${ApiConstants.loadVolunteers}",
);


    if (response.statusCode != 200) {
      throw Exception('Failed to load volunteers');
    }

    final List list = jsonDecode(response.body);
    return list.map((e) => Volunteer.fromJson(e)).toList();
  }


  Future<void> approveVolunteer(int id) async {
    final response = await _client.post(
      "${ApiConstants.baseUrl}${ApiConstants.approveVolunteer}?id=$id",
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to approve volunteer');
    }
  }
}
