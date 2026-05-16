import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_code_scanner/data/models/datafetch/test_result_model.dart';

class TestResultRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<List<TestResultModel>> getStudentResults({
  required String classId,
  required String rollNo,
}) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('testResults')
      .where('classId', isEqualTo: classId.trim())
      .get();

  final results = <TestResultModel>[];

  for (final doc in snapshot.docs) {
    final data = doc.data();
    final scores = Map<String, dynamic>.from(data['scores'] ?? {});

    if (!scores.containsKey(rollNo.trim())) continue;

    results.add(
      TestResultModel.fromDoc(
        doc: doc,
        studentKey: rollNo.trim(),
      ),
    );
  }

  results.sort((a, b) => b.testDate.compareTo(a.testDate));
  return results;
}



Future<List<TestResultModel>> getClassResults({
  required String classId,
}) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('testResults')
      .where('classId', isEqualTo: classId.trim())
      .get();

  final results = <TestResultModel>[];

  for (final doc in snapshot.docs) {
    final data = doc.data();
    final scores = Map<String, dynamic>.from(data['scores'] ?? {});

    for (final rollNo in scores.keys) {
      results.add(
        TestResultModel.fromDoc(
          doc: doc,
          studentKey: rollNo.trim(),
        ),
      );
    }
  }

  results.sort((a, b) => b.testDate.compareTo(a.testDate));

  return results;
}


}