import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:qr_code_scanner/components/refresh_button.dart';
import 'package:qr_code_scanner/components/shimmer_box.dart';
import 'package:qr_code_scanner/core/constants/app_colors.dart';

class PendingTokensCard extends StatelessWidget {
  final RxBool isLoading;
  final RxInt pendingTokens;
  final VoidCallback onViewAll;
  final VoidCallback onRefresh;

  const PendingTokensCard({
    super.key,
    required this.isLoading,
    required this.pendingTokens,
    required this.onViewAll,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Token Management',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),

        /// 🎟 Token Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: AppColors.pendingTokensBackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.borderLight.withOpacity(0.3),
            ),
          ),
          child: Column(
            children: [
              _buildHeader(),
               SizedBox(height: 4.h),
                    SmallRefreshButton(
                isLoading: isLoading,
                onRefresh: onRefresh,
                buttonColor: Colors.white,
                iconColor: const Color(0xFFF39C12),
                textColor: const Color(0xFFF39C12),
                borderColor: const Color(0xFFF39C12).withOpacity(0.3),
                buttonText: 'Refresh',
                iconSize: 14,
                fontSize: 11.sp,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                showText: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 🕒 Header Section
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PENDING TOKENS',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.warning,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppColors.pendingTokensGradient,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.pendingTokensShadow,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child:        Obx(() {
              if (isLoading.value) {
               return const ShimmerBox(
              
               );

              }
              return  Text(
                    pendingTokens.value.toString(),
                    
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textWhite,
                    ),
                  );
            }),
                ),
                const SizedBox(width: 12),
                Text(
                  'Awaiting \nProcessing',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
        Icon(
          LucideIcons.clock,
          size: 40,
          color: AppColors.warning,
        ),
      ],
    );
  }

}

