class StudentModel {
  final String uid;
  final String name;
  final String email;
  final String fatherName;
  final String grade;
  final String rollNo;

  StudentModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.fatherName,
    required this.grade,
    required this.rollNo,
  });

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      fatherName: map['fatherName'] ?? '',
      grade: map['grade'] ?? '',
      rollNo: map['rollNo'] ?? '',
    );
  }
}