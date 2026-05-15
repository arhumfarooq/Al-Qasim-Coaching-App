

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:qr_code_scanner/components/blurred_gradient_background.dart';
import 'package:qr_code_scanner/presentation/viewmodels/auth_controller.dart';
import 'package:qr_code_scanner/presentation/views/login_screen.dart';

class SoliceSliverAppBar extends StatelessWidget {
 const SoliceSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      snap: false,
      pinned: true,
      automaticallyImplyLeading: false,
      expandedHeight: 60.h,
      actions: [
        // Beautiful Logout Button
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: _buildLogoutButton(context),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                LucideIcons.heartHandshake,
                color: const Color(0xFFD35400),
                size: 18.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              'Solace Foundation',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 13.sp,
                shadows: [
                  Shadow(
                    color: Colors.black26,
                    blurRadius: 2.r,
                    offset: Offset(1.w, 1.h),
                  ),
                ],
              ),
            ),
          ],
        ),
        background: const BlurredGradientBackground(),
      ),
    );
  }


Widget _buildLogoutButton(BuildContext context) {

  final authController = Get.find<AuthController>();
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: Tooltip(
      message: 'Logout',
      preferBelow: false,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(6.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      textStyle: GoogleFonts.poppins(
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      child: InkWell(
        onTap: authController.logout,
        borderRadius: BorderRadius.circular(10.r),
        splashColor: Colors.white.withOpacity(0.2),
        highlightColor: Colors.white.withOpacity(0.1),
        splashFactory: InkRipple.splashFactory, // Smoother splash
        child: Container(
          padding: EdgeInsets.all(8.w), // Reduced padding
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red.shade400,
                Colors.orange.shade600,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.3),
                blurRadius: 6.r,
                offset: Offset(0, 1.5.h),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 0.8.r,
                offset: Offset(0, -0.5.h),
                spreadRadius: 0.3,
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 0.4.w, // Thinner border
            ),
          ),
          child: Icon(
            LucideIcons.logOut,
            size: 16.sp, // Smaller icon
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
}