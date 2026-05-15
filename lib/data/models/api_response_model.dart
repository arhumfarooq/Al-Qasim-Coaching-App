class ApiResponseModel {
  final int? responseType;
  final String? message;
  final int? statusAPI;

  ApiResponseModel({
    this.responseType,
    this.message,
    this.statusAPI,
  });

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ApiResponseModel(
      responseType: json['responseType'],
      message: json['message'],
      statusAPI: json['statusAPI'],
    );
  }
}
