// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class NotificationRepository {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   String? get currentUserId => FirebaseAuth.instance.currentUser?.uid;

//   CollectionReference<Map<String, dynamic>> _notificationsRef(String userId) {
//     return _firestore
//         .collection('students')
//         .doc(userId)
//         .collection('notifications');
//   }

//   Stream<QuerySnapshot<Map<String, dynamic>>> getNotifications() {
//     final userId = currentUserId;

//     if (userId == null) {
//       return const Stream.empty();
//     }

//     return _notificationsRef(userId)
//         .orderBy('createdAt', descending: true)
//         .snapshots();
//   }

//   Future<void> markAsRead(String notificationId) async {
//     final userId = currentUserId;
//     if (userId == null) return;

//     await _notificationsRef(userId).doc(notificationId).update({
//       'isRead': true,
//     });
//   }

//   Future<void> markAllAsRead() async {
//     final userId = currentUserId;
//     if (userId == null) return;

//     final snapshot = await _notificationsRef(userId)
//         .where('isRead', isEqualTo: false)
//         .get();

//     final batch = _firestore.batch();

//     for (final doc in snapshot.docs) {
//       batch.update(doc.reference, {'isRead': true});
//     }

//     await batch.commit();
//   }

//   Future<void> deleteNotification(String notificationId) async {
//     final userId = currentUserId;
//     if (userId == null) return;

//     await _notificationsRef(userId).doc(notificationId).delete();
//   }

//   Future<void> clearAllNotifications() async {
//     final userId = currentUserId;
//     if (userId == null) return;

//     final snapshot = await _notificationsRef(userId).get();

//     final batch = _firestore.batch();

//     for (final doc in snapshot.docs) {
//       batch.delete(doc.reference);
//     }

//     await batch.commit();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationRepository {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  String? get currentUserId =>
      FirebaseAuth.instance.currentUser?.uid;

  CollectionReference<Map<String, dynamic>> _notificationsRef(
    String userId,
  ) {
    return _firestore
        .collection('students')
        .doc(userId)
        .collection('notifications');
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getNotifications() {
    final userId = currentUserId;

    if (userId == null) {
      return const Stream.empty();
    }

    return _notificationsRef(userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> createNotification({
    required String studentUid,
    required String title,
    required String body,
    required String type,
    String? status,
    String? month,
    String? testName,
    int? score,
    int? rank,
    DateTime? dueDate,
    DateTime? date,
    double? amount,
  }) async {
    await _notificationsRef(studentUid.trim()).add({
      'title': title,
      'body': body,
      'type': type,
      'status': status,
      'month': month,
      'testName': testName,
      'score': score,
      'rank': rank,
      'dueDate': dueDate == null
          ? null
          : Timestamp.fromDate(dueDate),
      'date': date == null
          ? null
          : Timestamp.fromDate(date),
      'amount': amount,
      'createdAt': FieldValue.serverTimestamp(),
      'isRead': false,
    });
  }

  Future<void> createAttendanceNotification({
    required String studentUid,
    required String status,
    required DateTime date,
  }) async {
    await createNotification(
      studentUid: studentUid,
      title: 'Attendance Update',
      body: status.toLowerCase() == 'absent'
          ? 'You were marked absent today'
          : 'Your attendance has been marked',
      type: 'attendance',
      status: status,
      date: date,
    );
  }

  Future<void> createFeeNotification({
    required String studentUid,
    required String month,
    required String status,
    DateTime? dueDate,
    double? amount,
  }) async {
    await createNotification(
      studentUid: studentUid,
      title: 'Fee Status Updated',
      body: status.toLowerCase() == 'paid'
          ? 'Your $month fee has been marked paid'
          : 'Your $month fee is pending',
      type: 'fee',
      status: status,
      month: month,
      dueDate: dueDate,
      amount: amount,
    );
  }

  Future<void> createTestResultNotification({
    required String studentUid,
    required String testName,
    required int score,
    int? rank,
  }) async {
    await createNotification(
      studentUid: studentUid,
      title: 'Test Result Uploaded',
      body: 'Your result for $testName has been uploaded',
      type: 'testResult',
      testName: testName,
      score: score,
      rank: rank,
    );
  }

  Future<void> markAsRead(String notificationId) async {
    final userId = currentUserId;
    if (userId == null) return;

    await _notificationsRef(userId).doc(notificationId).update({
      'isRead': true,
    });
  }

  Future<void> markAllAsRead() async {
    final userId = currentUserId;
    if (userId == null) return;

    final snapshot = await _notificationsRef(userId)
        .where('isRead', isEqualTo: false)
        .get();

    final batch = _firestore.batch();

    for (final doc in snapshot.docs) {
      batch.update(doc.reference, {
        'isRead': true,
      });
    }

    await batch.commit();
  }

  Future<void> deleteNotification(String notificationId) async {
    final userId = currentUserId;
    if (userId == null) return;

    await _notificationsRef(userId)
        .doc(notificationId)
        .delete();
  }

  Future<void> clearAllNotifications() async {
    final userId = currentUserId;
    if (userId == null) return;

    final snapshot =
        await _notificationsRef(userId).get();

    final batch = _firestore.batch();

    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
}