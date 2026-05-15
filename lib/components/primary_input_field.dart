// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// class PrimaryInputField extends StatelessWidget {
//   final String hint;
//   final IconData prefixIcon;
//   final bool obscureText;
//   final TextEditingController? controller;
//   final TextInputType keyboardType;
//   final Widget? suffixIcon;
//   final int? maxLines;
//   final void Function(String)? onChanged;

//   const PrimaryInputField({
//     super.key,
//     required this.hint,
//     required this.prefixIcon,
//     this.obscureText = false,
//     this.controller,
//     this.keyboardType = TextInputType.text,
//     this.suffixIcon,
//     this.maxLines = 1,
//     this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       obscureText: obscureText,
//       maxLines: maxLines,
//       onChanged: onChanged,
//       style: GoogleFonts.poppins(fontSize: 16.sp),
//       decoration: InputDecoration(
//         prefixIcon: Icon(
//           prefixIcon,
//           color: const Color(0xFFE67E22),
//           size: 20.sp,
//         ),
//         suffixIcon: suffixIcon,
//         hintText: hint,
//         hintStyle: GoogleFonts.poppins(
//           fontSize: 14.sp,
//           color: const Color(0xFF95A5A6),
//         ),
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: EdgeInsets.symmetric(
//           vertical: 16.h,
//           horizontal: 16.w,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16.r),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16.r),
//           borderSide: BorderSide(
//             color: const Color(0xFFECF0F1),
//             width: 1.w,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16.r),
//           borderSide: BorderSide(
//             color: const Color(0xFFF39C12),
//             width: 2.w,
//           ),
//         ),
//       ),
//     )
//         .animate()
//         .slideY(begin: 0.3, end: 0, duration: 500.ms)
//         .fadeIn(duration: 500.ms);
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryInputField extends StatelessWidget {
  final String hint;
  final IconData prefixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final int? maxLines;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator; // ✅ Added validator

  const PrimaryInputField({
    super.key,
    required this.hint,
    required this.prefixIcon,
    this.obscureText = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.maxLines = 1,
    this.onChanged,
    this.validator, // ✅ Added validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      onChanged: onChanged,
      validator: validator, // ✅ Hooked validator
      style: GoogleFonts.poppins(fontSize: 16.sp),
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: const Color(0xFFE67E22),
          size: 20.sp,
        ),
        suffixIcon: suffixIcon,
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          fontSize: 14.sp,
          color: const Color(0xFF95A5A6),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 16.w,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: const Color(0xFFECF0F1),
            width: 1.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: const Color(0xFFF39C12),
            width: 2.w,
          ),
        ),
      ),
    )
        .animate()
        .slideY(begin: 0.3, end: 0, duration: 500.ms)
        .fadeIn(duration: 500.ms);
  }
}
