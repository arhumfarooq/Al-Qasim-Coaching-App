import 'package:cloud_firestore/cloud_firestore.dart';

class FeeModel {
  final String id;
  final String classId;
  final String studentId;
  final String month;
  final String status;
  final DateTime? dueDate;
  final DateTime? paidAt;

  FeeModel({
    required this.id,
    required this.classId,
    required this.studentId,
    required this.month,
    required this.status,
    this.dueDate,
    this.paidAt,
  });

  factory FeeModel.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? {};

    return FeeModel(
      id: doc.id,
      classId: data['classId']?.toString() ?? '',
      studentId: data['studentId']?.toString() ?? '',
      month: data['month']?.toString() ?? '',
      status: data['status']?.toString().toLowerCase() ?? 'unpaid',
      dueDate: data['dueDate'] is Timestamp
          ? (data['dueDate'] as Timestamp).toDate()
          : null,
      paidAt: data['paidAt'] is Timestamp
          ? (data['paidAt'] as Timestamp).toDate()
          : null,
    );
  }
}