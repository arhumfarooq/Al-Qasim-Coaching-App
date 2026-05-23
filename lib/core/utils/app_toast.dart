// import 'package:toastification/toastification.dart';
// import 'package:flutter/material.dart';

// class AppToast {
//   static void success(String description, {String? title}) {
//     toastification.show(
//       title: Text(title ?? 'Success', style: const TextStyle(fontWeight: FontWeight.bold)),
//       description: Text(description),
//       type: ToastificationType.success,
//       style: ToastificationStyle.flatColored,
      
// showIcon: false,
//       autoCloseDuration: const Duration(seconds: 3),
//     );
//   }

//   static void error(String description, {String? title}) {
//     toastification.show(
//       title: Text(title ?? 'Error', style: const TextStyle(fontWeight: FontWeight.bold)),
//       description: Text(description),
//       type: ToastificationType.error,
//       style: ToastificationStyle.flatColored,

// showIcon: false,
//       autoCloseDuration: const Duration(seconds: 4),
//     );
//   }

//   static void warning(String description, {String? title}) {
//     toastification.show(
//       title: Text(title ?? 'Warning', style: const TextStyle(fontWeight: FontWeight.bold)),
//       description: Text(description),
//       type: ToastificationType.warning,
//       style: ToastificationStyle.flatColored,

// showIcon: false,
//       autoCloseDuration: const Duration(seconds: 3),
//     );
//   }

//   static void info(String description, {String? title}) {
//     toastification.show(
//       title: Text(title ?? 'Info', style: const TextStyle(fontWeight: FontWeight.bold)),
//       description: Text(description),
//       type: ToastificationType.info,
//       style: ToastificationStyle.flatColored,

// showIcon: false,
//       autoCloseDuration: const Duration(seconds: 3),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class AppToast {
  static void success(String message) {
    toastification.show(
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      alignment: Alignment.topRight,
      showIcon: true,
      showProgressBar: true,
      // closeOnClick: true,
    );
  }



  static void error(String message) {
    toastification.show(
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 4),
      title: Text(message),
      alignment: Alignment.topRight,
    );
  }
  // static void error(String message) {
  //   toastification.show(
  //     type: ToastificationType.error,
  //     style: ToastificationStyle.flat,
  //     autoCloseDuration: const Duration(seconds: 4),
  //     title: Text(
  //       message,
  //       style:  TextStyle(
  //         fontSize:14.sp ,
  //         fontWeight: FontWeight.w600,
  //       ),
  //     ),
  //     alignment: Alignment.topRight,
  //     // showIcon: true,
  //     showProgressBar: true,
  //     closeOnClick: true,
  //      showCloseButton: false,
  //   );
  // }

  static void info(String message) {
    toastification.show(
      type: ToastificationType.info,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text(
        message,
        style: const TextStyle(

          fontWeight: FontWeight.w600,
        ),
      ),
      alignment: Alignment.topRight,
      showIcon: true,
      showProgressBar: true,
      closeOnClick: true,
    );
  }
}