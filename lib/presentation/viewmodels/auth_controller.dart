

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/core/utils/app_toast.dart';

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

final emailError = RxnString();
final passwordError = RxnString();
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

 


// Future<void> login() async {

//   emailError.value = null;
//   passwordError.value = null;

//   final inputEmail = emailController.text.trim();
//   final inputPassword = passwordController.text.trim();

//   bool hasError = false;

//   /// EMAIL EMPTY
//   if (inputEmail.isEmpty) {
//     emailError.value = 'Please enter your email';
//     hasError = true;
//   }

//   /// INVALID EMAIL
//   else if (!GetUtils.isEmail(inputEmail)) {
//     emailError.value = 'Enter a valid email';
//     hasError = true;
//   }

//   /// PASSWORD EMPTY
//   // /// PASSWORD EMPTY
// if (inputPassword.isEmpty) {
//   passwordError.value = 'Please enter your password';
//   hasError = true;
// }

// /// PASSWORD LENGTH
// else if (inputPassword.length < 6) {
//   passwordError.value =
//       'Password must be at least 6 characters';
//   hasError = true;
// }

// /// SPECIAL CHARACTER CHECK
// else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
//     .hasMatch(inputPassword)) {
//   passwordError.value =
//       'Password must contain a special character';
//   hasError = true;
// }

//   /// STOP LOGIN
//   if (hasError) return;

//   try {

//     isLoading.value = true;

//     await _authRepository.login(
//       email: inputEmail,
//       password: inputPassword,
//     );

//     await LocalStorageService.saveUserLogin(
//       email: inputEmail,
//     );

//     isLoggedIn.value = true;

//     emailController.clear();
//     passwordController.clear();

//     Get.offAll(() => StudentDashboard());

//   } catch (e) {

//     await clearSession();

//     /// FIREBASE ERROR
//     emailError.value = 'Enter a valid email';
//     passwordError.value = 'Enter a valid password';

//     // /// CLEAR FIELDS
//     // emailController.clear();
//     // passwordController.clear();

//   } finally {

//     isLoading.value = false;
//   }
// }


Future<void> login() async {
  emailError.value = null;
  passwordError.value = null;

  final inputEmail = emailController.text.trim();
  final inputPassword = passwordController.text.trim();

  bool hasError = false;

  /// EMAIL VALIDATION
  if (inputEmail.isEmpty) {
    emailError.value = 'Please enter your email';
    hasError = true;
  } else if (!GetUtils.isEmail(inputEmail)) {
    emailError.value = 'Enter a valid email';
    hasError = true;
  }

  /// PASSWORD VALIDATION
  if (inputPassword.isEmpty) {
    passwordError.value = 'Please enter your password';
    hasError = true;
  } else if (inputPassword.length < 6) {
    passwordError.value = 'Password must be at least 6 characters';
    hasError = true;
  } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
      .hasMatch(inputPassword)) {
    passwordError.value =
        'Password must contain a special character';
    hasError = true;
  }

  /// STOP IF ANY ERROR
  if (hasError) return;

  try {
    isLoading.value = true;

    await _authRepository.login(
      email: inputEmail,
      password: inputPassword,
    );

    await LocalStorageService.saveUserLogin(
      email: inputEmail,
    );

    isLoggedIn.value = true;

    /// ❌ DO NOT CLEAR FIELDS HERE (important fix)
    Get.offAll(() => StudentDashboard());
  }
  on FirebaseAuthException catch (e) {

  if (e.code == 'user-not-found') {
    AppToast.error("This account doesn't exist");
  } 
  
  else if (e.code == 'wrong-password') {
    AppToast.error("Incorrect password");
  } 
  
  else if (e.code == 'invalid-email') {
    emailError.value = "Enter a valid email";
  } 
  
  else if (e.code == 'user-disabled') {
    AppToast.error("This account has been disabled");
  } 
  
  else {
    AppToast.error("Login failed. Try again");
  }

} catch (e) {
  AppToast.error("This account doesn't exist. ");
} finally {
  isLoading.value = false;
}
  // } catch (e) {
  //   // await clearSession();
          // android:drawable="@drawable/ic_launcher_foreground"
// 
  //   /// 🔥 FIREBASE / DB ERROR HANDLING
  //   final error = e.toString();

  //   if (error.contains('user-not-found')) {
  //     AppToast.error("This account doesn't exist");
  //   } else if (error.contains('wrong-password')) {
  //     AppToast.error("Incorrect password");
  //   } else {
  //     AppToast.error("This account doesn't exist");
  //   }
  // } finally {
  //   isLoading.value = false;
  // }
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

      // Get.snackbar(
      //   'Error',
      //   'Unable to open scanner',
      // );
      AppToast.error('Unable to open scanner');

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