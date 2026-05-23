

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:qr_code_scanner/core/constants/attendance_Colors.dart';
import 'package:qr_code_scanner/data/models/datafetch/notification_model.dart';
// import 'package:qr_code_scanner/data/models/notification_model.dart';
import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/notification_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AttendanceColors.warmWhite,
      body: Stack(
        children: [
          _buildBackgroundElements(),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Obx(() => _buildStatsSummary()),
                Expanded(child: _buildNotificationsList()),
              ],
            ),
          ),
          Positioned(
            bottom: 24.h,
            right: 24.w,
            child: FloatingActionButton(
              onPressed: _showActionSheet,
              backgroundColor: AttendanceColors.primaryOrange,
              child: Icon(
                LucideIcons.slidersHorizontal,
                color: Colors.white,
                size: 24.sp,
              ),
            ).animate().scale(delay: 300.ms).fadeIn(),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundElements() {
    return Stack(
      children: [
        Positioned(
          top: -80,
          right: -60,
          child: Container(
            width: 200.w,
            height: 200.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AttendanceColors.primaryOrange.withOpacity(0.05),
                  AttendanceColors.primaryOrange.withOpacity(0.02),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(LucideIcons.chevronLeft, size: 24.sp),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Notifications',
                    style: AttendanceTypography.headlineLarge(Get.context!),
                  ).animate().fadeIn(),
                ),
              ),
              Obx(
                () => Badge(
                  label: Text(controller.unreadCount.value.toString()),
                  isLabelVisible: controller.unreadCount.value > 0,
                  child: IconButton(
                    onPressed: () => controller.markAllAsRead(),
                    icon: Icon(LucideIcons.checkCircle, size: 24.sp),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Stay updated with your progress',
            style: AttendanceTypography.bodyMedium(Get.context!),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSummary() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: AttendanceColors.primaryGradient,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AttendanceColors.primaryOrange.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatItem(
            icon: LucideIcons.bell,
            value: controller.notifications.length.toString(),
            label: 'Total',
            color: Colors.white,
            delay: 200.ms,
          ),
          _buildStatItem(
            icon: LucideIcons.bellRing,
            value: controller.unreadCount.value.toString(),
            label: 'Unread',
            color: Colors.white,
            delay: 300.ms,
          ),
          _buildStatItem(
            icon: LucideIcons.calendar,
            value: 'Today',
            label: 'Latest',
            color: Colors.white,
            delay: 400.ms,
          ),
        ],
      ),
    ).animate(delay: 100.ms).fadeIn().slideY(begin: 0.2, end: 0);
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
    required Duration delay,
  }) {
    return Column(
      children: [
        Icon(icon, size: 24.sp, color: color),
        SizedBox(height: 8.h),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 22.sp,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: color.withOpacity(0.8),
          ),
        ),
      ],
    ).animate(delay: delay).fadeIn().scale(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
        );
  }

  Widget _buildNotificationsList() {
    return 
    
    // Obx(() {
    //   if (controller.isLoading.value) {
    //     return const Center(child: CircularProgressIndicator());
    //   }

    //   if (controller.notifications.isEmpty) {
    //     return _buildEmptyState();
    //   }

    //   final grouped = controller.groupedNotifications;
    //   final dateKeys = grouped.keys.toList();

    //   return RefreshIndicator(
    //     color: AttendanceColors.primaryOrange,
    //     onRefresh: () async => controller.loadNotifications(),
    //     child: ListView.builder(
    //       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    //       itemCount: dateKeys.length,
    //       itemBuilder: (context, dateIndex) {
    //         final date = dateKeys[dateIndex];
    //         final items = grouped[date] ?? [];

    //         return Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Padding(
    //               padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
    //               child: Text(
    //                 date,
    //                 style: GoogleFonts.poppins(
    //                   fontSize: 14.sp,
    //                   fontWeight: FontWeight.w700,
    //                   color: AttendanceColors.darkText,
    //                 ),
    //               ),
    //             ),
    //             ...items.asMap().entries.map((entry) {
    //               return _buildNotificationCard(entry.value, entry.key);
    //             }),
    //           ],
    //         );
    //       },
    //     ),
    //   );
    // });

    Obx(() {
  return Skeletonizer(
    enabled: controller.isLoading.value,

    child: controller.notifications.isEmpty
        ? _buildEmptyState()
        : RefreshIndicator(
            color: AttendanceColors.primaryOrange,
            onRefresh: () async => controller.loadNotifications(),

            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),

              itemCount: controller.groupedNotifications.keys.length,

              itemBuilder: (context, dateIndex) {
                final date =
                    controller.groupedNotifications.keys.toList()[dateIndex];

                final items =
                    controller.groupedNotifications[date] ?? [];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10.h,
                        bottom: 10.h,
                      ),
                      child: Text(
                        date,
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AttendanceColors.darkText,
                        ),
                      ),
                    ),

                    ...items.asMap().entries.map((entry) {
                      return _buildNotificationCard(
                        entry.value,
                        entry.key,
                      );
                    }),
                  ],
                );
              },
            ),
          ),
  );
});
  }

  Widget _buildNotificationCard(NotificationModel notification, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Dismissible(
        key: Key(notification.id),
        direction: DismissDirection.endToStart,
        background: Container(
          decoration: BoxDecoration(
            color: AttendanceColors.absentColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16.r),
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20.w),
          child: Icon(
            LucideIcons.trash2,
            color: AttendanceColors.absentColor,
            size: 24.sp,
          ),
        ),
        confirmDismiss: (_) async => await _showDeleteConfirmation(notification),
        onDismissed: (_) => controller.deleteNotification(notification.id),
        child: InkWell(
          onTap: () => _handleNotificationTap(notification),
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: notification.isRead
                    ? Colors.grey.shade100
                    : AttendanceColors.primaryOrange.withOpacity(0.3),
                width: notification.isRead ? 1.w : 2.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: _getNotificationColor(notification.type).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getNotificationIcon(notification.type),
                    size: 20.sp,
                    color: _getNotificationColor(notification.type),
                  ),
                ).animate(delay: (index * 100).ms).scale(
                      begin: const Offset(0.5, 0.5),
                      end: const Offset(1, 1),
                    ).fadeIn(duration: 500.ms),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: GoogleFonts.poppins(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                color: AttendanceColors.darkText,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (!notification.isRead)
                            Container(
                              width: 8.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AttendanceColors.primaryOrange,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        notification.message,
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: AttendanceColors.lightText,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 12.h),
                      if (notification.type == NotificationType.testResult)
                        _buildTestResultDetails(notification),
                      if (notification.type == NotificationType.fee)
                        _buildFeeDetails(notification),
                      if (notification.type == NotificationType.attendance)
                        _buildAttendanceDetails(notification),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatTimestamp(notification.timestamp),
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: AttendanceColors.lightText,
                            ),
                          ),
                          if (!notification.isRead)
                            InkWell(
                              onTap: () => controller.markAsRead(notification.id),
                              borderRadius: BorderRadius.circular(8.r),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AttendanceColors.primaryOrange.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  'Mark as Read',
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AttendanceColors.primaryOrange,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ).animate(delay: (index * 50 + 500).ms).slideX(
              begin: 0.2,
              end: 0,
            ).fadeIn(duration: 500.ms),
      ),
    );
  }

  Widget _buildTestResultDetails(NotificationModel notification) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AttendanceColors.presentColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        'Test: ${notification.testName ?? "N/A"}',
        style: GoogleFonts.poppins(fontSize: 12.sp),
      ),
    );
  }

  Widget _buildFeeDetails(NotificationModel notification) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AttendanceColors.holidayColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        'Fees notification',
        style: GoogleFonts.poppins(fontSize: 12.sp),
      ),
    );
  }

  Widget _buildAttendanceDetails(NotificationModel notification) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AttendanceColors.absentColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        notification.status ?? 'Attendance update',
        style: GoogleFonts.poppins(
          fontSize: 12.sp,
          color: AttendanceColors.absentColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        'No Notifications',
        style: GoogleFonts.poppins(
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.testResult:
        return AttendanceColors.presentColor;
      case NotificationType.fee:
        return AttendanceColors.holidayColor;
      case NotificationType.attendance:
        return AttendanceColors.absentColor;
      default:
        return AttendanceColors.primaryOrange;
    }
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.testResult:
        return LucideIcons.clipboardCheck;
      case NotificationType.fee:
        return LucideIcons.wallet;
      case NotificationType.attendance:
        return LucideIcons.calendarCheck;
      default:
        return LucideIcons.bell;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final diff = DateTime.now().difference(timestamp);

    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';

    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }

  void _handleNotificationTap(NotificationModel notification) {
    controller.markAsRead(notification.id);
    _showNotificationDetails(notification);
  }

  void _showActionSheet() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.h),
            _buildActionItem(
              icon: LucideIcons.checkCircle,
              title: 'Mark All as Read',
              onTap: () {
                Get.back();
                controller.markAllAsRead();
              },
            ),
            _buildActionItem(
              icon: LucideIcons.trash2,
              title: 'Clear All Notifications',
              onTap: () {
                Get.back();
                _showClearAllConfirmation();
              },
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AttendanceColors.primaryOrange),
      title: Text(title),
      onTap: onTap,
    );
  }

  Future<bool> _showDeleteConfirmation(NotificationModel notification) async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Delete Notification'),
        content: const Text('Are you sure you want to delete this notification?'),
        actions: [
          TextButton(onPressed: () => Get.back(result: false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Get.back(result: true), child: const Text('Delete')),
        ],
      ),
    );

    return result ?? false;
  }

  void _showClearAllConfirmation() {
    Get.dialog(
      AlertDialog(
        title: const Text('Clear All Notifications'),
        content: const Text('This will remove all notifications.'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.clearAllNotifications();
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  void _showNotificationDetails(NotificationModel notification) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(notification.title, style: GoogleFonts.poppins(fontSize: 20.sp)),
            SizedBox(height: 12.h),
            Text(notification.message),
          ],
        ),
      ),
    );
  }
}