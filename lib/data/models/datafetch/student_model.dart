import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  final String uid;
  final String name;
  final String email;
  final String fatherName;
  final String grade;
  final String rollNo;
  final DateTime? createdAt;

  StudentModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.fatherName,
    required this.grade,
    required this.rollNo,
    this.createdAt,
  });

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      fatherName: map['fatherName'] ?? '',
      grade: map['grade'] ?? '',
       createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          // ignore: dead_code
          : null,
      rollNo: map['rollNo'] ?? '',
    );
  }
}
