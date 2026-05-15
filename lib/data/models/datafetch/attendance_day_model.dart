class AttendanceDayModel {
  final DateTime date;
  final String dateStr;
  final String status; // present, absent, holiday

  AttendanceDayModel({
    required this.date,
    required this.dateStr,
    required this.status,
  });
}