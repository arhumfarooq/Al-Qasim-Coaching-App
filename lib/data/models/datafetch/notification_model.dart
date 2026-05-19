

import 'package:cloud_firestore/cloud_firestore.dart';

enum NotificationType {
  testResult,
  fee,
  attendance,
  report,
  meeting,
  studyMaterial,
  announcement,
}

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  bool isRead;

  final String? studentName;
  final String? subject;
  final int? score;
  final int? rank;
  final String? testName;
  final DateTime? dueDate;
  final double? amount;
  final String? status;
  final String? month;
  final DateTime? date;
  final String? time;
  final String? topic;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    required this.isRead,
    this.studentName,
    this.subject,
    this.score,
    this.rank,
    this.testName,
    this.dueDate,
    this.amount,
    this.status,
    this.month,
    this.date,
    this.time,
    this.topic,
  });

  factory NotificationModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? {};

    return NotificationModel(
      id: doc.id,
      title: data['title'] ?? 'Notification',
      message: data['body'] ?? data['message'] ?? '',
      type: _typeFromString(data['type']),
      timestamp: data['createdAt'] is Timestamp
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      isRead: data['isRead'] ?? false,
      studentName: data['studentName'],
      subject: data['subject'],
      score: data['score'],
      rank: data['rank'],
      testName: data['testName'],
      dueDate:
          data['dueDate'] is Timestamp ? (data['dueDate'] as Timestamp).toDate() : null,
      amount: data['amount'] is num ? (data['amount'] as num).toDouble() : null,
      status: data['status'],
      month: data['month'],
      date: data['date'] is Timestamp ? (data['date'] as Timestamp).toDate() : null,
      time: data['time'],
      topic: data['topic'],
    );
  }

  static NotificationType _typeFromString(dynamic value) {
    switch (value?.toString()) {
      case 'result':
      case 'testResult':
        return NotificationType.testResult;
      case 'fee':
      case 'fees':
        return NotificationType.fee;
      case 'attendance':
        return NotificationType.attendance;
      case 'report':
        return NotificationType.report;
      case 'meeting':
        return NotificationType.meeting;
      case 'studyMaterial':
        return NotificationType.studyMaterial;
      default:
        return NotificationType.announcement;
    }
  }
}