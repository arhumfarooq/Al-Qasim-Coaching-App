import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_code_scanner/data/models/datafetch/fee_model.dart';

class FeeRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<FeeModel>> getStudentFees({
    required String studentId,
  }) async {
    final snapshot = await _firestore
        .collection('fees')
        .where('studentId', isEqualTo: studentId.trim())
        .get();

    final fees = snapshot.docs
        .map((doc) => FeeModel.fromDoc(doc))
        .toList();

    fees.sort((a, b) => b.month.compareTo(a.month));

    return fees;
  }

  Future<FeeModel?> getMonthlyFee({
    required String studentId,
    required int year,
    required int month,
  }) async {
    final monthKey =
        '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}';

    final docId = '${studentId.trim()}_$monthKey';

    final doc = await _firestore
        .collection('fees')
        .doc(docId)
        .get();

    if (!doc.exists) return null;

    return FeeModel.fromDoc(doc);
  }
}