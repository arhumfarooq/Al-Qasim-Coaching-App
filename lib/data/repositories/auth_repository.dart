// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:qr_code_scanner/core/constants/api_constants.dart';
// import 'package:qr_code_scanner/core/network/api_client.dart';
// import 'package:qr_code_scanner/core/network/api_response.dart';

// class AuthRepository {
//   final FlutterSecureStorage _storage;
//   final ApiClient _apiClient;

//   AuthRepository({
//     FlutterSecureStorage? storage,
//     ApiClient? apiClient,
//   })  : _storage = storage ?? const FlutterSecureStorage(),
//         _apiClient = apiClient ?? ApiClient();

// Future<ApiResponse<void>> login({
//   required String volunteerId,
//   required String password,
// }) async {
//   final response = await _apiClient.post(
//     "${ApiConstants.baseUrl}${ApiConstants.login}",
//     body: {
//       'volunteerId': volunteerId,
//       'password': password,
//     },
//   );
//   final decoded = jsonDecode(response.body);

//   final apiResponse = ApiResponse<void>.fromJson(decoded);
//   // ✅ SUCCESS
//   if (apiResponse.responseType == 1 && apiResponse.tokenKey != null) {
//     await _storage.write(
//       key: 'token',
//       value: apiResponse.tokenKey!,
//     );
//     return apiResponse;
//   }

//   // ❌ FAILURE
//   throw Exception(apiResponse.message ?? 'Login failed');
// }

// Future<ApiResponse<void>> checkScanPermission() async {
//   final response = await _apiClient.get(
//     "${ApiConstants.baseUrl}${ApiConstants.allowScaning}",
//   );

//   final decoded = jsonDecode(response.body);
//   return ApiResponse<void>.fromJson(decoded);
// }

//   /// 🔎 Check existing session
//   Future<bool> hasToken() async {
//     final token = await _storage.read(key: 'token');
//     return token != null && token.isNotEmpty;
//   }

//   /// 🚪 Logout
//   Future<void> logout() async {
//     await _storage.delete(key: 'token');
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// LOGIN
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {

      switch (e.code) {

        case 'user-not-found':
          throw Exception('User not found');

        case 'wrong-password':
          throw Exception('Wrong password');

        case 'invalid-email':
          throw Exception('Invalid email');

        case 'invalid-credential':
          throw Exception('Invalid email or password');

        default:
          throw Exception(
            e.message ?? 'Login failed',
          );
      }
    }
  }

  /// CURRENT USER
  User? get currentUser => _auth.currentUser;

  /// CHECK LOGIN
  bool get isLoggedIn => _auth.currentUser != null;

  /// LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }
}