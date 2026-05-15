import '../../data/models/api_response_model.dart';

abstract class QrRepository {
  Future<ApiResponseModel> submitQr(String code);
}
