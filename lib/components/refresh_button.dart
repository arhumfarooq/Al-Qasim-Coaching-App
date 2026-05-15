import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// ✅ Reusable Small Refresh Button Widget
class SmallRefreshButton extends StatelessWidget {
  final RxBool isLoading;
  final VoidCallback onRefresh;
  final Color? buttonColor;
  final Color? iconColor;
  final Color? textColor;
  final Color? borderColor;
  final String buttonText;
  final double? iconSize;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final bool showText;

  const SmallRefreshButton({
    super.key,
    required this.isLoading,
    required this.onRefresh,
    this.buttonColor = Colors.white,
    this.iconColor,
    this.textColor,
    this.borderColor,
    this.buttonText = 'Refresh',
    this.iconSize,
    this.fontSize,
    this.padding,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = iconColor ?? const Color(0xFFF39C12);
    
    return Obx(() {
      return Align(
        alignment: Alignment.centerRight,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isLoading.value ? null : onRefresh,
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              padding: padding ?? EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 6.h,
              ),
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: borderColor ?? primaryColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isLoading.value
                      ? SizedBox(
                          width: (iconSize ?? 14) - 2,
                          height: (iconSize ?? 14) - 2,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                        )
                      : Icon(
                          LucideIcons.refreshCw,
                          size: iconSize ?? 14,
                          color: primaryColor,
                        ),
                  if (!isLoading.value && showText) SizedBox(width: 6.w),
                  if (!isLoading.value && showText)
                    Text(
                      buttonText,
                      style: GoogleFonts.poppins(
                        fontSize: fontSize ?? 11.sp,
                        fontWeight: FontWeight.w600,
                        color: textColor ?? primaryColor,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

/// ✅ Even more minimal circular icon-only button
class CircularRefreshButton extends StatelessWidget {
  final RxBool isLoading;
  final VoidCallback onRefresh;
  final Color? buttonColor;
  final Color? iconColor;
  final Color? borderColor;
  final double? size;

  const CircularRefreshButton({
    super.key,
    required this.isLoading,
    required this.onRefresh,
    this.buttonColor = Colors.white,
    this.iconColor,
    this.borderColor,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = iconColor ?? const Color(0xFFF39C12);
    
    return Obx(() {
      return Container(
        width: size?.w,
        height: size?.h,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular((size ?? 40) / 2),
          border: Border.all(
            color: borderColor ?? primaryColor.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular((size ?? 40) / 2),
          child: InkWell(
            onTap: isLoading.value ? null : onRefresh,
            borderRadius: BorderRadius.circular((size ?? 40) / 2),
            child: Center(
              child: isLoading.value
                  ? SizedBox(
                      width: (size ?? 40) * 0.45,
                      height: (size ?? 40) * 0.45,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    )
                  : Icon(
                      LucideIcons.refreshCw,
                      size: (size ?? 40) * 0.45,
                      color: primaryColor,
                    ),
            ),
          ),
        ),
      );
    });
  }
}

/// ✅ Full-width refresh button (can be reused elsewhere)
class FullWidthRefreshButton extends StatelessWidget {
  final RxBool isLoading;
  final VoidCallback onRefresh;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String buttonText;
  final double? height;
  final double? borderRadius;

  const FullWidthRefreshButton({
    super.key,
    required this.isLoading,
    required this.onRefresh,
    this.backgroundColor = Colors.white,
    this.foregroundColor,
    this.buttonText = 'Refresh Tokens',
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = foregroundColor ?? const Color(0xFFF39C12);
    
    return Obx(() {
      return SizedBox(
        width: double.infinity,
        height: height?.h ?? 48.h,
        child: ElevatedButton.icon(
          onPressed: isLoading.value ? null : onRefresh,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: primaryColor,
            disabledBackgroundColor: Colors.grey.shade200,
            disabledForegroundColor: Colors.grey.shade400,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius?.r ?? 12.r),
              side: BorderSide(
                color: primaryColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            shadowColor: primaryColor.withOpacity(0.2),
          ),
          icon: isLoading.value
              ? SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                )
              : const Icon(
                  LucideIcons.refreshCw,
                  size: 20,
                ),
          label: Text(
            isLoading.value ? 'Refreshing...' : buttonText,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      );
    });
  }
}