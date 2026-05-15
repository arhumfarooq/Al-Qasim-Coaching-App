import 'dart:convert';
import '../../core/constants/api_constants.dart';
import '../../core/network/api_client.dart';
import '../models/pending_token_model.dart';

class PendingTokensApiService {
  final ApiClient _client;

  PendingTokensApiService(this._client);

  Future<List<PendingTokenModel>> fetchPendingTokens() async {
    final uri = Uri.parse(
      ApiConstants.baseUrl + ApiConstants.loadPendingTokens,
    ).replace(
      queryParameters: {
        'Id': '0',
      },
    );

    final response = await _client.get(uri.toString());
    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load pending tokens (${response.statusCode})',
      );
    }

    if (response.body.isEmpty) {
      throw Exception('Empty response from server');
    }

    final List<dynamic> jsonList =
        jsonDecode(response.body) as List<dynamic>;

    return jsonList
        .map((e) => PendingTokenModel.fromJson(e))
        .toList();
  }
}
