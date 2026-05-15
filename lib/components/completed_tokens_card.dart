import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:qr_code_scanner/components/refresh_button.dart';
import 'package:qr_code_scanner/components/shimmer_box.dart';
import 'package:qr_code_scanner/core/constants/app_colors.dart';

class CompletedTokensCard extends StatelessWidget {
    final RxBool isLoading;
  final RxInt completedTokens;
  final VoidCallback onRefresh;
  final VoidCallback onViewAll;

  const CompletedTokensCard({
    super.key,
    required this.isLoading,
    
    required this.completedTokens,
    required this.onViewAll,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF27AE60).withOpacity(0.05),
                const Color(0xFFF39C12).withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: const Color(0xFFE8F8EF).withOpacity(0.3),
            ),
          ),
          child: Column(
            children: [
              _buildHeader(),
              
               SizedBox(height: 4.h),
            //  _buildRefreshButton(),
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

  /// ✅ Header Section
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'COMPLETED TOKENS',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFF39C12),
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
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFF39C12),
                        Color(0xFFE67E22),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFF39C12).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                           child:        Obx(() {
              if (isLoading.value) {
                return const ShimmerBox();
              }
              return  Text(
                    completedTokens.value.toString(),
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
                  'Rashan \nDistributed',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF2C3E50),
                  ),
                ),
              ],
            ),
          ],
        ),
        const Icon(
          LucideIcons.checkCircle,
          size: 40,
          color: Color(0xFFF39C12),
        ),
      ],
    );
  }

  /// 🎯 Action Buttons
  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFF39C12),
                  Color(0xFFE67E22),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF39C12).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: onViewAll,
              icon: const Icon(LucideIcons.listChecks, size: 20),
              label: const Text('View All'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                minimumSize: const Size(0, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onRefresh,
            icon: const Icon(LucideIcons.refreshCcw, size: 20),
            label: const Text('Refresh'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFF39C12),
              minimumSize: const Size(0, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: const BorderSide(
                color: Color(0xFFF39C12),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
