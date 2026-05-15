import '../../data/models/pending_token_model.dart';

abstract class PendingTokensRepository {
  Future<List<PendingTokenModel>> fetchPendingTokens();
}
