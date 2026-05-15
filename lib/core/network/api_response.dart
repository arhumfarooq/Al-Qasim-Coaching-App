class ApiResponse<T> {
  final int? responseType;
  final String? message;
  final String? tokenKey;

  ApiResponse({
    required this.responseType,
    this.message,
    this.tokenKey,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      responseType: json['responseType'],
      message: json['message'],
      tokenKey: json['tokenKey'],
    );
  }
}
