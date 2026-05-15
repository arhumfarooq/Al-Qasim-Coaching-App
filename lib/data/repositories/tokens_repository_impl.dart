

import 'package:qr_code_scanner/data/services/tokens_api_service.dart';
import 'package:qr_code_scanner/domain/repositories/tokens_repository.dart';

import '../models/pending_token_model.dart';

class PendingTokensRepositoryImpl implements PendingTokensRepository {
  final PendingTokensApiService _service;

  PendingTokensRepositoryImpl(this._service);

  @override
  Future<List<PendingTokenModel>> fetchPendingTokens() async {
    try {
      return await _service.fetchPendingTokens();
    } catch (e, stackTrace) {
      rethrow;
    }
  }
}
