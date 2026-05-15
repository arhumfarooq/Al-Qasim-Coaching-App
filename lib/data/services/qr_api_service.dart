import 'dart:convert';
import '../../core/constants/api_constants.dart';
import '../../core/network/api_client.dart';
import '../models/qr_scan_model.dart';
import '../models/api_response_model.dart';

class QrApiService {
  final ApiClient _client;

  QrApiService(this._client);

  Future<ApiResponseModel> submitQr(QrScanModel model) async {
   final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.submitQr)
    .replace(queryParameters: {
  'id': model.code,
});

final response = await _client.post(uri.toString());
    if (response.statusCode != 200) {
      throw Exception("Failed to submit QR");
    }

    if (response.body.isEmpty) {
      throw Exception("Empty response from server");
    }

    final Map<String, dynamic> json =
        jsonDecode(response.body) as Map<String, dynamic>;

    return ApiResponseModel.fromJson(json);
  }
}
