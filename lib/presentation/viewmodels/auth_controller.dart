// // // import 'package:get/get.dart';
// // // import 'package:qr_code_scanner/core/utils/app_toast.dart';
// // // import 'package:qr_code_scanner/presentation/bindings/home_binding.dart';
// // // import 'package:qr_code_scanner/presentation/views/login_screen.dart';
// // // import '../../data/repositories/auth_repository.dart';
// // // import '../views/home_screen.dart';

// // // class AuthController extends GetxController {
// // //   final AuthRepository repository;

// // //   AuthController(this.repository);

// // //   final RxBool isLoading = false.obs;

// // //   final RxBool isScanningPermission = false.obs;
// // //   final RxBool isLoggedIn = false.obs;

// // //   final RxString volunteerId = ''.obs;
// // //   final RxString password = ''.obs;

// // //   @override
// // //   void onInit() {
// // //     super.onInit();
// // //     _checkLoginStatus();
// // //   }

// // //   Future<void> _checkLoginStatus() async {
// // //     isLoggedIn.value = await repository.hasToken();
// // //   }

// // // Future<void> login() async {
// // //   try {
// // //     isLoading.value = true;

// // //     final response = await repository.login(
// // //       volunteerId: volunteerId.value,
// // //       password: password.value,
// // //     );

// // // AppToast.success('Login successful');



// // //     isLoggedIn.value = true;
// // //     Get.offAll(() =>  HomeScreen(),binding: HomeBinding());
// // //   } catch (e) {
// // //     AppToast.error(
// // //       e.toString().replaceAll('Exception:', '').trim(),
// // //       title: 'Login Failed',
// // //     );
// // //   } finally {
// // //     isLoading.value = false;
// // //   }

// // // }



// // //   Future<void> logout() async {
// // //     await repository.logout();
// // //     isLoggedIn.value = false;
// // //     Get.offAll(() =>  LoginScreen());
// // //   }


// // //   Future<void> checkScanPermissionAndNavigate() async {
// // //   try {
// // //     isScanningPermission.value = true;

// // //     final response = await repository.checkScanPermission();

// // //     if (response.responseType == 1) {
// // //       Get.to(
// // //         () =>  HomeScreen(),
// // //         binding: HomeBinding(),
// // //       );
// // //     } else {
// // //     AppToast.warning(
// // //   response.message ?? 'Scanning is disabled',
// // //   title: 'Scan Disabled',
// // // );

// // //     }
// // //   } catch (e) {
   
// // //    AppToast.error(
// // //   'Failed to check scan permission',
// // //   title: 'Error',
// // // );

// // //   } finally {
// // //     isScanningPermission.value = false;
// // //   }
// // // }

// // // }



// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // // import 'package:qr_code_scanner/data/repositories/auth_repository.dart';
// // // import 'package:qr_code_scanner/data/services/local_storage_service.dart';
// // // import 'package:qr_code_scanner/presentation/views/home/student_dashboard.dart';
// // // import 'package:qr_code_scanner/presentation/views/home_screen.dart';
// // // import 'package:qr_code_scanner/presentation/views/login_screen.dart';



// // // class AuthController extends GetxController {
// // //     final AuthRepository _authRepository =
// // //       Get.find<AuthRepository>();
// // // final email = ''.obs;
// // // final password = ''.obs;
// // // final isScanningPermission = false.obs;
// // // // final isLoading = false.obs;
// // // RxBool isLoggedIn = false.obs;
// // //   final emailController = TextEditingController();
// // //   final passwordController = TextEditingController();

// // //   RxBool isLoading = false.obs;

// // //   Future<void> login() async {
// // //     final email = emailController.text.trim();
// // //     final password = passwordController.text.trim();

// // //     if (email.isEmpty || password.isEmpty) {
// // //       Get.snackbar(
// // //         "Error",
// // //         "Email and Password required",
// // //       );
// // //       return;
// // //     }

// // //     try {
// // //       isLoading.value = true;

// // //       await _authRepository.login(
// // //         email: email,
// // //         password: password,
// // //       );

// // //       /// SAVE LOGIN
// // //       await LocalStorageService.saveUserLogin(
// // //         email: email,
// // //       );

// // //       Get.offAll(() =>  StudentDashboard());

// // //       Get.snackbar(
// // //         "Success",
// // //         "Login Successful",
// // //       );
// // //     } catch (e) {
// // //       Get.snackbar(
// // //         "Login Failed",
// // //         e.toString(),
// // //       );
// // //     } finally {
// // //       isLoading.value = false;
// // //     }
// // //   }

// // //   Future<void> logout() async {
// // //     await _authRepository.logout();

// // //     await LocalStorageService.clearUserData();

// // //     Get.offAll(() => LoginScreen());
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';

// // import 'package:qr_code_scanner/data/repositories/auth_repository.dart';
// // import 'package:qr_code_scanner/data/services/local_storage_service.dart';
// // import 'package:qr_code_scanner/presentation/views/home/student_dashboard.dart';
// // import 'package:qr_code_scanner/presentation/views/login_screen.dart';
// // // import 'package:qr_code_scanner/presentation/views/qr_scanner_screen.dart';

// // class AuthController extends GetxController {
// //   final AuthRepository _authRepository = Get.find<AuthRepository>();

// //   final emailController = TextEditingController();
// //   final passwordController = TextEditingController();

// //   final email = ''.obs;
// //   final password = ''.obs;

// //   final isLoading = false.obs;
// //   final isLoggedIn = false.obs;
// //   final isScanningPermission = false.obs;

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     checkLoginStatus();
// //   }

// //   Future<void> checkLoginStatus() async {
// //     isLoggedIn.value = await LocalStorageService.isLoggedIn();
// //   }

// //   Future<void> login() async {
// //     final userEmail = emailController.text.trim().isNotEmpty
// //         ? emailController.text.trim()
// //         : email.value.trim();

// //     final userPassword = passwordController.text.trim().isNotEmpty
// //         ? passwordController.text.trim()
// //         : password.value.trim();

// //     if (userEmail.isEmpty || userPassword.isEmpty) {
// //       Get.snackbar('Error', 'Email and Password required');
// //       return;
// //     }

// //     try {
// //       isLoading.value = true;

// //       await _authRepository.login(
// //         email: userEmail,
// //         password: userPassword,
// //       );

// //       await LocalStorageService.saveUserLogin(
// //         email: userEmail,
// //       );

// //       isLoggedIn.value = true;

// //       Get.offAll(() => StudentDashboard());

// //       Get.snackbar('Success', 'Login Successful');
// //     } catch (e) {
// //       Get.snackbar(
// //         'Login Failed',
// //         e.toString().replaceAll('Exception: ', ''),
// //       );
// //     } finally {
// //       isLoading.value = false;
// //     }
// //   }

// //   Future<void> logout() async {
// //     await _authRepository.logout();
// //     await LocalStorageService.clearUserData();

// //     isLoggedIn.value = false;
// //     emailController.clear();
// //     passwordController.clear();
// //     email.value = '';
// //     password.value = '';

// //     Get.offAll(() => LoginScreen());
// //   }

// //   Future<void> checkScanPermissionAndNavigate() async {
// //     try {
// //       isScanningPermission.value = true;

// //       await Future.delayed(const Duration(milliseconds: 500));

// //       // Yahan apni scanner screen ka route lagana:
// //       // Get.to(() => const QrScannerScreen());

// //     } catch (e) {
// //       Get.snackbar('Error', 'Unable to open scanner');
// //     } finally {
// //       isScanningPermission.value = false;
// //     }
// //   }

// //   @override
// //   void onClose() {
// //     emailController.dispose();
// //     passwordController.dispose();
// //     super.onClose();
// //   }
// // }
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:qr_code_scanner/data/repositories/auth_repository.dart';
// import 'package:qr_code_scanner/data/services/local_storage_service.dart';
// import 'package:qr_code_scanner/presentation/views/home/student_dashboard.dart';
// import 'package:qr_code_scanner/presentation/views/login_screen.dart';

// class AuthController extends GetxController {
//   final AuthRepository _authRepository = Get.find<AuthRepository>();

//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   final email = ''.obs;
//   final password = ''.obs;

//   final isLoading = false.obs;
//   final isLoggedIn = false.obs;
//   final isScanningPermission = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     checkLoginStatus();
//   }

//   Future<void> checkLoginStatus() async {
//     final localLogin = await LocalStorageService.isLoggedIn();

//     if (!localLogin) {
//       isLoggedIn.value = false;
//       return;
//     }

//     final currentUser = FirebaseAuth.instance.currentUser;

//     if (currentUser == null) {
//       await LocalStorageService.clearUserData();
//       isLoggedIn.value = false;
//       return;
//     }

//     isLoggedIn.value = true;
//   }

//   Future<void> login() async {
//     final userEmail = emailController.text.trim().isNotEmpty
//         ? emailController.text.trim()
//         : email.value.trim();

//     final userPassword = passwordController.text.trim().isNotEmpty
//         ? passwordController.text.trim()
//         : password.value.trim();

//     if (userEmail.isEmpty || userPassword.isEmpty) {
//       Get.snackbar('Error', 'Email and Password required');
//       return;
//     }

//     try {
//       isLoading.value = true;

//       await _authRepository.login(
//         email: userEmail,
//         password: userPassword,
//       );

//       await LocalStorageService.saveUserLogin(
//         email: userEmail,
//       );

//       isLoggedIn.value = true;

//       emailController.clear();
//       passwordController.clear();
//       email.value = '';
//       password.value = '';

//       Get.offAll(() => StudentDashboard());

//       Get.snackbar('Success', 'Login Successful');
//     } catch (e) {
//       await LocalStorageService.clearUserData();
//       isLoggedIn.value = false;

//       Get.snackbar(
//         'Login Failed',
//         e.toString().replaceAll('Exception: ', ''),
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> forceLogout({
//     String title = 'Session Expired',
//     String message = 'Please login again.',
//   }) async {
//     try {
//       await _authRepository.logout();
//     } catch (_) {}

//     await LocalStorageService.clearUserData();

//     isLoggedIn.value = false;

//     emailController.clear();
//     passwordController.clear();
//     email.value = '';
//     password.value = '';

//     Get.offAll(() => LoginScreen());

//     Get.snackbar(title, message);
//   }

//   Future<void> logout() async {
//     await forceLogout(
//       title: 'Logout',
//       message: 'Logged out successfully',
//     );
//   }

//   Future<void> checkScanPermissionAndNavigate() async {
//     try {
//       isScanningPermission.value = true;

//       await Future.delayed(const Duration(milliseconds: 500));

//       // Scanner screen route yahan lagao:
//       // Get.to(() => const QrScannerScreen());
//     } catch (e) {
//       Get.snackbar('Error', 'Unable to open scanner');
//     } finally {
//       isScanningPermission.value = false;
//     }
//   }

//   @override
//   void onClose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.onClose();
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:qr_code_scanner/data/repositories/auth_repository.dart';
import 'package:qr_code_scanner/data/services/local_storage_service.dart';

import 'package:qr_code_scanner/presentation/views/home/student_dashboard.dart';
import 'package:qr_code_scanner/presentation/views/login_screen.dart';

class AuthController extends GetxController {

  final AuthRepository _authRepository =
      Get.find<AuthRepository>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final isLoading = false.obs;

  final isLoggedIn = false.obs;
  final email = ''.obs;
final password = ''.obs;

  final isScanningPermission = false.obs;

  @override
  void onInit() {
    super.onInit();

    checkLoginStatus();
  }

  /// CHECK LOGIN STATUS
  Future<void> checkLoginStatus() async {

    try {

      final localLogin =
          await LocalStorageService.isLoggedIn();

      /// LOCAL FALSE
      if (!localLogin) {

        isLoggedIn.value = false;

        Get.offAll(() => LoginScreen());

        return;
      }

      /// FIREBASE USER
      final firebaseUser =
          FirebaseAuth.instance.currentUser;

      /// USER REMOVED FROM FIREBASE
      if (firebaseUser == null) {

        await clearSession();

        Get.offAll(() => LoginScreen());

        return;
      }

      /// FORCE REFRESH USER
      await firebaseUser.reload();

      final refreshedUser =
          FirebaseAuth.instance.currentUser;

      /// USER DELETED
      if (refreshedUser == null) {

        await clearSession();

        Get.offAll(() => LoginScreen());

        return;
      }

      isLoggedIn.value = true;

    } catch (e) {

      await clearSession();

      Get.offAll(() => LoginScreen());
    }
  }

  /// LOGIN
  Future<void> login() async {

    final email =
        emailController.text.trim();

    final password =
        passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {

      Get.snackbar(
        'Error',
        'Email and password required',
      );

      return;
    }

    try {

      isLoading.value = true;

      /// FIREBASE LOGIN
      await _authRepository.login(
        email: email,
        password: password,
      );

      /// SAVE LOCAL
      await LocalStorageService.saveUserLogin(
        email: email,
      );

      isLoggedIn.value = true;

      /// CLEAR FIELDS
      emailController.clear();
      passwordController.clear();

      /// GO DASHBOARD
      Get.offAll(() => StudentDashboard());

      Get.snackbar(
        'Success',
        'Login successful',
      );

    } catch (e) {

      await clearSession();

      Get.snackbar(
        'Login Failed',
        e.toString().replaceAll(
          'Exception: ',
          '',
        ),
      );

    } finally {

      isLoading.value = false;
    }
  }

  /// LOGOUT
  Future<void> logout() async {

    await clearSession();

    Get.offAll(() => LoginScreen());
  }

  /// CLEAR SESSION
  Future<void> clearSession() async {

    try {
      await _authRepository.logout();
    } catch (_) {}

    await LocalStorageService.clearUserData();

    isLoggedIn.value = false;

    emailController.clear();
    passwordController.clear();
  }

  /// SCANNER
  Future<void> checkScanPermissionAndNavigate() async {

    try {

      isScanningPermission.value = true;

      await Future.delayed(
        const Duration(milliseconds: 500),
      );

      // Get.to(() => ScannerScreen());

    } catch (e) {

      Get.snackbar(
        'Error',
        'Unable to open scanner',
      );

    } finally {

      isScanningPermission.value = false;
    }
  }

  @override
  void onClose() {

    emailController.dispose();

    passwordController.dispose();

    super.onClose();
  }
}