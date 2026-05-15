// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lucide_icons/lucide_icons.dart';
// import 'package:qr_code_scanner/core/constants/attendance_Colors.dart';
// import 'package:qr_code_scanner/presentation/viewmodels/DataFetchController/notification_controller.dart';

// // Notification Controller

// // Main Notifications Screen
// class NotificationsScreen extends StatelessWidget {
//   final NotificationController controller = Get.put(NotificationController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AttendanceColors.warmWhite,
//       body: Stack(
//         children: [
//           // Background Elements
//           _buildBackgroundElements(),
          
//           SafeArea(
//             child: Column(
//               children: [
//                 // Header
//                 _buildHeader(),
                
//                 // Stats Summary
//                 Obx(() => _buildStatsSummary()),
                
//                 // Notifications List
//                 Expanded(
//                   child: _buildNotificationsList(),
//                 ),
//               ],
//             ),
//           ),
          
//           // Floating Action Button for Actions
//           Positioned(
//             bottom: 24.h,
//             right: 24.w,
//             child: FloatingActionButton(
//               onPressed: _showActionSheet,
//               backgroundColor: AttendanceColors.primaryOrange,
//               child: Icon(LucideIcons.slidersHorizontal, color: Colors.white, size: 24.sp),
//             ).animate().scale(delay: 300.ms).fadeIn(),
//           ),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildBackgroundElements() {
//     return Stack(
//       children: [
//         Positioned(
//           top: -80,
//           right: -60,
//           child: Container(
//             width: 200.w,
//             height: 200.h,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: LinearGradient(
//                 colors: [
//                   AttendanceColors.primaryOrange.withOpacity(0.05),
//                   AttendanceColors.primaryOrange.withOpacity(0.02),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
  
//   Widget _buildHeader() {
//     return Container(
//       padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             spreadRadius: 1,
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               IconButton(
//                 onPressed: () => Get.back(),
//                 icon: Icon(LucideIcons.chevronLeft, size: 24.sp),
//               ),
//               Expanded(
//                 child: Center(
//                   child: Text(
//                     'Notifications',
//                     style: AttendanceTypography.headlineLarge(Get.context!),
//                   ).animate().fadeIn(),
//                 ),
//               ),
//               Obx(() => Badge(
//                 label: Text(controller.unreadCount.value.toString()),
//                 isLabelVisible: controller.unreadCount.value > 0,
//                 child: IconButton(
//                   onPressed: () => controller.markAllAsRead(),
//                   icon: Icon(LucideIcons.checkCircle, size: 24.sp),
//                 ),
//               )),
//             ],
//           ),
//           SizedBox(height: 8.h),
//           Text(
//             'Stay updated with your child\'s progress',
//             style: AttendanceTypography.bodyMedium(Get.context!),
//           ),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildStatsSummary() {
//     return Container(
//       margin: EdgeInsets.all(16.w),
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         gradient: AttendanceColors.primaryGradient,
//         borderRadius: BorderRadius.circular(20.r),
//         boxShadow: [
//           BoxShadow(
//             color: AttendanceColors.primaryOrange.withOpacity(0.3),
//             blurRadius: 20,
//             spreadRadius: 2,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           _buildStatItem(
//             icon: LucideIcons.bell,
//             value: controller.notifications.length.toString(),
//             label: 'Total',
//             color: Colors.white,
//             delay: 200.ms,
//           ),
//           _buildStatItem(
//             icon: LucideIcons.bellRing,
//             value: controller.unreadCount.value.toString(),
//             label: 'Unread',
//             color: Colors.white,
//             delay: 300.ms,
//           ),
//           _buildStatItem(
//             icon: LucideIcons.calendar,
//             value: 'Today',
//             label: 'Latest',
//             color: Colors.white,
//             delay: 400.ms,
//           ),
//         ],
//       ),
//     ).animate(delay: 100.ms).fadeIn().slideY(begin: 0.2, end: 0);
//   }
  
//   Widget _buildStatItem({
//     required IconData icon,
//     required String value,
//     required String label,
//     required Color color,
//     required Duration delay,
//   }) {
//     return Column(
//       children: [
//         Icon(icon, size: 24.sp, color: color),
//         SizedBox(height: 8.h),
//         Text(
//           value,
//           style: GoogleFonts.poppins(
//             fontSize: 22.sp,
//             fontWeight: FontWeight.w800,
//             color: color,
//           ),
//         ),
//         SizedBox(height: 4.h),
//         Text(
//           label,
//           style: GoogleFonts.inter(
//             fontSize: 12.sp,
//             fontWeight: FontWeight.w500,
//             color: color.withOpacity(0.8),
//           ),
//         ),
//       ],
//     ).animate(delay: delay).fadeIn().scale(begin: Offset(0.9, 0.9), end: Offset(1, 1));
//   }
  
//   Widget _buildNotificationsList() {
//     return Obx(() {
//       if (controller.notifications.isEmpty) {
//         return _buildEmptyState();
//       }
      
//       return RefreshIndicator(
//         color: AttendanceColors.primaryOrange,
//         onRefresh: () async {
//           controller._loadNotifications();
//         },
//         child: ListView.builder(
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//           itemCount: controller.notifications.length,
//           itemBuilder: (context, index) {
//             final notification = controller.notifications[index];
//             return _buildNotificationCard(notification, index);
//           },
//         ),
//       );
//     });
//   }
  
//   Widget _buildNotificationCard(NotificationModel notification, int index) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 12.h),
//       child: Dismissible(
//         key: Key(notification.id),
//         direction: DismissDirection.endToStart,
//         background: Container(
//           decoration: BoxDecoration(
//             color: AttendanceColors.absentColor.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(16.r),
//           ),
//           alignment: Alignment.centerRight,
//           padding: EdgeInsets.only(right: 20.w),
//           child: Icon(
//             LucideIcons.trash2,
//             color: AttendanceColors.absentColor,
//             size: 24.sp,
//           ),
//         ),
//         confirmDismiss: (direction) async {
//           return await _showDeleteConfirmation(notification);
//         },
//         onDismissed: (direction) {
//           controller.deleteNotification(notification.id);
//         },
//         child: InkWell(
//           onTap: () => _handleNotificationTap(notification),
//           borderRadius: BorderRadius.circular(16.r),
//           child: Container(
//             padding: EdgeInsets.all(16.w),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16.r),
//               border: Border.all(
//                 color: notification.isRead 
//                     ? Colors.grey.shade100 
//                     : AttendanceColors.primaryOrange.withOpacity(0.3),
//                 width: notification.isRead ? 1.w : 2.w,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.03),
//                   blurRadius: 8,
//                   spreadRadius: 1,
//                 ),
//               ],
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Notification Icon
//                 Container(
//                   padding: EdgeInsets.all(12.w),
//                   decoration: BoxDecoration(
//                     color: _getNotificationColor(notification.type).withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     _getNotificationIcon(notification.type),
//                     size: 20.sp,
//                     color: _getNotificationColor(notification.type),
//                   ),
//                 ).animate(delay: (index * 100).ms)
//                   .scale(begin: Offset(0.5, 0.5), end: Offset(1, 1))
//                   .fadeIn(duration: 500.ms),
                
//                 SizedBox(width: 16.w),
                
//                 // Notification Content
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               notification.title,
//                               style: GoogleFonts.poppins(
//                                 fontSize: 15.sp,
//                                 fontWeight: FontWeight.w700,
//                                 color: AttendanceColors.darkText,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           if (!notification.isRead)
//                             Container(
//                               width: 8.w,
//                               height: 8.h,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: AttendanceColors.primaryOrange,
//                               ),
//                             ),
//                         ],
//                       ),
                      
//                       SizedBox(height: 6.h),
                      
//                       Text(
//                         notification.message,
//                         style: GoogleFonts.poppins(
//                           fontSize: 13.sp,
//                           fontWeight: FontWeight.w400,
//                           color: AttendanceColors.lightText,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
                      
//                       SizedBox(height: 12.h),
                      
//                       // Additional Info based on type
//                       if (notification.type == NotificationType.testResult)
//                         _buildTestResultDetails(notification),
//                       if (notification.type == NotificationType.fee)
//                         _buildFeeDetails(notification),
//                       if (notification.type == NotificationType.attendance)
//                         _buildAttendanceDetails(notification),
                      
//                       SizedBox(height: 12.h),
                      
//                       // Timestamp and Actions
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             _formatTimestamp(notification.timestamp),
//                             style: GoogleFonts.poppins(
//                               fontSize: 11.sp,
//                               fontWeight: FontWeight.w500,
//                               color: AttendanceColors.lightText,
//                             ),
//                           ),
                          
//                           Row(
//                             children: [
//                               if (!notification.isRead)
//                                 InkWell(
//                                   onTap: () => controller.markAsRead(notification.id),
//                                   borderRadius: BorderRadius.circular(8.r),
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                                     decoration: BoxDecoration(
//                                       color: AttendanceColors.primaryOrange.withOpacity(0.1),
//                                       borderRadius: BorderRadius.circular(8.r),
//                                     ),
//                                     child: Text(
//                                       'Mark as Read',
//                                       style: GoogleFonts.poppins(
//                                         fontSize: 10.sp,
//                                         fontWeight: FontWeight.w600,
//                                         color: AttendanceColors.primaryOrange,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ).animate(delay: (index * 50 + 500).ms)
//           .slideX(begin: 0.2, end: 0)
//           .fadeIn(duration: 500.ms),
//       ),
//     );
//   }
  
//   Widget _buildTestResultDetails(NotificationModel notification) {
//     return Container(
//       padding: EdgeInsets.all(12.w),
//       decoration: BoxDecoration(
//         color: AttendanceColors.presentColor.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(
//           color: AttendanceColors.presentColor.withOpacity(0.1),
//           width: 1.w,
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Test: ${notification.testName ?? "N/A"}',
//                 style: GoogleFonts.poppins(
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.w600,
//                   color: AttendanceColors.darkText,
//                 ),
//               ),
//               Text(
//                 'Subject: ${notification.subject ?? "N/A"}',
//                 style: GoogleFonts.poppins(
//                   fontSize: 11.sp,
//                   color: AttendanceColors.lightText,
//                 ),
//               ),
//             ],
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 'Score: ${notification.score ?? 0}%',
//                 style: GoogleFonts.poppins(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w700,
//                   color: AttendanceColors.presentColor,
//                 ),
//               ),
//               Text(
//                 'Rank: #${notification.rank ?? 0}',
//                 style: GoogleFonts.poppins(
//                   fontSize: 11.sp,
//                   color: AttendanceColors.lightText,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildFeeDetails(NotificationModel notification) {
//     final daysLeft = notification.dueDate?.difference(DateTime.now()).inDays ?? 0;
    
//     return Container(
//       padding: EdgeInsets.all(12.w),
//       decoration: BoxDecoration(
//         color: daysLeft <= 3 
//             ? AttendanceColors.absentColor.withOpacity(0.05)
//             : AttendanceColors.holidayColor.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(
//           color: daysLeft <= 3 
//               ? AttendanceColors.absentColor.withOpacity(0.1)
//               : AttendanceColors.holidayColor.withOpacity(0.1),
//           width: 1.w,
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Amount: ₹${notification.amount ?? 0}',
//                 style: GoogleFonts.poppins(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w700,
//                   color: AttendanceColors.darkText,
//                 ),
//               ),
//               Text(
//                 'Due: ${_formatDate(notification.dueDate ?? DateTime.now())}',
//                 style: GoogleFonts.poppins(
//                   fontSize: 11.sp,
//                   color: AttendanceColors.lightText,
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//             decoration: BoxDecoration(
//               color: daysLeft <= 3 
//                   ? AttendanceColors.absentColor.withOpacity(0.1)
//                   : AttendanceColors.holidayColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(20.r),
//             ),
//             child: Text(
//               '$daysLeft days left',
//               style: GoogleFonts.poppins(
//                 fontSize: 11.sp,
//                 fontWeight: FontWeight.w600,
//                 color: daysLeft <= 3 
//                     ? AttendanceColors.absentColor
//                     : AttendanceColors.holidayColor,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildAttendanceDetails(NotificationModel notification) {
//     return Container(
//       padding: EdgeInsets.all(12.w),
//       decoration: BoxDecoration(
//         color: AttendanceColors.absentColor.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(
//           color: AttendanceColors.absentColor.withOpacity(0.1),
//           width: 1.w,
//         ),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             LucideIcons.user,
//             size: 16.sp,
//             color: AttendanceColors.absentColor,
//           ),
//           SizedBox(width: 8.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Student: ${notification.studentName ?? "N/A"}',
//                   style: GoogleFonts.poppins(
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.w600,
//                     color: AttendanceColors.darkText,
//                   ),
//                 ),
//                 Text(
//                   'Status: ${notification.status ?? "N/A"}',
//                   style: GoogleFonts.poppins(
//                     fontSize: 11.sp,
//                     color: AttendanceColors.absentColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ElevatedButton.icon(
//             onPressed: () => _acknowledgeAbsence(notification),
//             icon: Icon(LucideIcons.check, size: 14.sp),
//             label: Text('Acknowledge'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AttendanceColors.absentColor,
//               foregroundColor: Colors.white,
//               padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//               textStyle: GoogleFonts.poppins(
//                 fontSize: 11.sp,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             LucideIcons.bellOff,
//             size: 80.sp,
//             color: Colors.grey.shade300,
//           ).animate().scale(delay: 200.ms).fadeIn(),
//           SizedBox(height: 20.h),
//           Text(
//             'No Notifications',
//             style: GoogleFonts.poppins(
//               fontSize: 22.sp,
//               fontWeight: FontWeight.w700,
//               color: Colors.grey.shade400,
//             ),
//           ).animate(delay: 400.ms).fadeIn(),
//           SizedBox(height: 8.h),
//           Text(
//             'All caught up! Check back later for updates.',
//             style: GoogleFonts.poppins(
//               fontSize: 14.sp,
//               color: Colors.grey.shade400,
//             ),
//           ),
//           SizedBox(height: 24.h),
//           ElevatedButton.icon(
//             onPressed: () => controller._loadNotifications(),
//             icon: Icon(LucideIcons.refreshCw, size: 16.sp),
//             label: Text('Refresh'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AttendanceColors.primaryOrange,
//               foregroundColor: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
  
//   // Helper Methods
//   Color _getNotificationColor(NotificationType type) {
//     switch (type) {
//       case NotificationType.testResult:
//         return AttendanceColors.presentColor;
//       case NotificationType.fee:
//         return AttendanceColors.holidayColor;
//       case NotificationType.attendance:
//         return AttendanceColors.absentColor;
//       case NotificationType.report:
//         return AttendanceColors.primaryOrange;
//       case NotificationType.meeting:
//         return AttendanceColors.darkOrange;
//       case NotificationType.studyMaterial:
//         return AttendanceColors.darkText;
//       case NotificationType.announcement:
//         return AttendanceColors.pendingColor;
//       default:
//         return AttendanceColors.primaryOrange;
//     }
//   }
  
//   IconData _getNotificationIcon(NotificationType type) {
//     switch (type) {
//       case NotificationType.testResult:
//         return LucideIcons.clipboardCheck;
//       case NotificationType.fee:
//         return LucideIcons.wallet;
//       case NotificationType.attendance:
//         return LucideIcons.calendarCheck;
//       case NotificationType.report:
//         return LucideIcons.fileText;
//       case NotificationType.meeting:
//         return LucideIcons.users;
//       case NotificationType.studyMaterial:
//         return LucideIcons.bookOpen;
//       case NotificationType.announcement:
//         return LucideIcons.megaphone;
//       default:
//         return LucideIcons.bell;
//     }
//   }
  
//   String _formatTimestamp(DateTime timestamp) {
//     final now = DateTime.now();
//     final difference = now.difference(timestamp);
    
//     if (difference.inSeconds < 60) {
//       return 'Just now';
//     } else if (difference.inMinutes < 60) {
//       return '${difference.inMinutes}m ago';
//     } else if (difference.inHours < 24) {
//       return '${difference.inHours}h ago';
//     } else if (difference.inDays < 7) {
//       return '${difference.inDays}d ago';
//     } else {
//       return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
//     }
//   }
  
//   String _formatDate(DateTime date) {
//     return '${date.day}/${date.month}/${date.year}';
//   }
  
//   // Action Methods
//   void _handleNotificationTap(NotificationModel notification) {
//     controller.markAsRead(notification.id);
    
//     // Navigate to relevant screen based on notification type
//     switch (notification.type) {
//       case NotificationType.testResult:
//         Get.toNamed('/test-results');
//         break;
//       case NotificationType.fee:
//         Get.toNamed('/fee');
//         break;
//       case NotificationType.attendance:
//         Get.toNamed('/attendance');
//         break;
//       case NotificationType.report:
//         Get.toNamed('/reports');
//         break;
//       default:
//         // Show detailed view
//         _showNotificationDetails(notification);
//     }
//   }
  
//   void _showActionSheet() {
//     Get.bottomSheet(
//       Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(24.r),
//             topRight: Radius.circular(24.r),
//           ),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(height: 16.h),
//             Container(
//               width: 40.w,
//               height: 4.h,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade300,
//                 borderRadius: BorderRadius.circular(2.r),
//               ),
//             ),
//             SizedBox(height: 24.h),
//             _buildActionItem(
//               icon: LucideIcons.checkCircle,
//               title: 'Mark All as Read',
//               onTap: () {
//                 Get.back();
//                 controller.markAllAsRead();
//               },
//             ),
//             _buildActionItem(
//               icon: LucideIcons.trash2,
//               title: 'Clear All Notifications',
//               onTap: () {
//                 Get.back();
//                 _showClearAllConfirmation();
//               },
//             ),
//             _buildActionItem(
//               icon: LucideIcons.filter,
//               title: 'Filter by Type',
//               onTap: () {
//                 Get.back();
//                 _showFilterOptions();
//               },
//             ),
//             _buildActionItem(
//               icon: LucideIcons.settings,
//               title: 'Notification Settings',
//               onTap: () {
//                 Get.back();
//                 Get.toNamed('/notification-settings');
//               },
//             ),
//             SizedBox(height: 32.h),
//           ],
//         ),
//       ),
//     );
//   }
  
//   Widget _buildActionItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: AttendanceColors.primaryOrange),
//       title: Text(
//         title,
//         style: GoogleFonts.poppins(
//           fontSize: 15.sp,
//           fontWeight: FontWeight.w500,
//           color: AttendanceColors.darkText,
//         ),
//       ),
//       onTap: onTap,
//     );
//   }
  
//   Future<bool> _showDeleteConfirmation(NotificationModel notification) async {
//     bool? result = await Get.dialog(
//       AlertDialog(
//         backgroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.r),
//         ),
//         title: Text(
//           'Delete Notification',
//           style: GoogleFonts.poppins(
//             fontSize: 20.sp,
//             fontWeight: FontWeight.w700,
//             color: AttendanceColors.darkText,
//           ),
//         ),
//         content: Text(
//           'Are you sure you want to delete this notification?',
//           style: GoogleFonts.poppins(
//             fontSize: 14.sp,
//             color: AttendanceColors.lightText,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(result: false),
//             child: Text(
//               'Cancel',
//               style: GoogleFonts.poppins(
//                 color: AttendanceColors.lightText,
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () => Get.back(result: true),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AttendanceColors.absentColor,
//               foregroundColor: Colors.white,
//             ),
//             child: Text('Delete'),
//           ),
//         ],
//       ),
//     );
    
//     return result ?? false;
//   }
  
//   void _showClearAllConfirmation() {
//     Get.dialog(
//       AlertDialog(
//         backgroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.r),
//         ),
//         title: Text(
//           'Clear All Notifications',
//           style: GoogleFonts.poppins(
//             fontSize: 20.sp,
//             fontWeight: FontWeight.w700,
//             color: AttendanceColors.darkText,
//           ),
//         ),
//         content: Text(
//           'This will remove all notifications. This action cannot be undone.',
//           style: GoogleFonts.poppins(
//             fontSize: 14.sp,
//             color: AttendanceColors.lightText,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: Text(
//               'Cancel',
//               style: GoogleFonts.poppins(
//                 color: AttendanceColors.lightText,
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Get.back();
//               controller.clearAllNotifications();
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AttendanceColors.absentColor,
//               foregroundColor: Colors.white,
//             ),
//             child: Text('Clear All'),
//           ),
//         ],
//       ),
//     );
//   }
  
//   void _showFilterOptions() {
//     // Implement filter options
//   }
  
//   void _showNotificationDetails(NotificationModel notification) {
//     Get.bottomSheet(
//       Container(
//         height: Get.height * 0.7,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(24.r),
//             topRight: Radius.circular(24.r),
//           ),
//         ),
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(24.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Container(
//                   width: 40.w,
//                   height: 4.h,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade300,
//                     borderRadius: BorderRadius.circular(2.r),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 24.h),
//               Row(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(12.w),
//                     decoration: BoxDecoration(
//                       color: _getNotificationColor(notification.type).withOpacity(0.1),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       _getNotificationIcon(notification.type),
//                       size: 24.sp,
//                       color: _getNotificationColor(notification.type),
//                     ),
//                   ),
//                   SizedBox(width: 16.w),
//                   Expanded(
//                     child: Text(
//                       notification.title,
//                       style: GoogleFonts.poppins(
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.w700,
//                         color: AttendanceColors.darkText,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.h),
//               Text(
//                 notification.message,
//                 style: GoogleFonts.poppins(
//                   fontSize: 16.sp,
//                   color: AttendanceColors.darkText,
//                 ),
//               ),
//               SizedBox(height: 24.h),
//               Text(
//                 'Details',
//                 style: GoogleFonts.poppins(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.w600,
//                   color: AttendanceColors.darkText,
//                 ),
//               ),
//               SizedBox(height: 12.h),
//               // Add more details based on notification type
//               // ... rest of the details view
//             ],
//           ),
//         ),
//       ),
//     );
//   }
  
//   void _acknowledgeAbsence(NotificationModel notification) {
//     // Implement acknowledgement logic
//     Get.snackbar(
//       'Absence Acknowledged',
//       'You have acknowledged ${notification.studentName}\'s absence',
//       backgroundColor: AttendanceColors.presentColor,
//       colorText: Colors.white,
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }
// }


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
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.notifications.isEmpty) {
        return _buildEmptyState();
      }

      final grouped = controller.groupedNotifications;
      final dateKeys = grouped.keys.toList();

      return RefreshIndicator(
        color: AttendanceColors.primaryOrange,
        onRefresh: () async => controller.loadNotifications(),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          itemCount: dateKeys.length,
          itemBuilder: (context, dateIndex) {
            final date = dateKeys[dateIndex];
            final items = grouped[date] ?? [];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
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
                  return _buildNotificationCard(entry.value, entry.key);
                }),
              ],
            );
          },
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