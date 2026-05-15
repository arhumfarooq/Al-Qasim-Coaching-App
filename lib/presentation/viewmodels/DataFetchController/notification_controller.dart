// import 'package:get/get.dart';
// import 'package:qr_code_scanner/data/models/datafetch/notification_model.dart';
// import 'package:qr_code_scanner/data/repositories/DataFetchRepo/notification_repository.dart';
// import 'package:qr_code_scanner/presentation/views/notifications/notifications_screen.dart';


// class NotificationController extends GetxController {
//   final NotificationRepository _repo = NotificationRepository();

//   final notifications = <NotificationModel>[].obs;
//   final unreadCount = 0.obs;
//   final isLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     listenNotifications();
//   }

//   void listenNotifications() {
//     isLoading.value = true;

//     _repo.getNotifications().listen((snapshot) {
//       notifications.value = snapshot.docs
//           .map((doc) => NotificationModel.fromFirestore(doc))
//           .toList();

//       unreadCount.value =
//           notifications.where((notification) => !notification.isRead).length;

//       isLoading.value = false;
//     });
//   }

//   Map<String, List<NotificationModel>> get groupedNotifications {
//     final Map<String, List<NotificationModel>> grouped = {};

//     for (final notification in notifications) {
//       final key = _formatDateHeader(notification.timestamp);

//       if (!grouped.containsKey(key)) {
//         grouped[key] = [];
//       }

//       grouped[key]!.add(notification);
//     }

//     return grouped;
//   }

//   Future<void> markAsRead(String id) async {
//     await _repo.markAsRead(id);
//   }

//   Future<void> markAllAsRead() async {
//     await _repo.markAllAsRead();
//   }

//   Future<void> deleteNotification(String id) async {
//     await _repo.deleteNotification(id);
//   }

//   Future<void> clearAllNotifications() async {
//     await _repo.clearAllNotifications();
//   }

//   String _formatDateHeader(DateTime date) {
//     final now = DateTime.now();

//     final today = DateTime(now.year, now.month, now.day);
//     final notificationDate = DateTime(date.year, date.month, date.day);

//     if (notificationDate == today) {
//       return 'Today';
//     }

//     if (notificationDate == today.subtract(const Duration(days: 1))) {
//       return 'Yesterday';
//     }

//     const months = [
//       'January',
//       'February',
//       'March',
//       'April',
//       'May',
//       'June',
//       'July',
//       'August',
//       'September',
//       'October',
//       'November',
//       'December',
//     ];

//     return '${date.day}/${months[date.month - 1]}/${date.year}';
//   }
// }

import 'package:get/get.dart';
import 'package:qr_code_scanner/data/models/datafetch/notification_model.dart';
// import 'package:qr_code_scanner/data/models/notification_model.dart';
import 'package:qr_code_scanner/data/repositories/DataFetchRepo/notification_repository.dart';
// import 'package:qr_code_scanner/repositry/notification_repository.dart';

class NotificationController extends GetxController {
  final NotificationRepository _repo = NotificationRepository();

  final notifications = <NotificationModel>[].obs;
  final unreadCount = 0.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    isLoading.value = true;

    _repo.getNotifications().listen((snapshot) {
      notifications.value =
          snapshot.docs.map((doc) => NotificationModel.fromFirestore(doc)).toList();

      unreadCount.value = notifications.where((n) => !n.isRead).length;
      isLoading.value = false;
    });
  }

  Map<String, List<NotificationModel>> get groupedNotifications {
    final Map<String, List<NotificationModel>> grouped = {};

    for (final notification in notifications) {
      final dateKey = formatDateHeader(notification.timestamp);
      grouped.putIfAbsent(dateKey, () => []);
      grouped[dateKey]!.add(notification);
    }

    return grouped;
  }

  Future<void> markAsRead(String id) async {
    await _repo.markAsRead(id);
  }

  Future<void> markAllAsRead() async {
    await _repo.markAllAsRead();
  }

  Future<void> deleteNotification(String id) async {
    await _repo.deleteNotification(id);
  }

  Future<void> clearAllNotifications() async {
    await _repo.clearAllNotifications();
  }

  String formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final notificationDate = DateTime(date.year, date.month, date.day);

    if (notificationDate == today) return 'Today';
    if (notificationDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    }

    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${date.day}/${months[date.month - 1]}/${date.year}';
  }
}