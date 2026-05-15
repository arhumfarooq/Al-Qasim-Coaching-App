import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? get currentUserId => FirebaseAuth.instance.currentUser?.uid;

  CollectionReference<Map<String, dynamic>> _notificationsRef(String userId) {
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
      batch.update(doc.reference, {'isRead': true});
    }

    await batch.commit();
  }

  Future<void> deleteNotification(String notificationId) async {
    final userId = currentUserId;
    if (userId == null) return;

    await _notificationsRef(userId).doc(notificationId).delete();
  }

  Future<void> clearAllNotifications() async {
    final userId = currentUserId;
    if (userId == null) return;

    final snapshot = await _notificationsRef(userId).get();

    final batch = _firestore.batch();

    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
}