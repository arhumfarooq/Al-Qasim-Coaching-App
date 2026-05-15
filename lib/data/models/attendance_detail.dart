import 'package:flutter/material.dart';

class AttendanceDetail {
  final String day;
  final String date;
  final String time;
  final String status;
  final Color color;

  AttendanceDetail({
    required this.day,
    required this.date,
    required this.time,
    required this.status,
    required this.color,
  });
}
