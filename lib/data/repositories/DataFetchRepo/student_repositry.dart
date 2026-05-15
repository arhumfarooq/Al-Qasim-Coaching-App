import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_code_scanner/data/models/datafetch/student_model.dart';

class StudentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<StudentModel?> getStudentByEmail(String email) async {
    final query = await _firestore
        .collection('students')
        .where('email', isEqualTo: email.trim())
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      return null;
    }

    return StudentModel.fromMap(query.docs.first.data());
  }
}