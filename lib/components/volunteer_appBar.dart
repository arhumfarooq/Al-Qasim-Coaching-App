
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:qr_code_scanner/core/constants/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ModernVolunteerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int volunteerCount;
  final VoidCallback? onBackPressed;
  final VoidCallback? onFilterPressed;
  final bool showFilterIcon;
  final AnimationController? animationController;

  const ModernVolunteerAppBar({
    super.key,
    required this.title,
    this.volunteerCount = 0,
    this.onBackPressed,
    this.onFilterPressed,
    this.showFilterIcon = true,
    this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.scaffoldBackground.withOpacity(0.98),
            AppColors.scaffoldBackground.withOpacity(0.92),
      
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background subtle pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.02,
              child: CustomPaint(
                painter: _DottedPatternPainter(),
              ),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: MediaQuery.of(context).padding.top + 8.h,
              bottom: 12.h,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Back Button with subtle animation
                if (onBackPressed != null)
                  _buildAnimatedBackButton()
                      .animate(
                        controller: animationController,
                      )
                      .slideX(
                        begin: -0.3,
                        end: 0,
                        duration: 400.ms,
                        curve: Curves.easeOutCubic,
                      )
                      .fadeIn(duration: 300.ms),

                SizedBox(width: onBackPressed != null ? 12.w : 0),

                // Title and Count with staggered animation
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.5,
                          height: 1.1,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                          .animate(
                            controller: animationController,
                          )
                          .fadeIn(duration: 400.ms)
                          .slideY(
                            begin: 0.1,
                            end: 0,
                            duration: 500.ms,
                            curve: Curves.easeOutCubic,
                          ),

                      SizedBox(height: 2.h),

                      // Volunteer count with subtle animation
                      Row(
                        children: [
                          Container(
                            width: 6.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                              color: AppColors.warningDark.withOpacity(0.8),
                              shape: BoxShape.circle,
                            ),
                          )
                              .animate(
                                controller: animationController,
                              )
                              .scale(
                                duration: 600.ms,
                                curve: Curves.elasticOut,
                                begin: const Offset(0, 0),
                                end: const Offset(1, 1),
                              ),
                          
                          SizedBox(width: 6.w),
                          
                          Text(
                            '$volunteerCount volunteers',
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary.withOpacity(0.8),
                              letterSpacing: 0.3,
                            ),
                          )
                              .animate(
                                controller: animationController,
                              )
                              .fadeIn(duration: 500.ms, delay: 100.ms),
                        ],
                      ),
                    ],
                  ),
                ),

                // Filter/Options button with animation
                if (showFilterIcon)
                  _buildFilterButton()
                      .animate(
                        controller: animationController,
                      )
                      .slideX(
                        begin: 0.3,
                        end: 0,
                        duration: 400.ms,
                        curve: Curves.easeOutCubic,
                      )
                      .fadeIn(duration: 300.ms, delay: 100.ms),
              ],
            ),
          ),

          // Bottom border with subtle gradient
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 1.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    AppColors.textSecondary.withOpacity(0.08),
                    AppColors.textSecondary.withOpacity(0.08),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.3, 0.7, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackButton() {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onBackPressed,
        borderRadius: BorderRadius.circular(12.r),
        splashColor: AppColors.warningDark.withOpacity(0.1),
        highlightColor: AppColors.warningDark.withOpacity(0.05),
        child: Container(
          width: 44.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.textSecondary.withOpacity(0.06),
                blurRadius: 12.r,
                offset: Offset(0, 2.h),
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.w,
            ),
          ),
          child: Center(
            child: Icon(
              LucideIcons.chevronLeft,
              size: 22.sp,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    ).animate(
      // onPlay: () => Animate(
      //   effects: [
      //     ScaleEffect(
      //       duration: 200.ms,
      //       curve: Curves.easeOutBack,
      //       begin: const Offset(0.95, 0.95),
      //       end: const Offset(1, 1),
      //     ),
      //   ],
      // ),
    );
  }

  Widget _buildFilterButton() {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onFilterPressed,
        borderRadius: BorderRadius.circular(12.r),
        splashColor: AppColors.warningDark.withOpacity(0.1),
        highlightColor: AppColors.warningDark.withOpacity(0.05),
        child: Container(
          width: 44.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.textSecondary.withOpacity(0.06),
                blurRadius: 12.r,
                offset: Offset(0, 2.h),
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.w,
            ),
          ),
          child: Center(
            child: Stack(
              children: [
                Icon(
                  LucideIcons.filter,
                  size: 20.sp,
                  color: AppColors.textPrimary,
                ),
                if (volunteerCount > 0)
                  Positioned(
                    right: 6.w,
                    top: 6.h,
                    child: Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: AppColors.warningDark,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1.5.w,
                        ),
                      ),
                    ).animate(
                      onPlay: (controller) => controller.repeat(
                        reverse: true,
                        period: 1500.ms,
                      ),
                    ).scaleXY(
                      begin: 1,
                      end: 1.2,
                      duration: 750.ms,
                      curve: Curves.easeInOut,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    ).animate(
      // onTap: () => Animate(
      //   effects: [
      //     ScaleEffect(
      //       duration: 200.ms,
      //       curve: Curves.easeOutBack,
      //       begin: const Offset(0.95, 0.95),
      //       end: const Offset(1, 1),
      //     ),
      //   ],
      // ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100.h + MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top);
}

// Custom painter for subtle dotted pattern
class _DottedPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textSecondary.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    const spacing = 40.0;
    
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(
          Offset(x, y),
          0.5,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}