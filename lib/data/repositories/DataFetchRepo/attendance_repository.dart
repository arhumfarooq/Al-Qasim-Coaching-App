// // // // // // // // import 'package:cloud_firestore/cloud_firestore.dart';

// // // // // // // // class AttendanceRepository {
// // // // // // // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// // // // // // // //   Future<Map<String, String>> getMonthlyAttendance({
// // // // // // // //     required String classId,
// // // // // // // //     required int year,
// // // // // // // //     required int month,
// // // // // // // //     required String studentUid,
// // // // // // // //   }) async {
// // // // // // // //     final start = DateTime(year, month, 1);
// // // // // // // //     final end = DateTime(year, month + 1, 1);

// // // // // // // //     final snapshot = await _firestore
// // // // // // // //         .collection('attendance')
// // // // // // // //         .where('classId', isEqualTo: classId)
// // // // // // // //         .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
// // // // // // // //         .where('date', isLessThan: Timestamp.fromDate(end))
// // // // // // // //         .get();

// // // // // // // //     final Map<String, String> result = {};

// // // // // // // //     for (final doc in snapshot.docs) {
// // // // // // // //       final data = doc.data();

// // // // // // // //       final dateStr = data['dateStr']?.toString() ?? '';
// // // // // // // //       final records = Map<String, dynamic>.from(data['records'] ?? {});

// // // // // // // //       if (records.containsKey(studentUid)) {
// // // // // // // //         result[dateStr] = records[studentUid].toString();
// // // // // // // //       }
// // // // // // // //     }

// // // // // // // //     return result;
// // // // // // // //   }
// // // // // // // // }
// // // // // // // import 'package:cloud_firestore/cloud_firestore.dart';

// // // // // // // class AttendanceRepository {
// // // // // // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// // // // // // //   Future<Map<String, String>> getMonthlyAttendance({
// // // // // // //     required String classId,
// // // // // // //     required int year,
// // // // // // //     required int month,
// // // // // // //     required String studentUid,
// // // // // // //   }) async {
// // // // // // //     final totalDays = DateTime(year, month + 1, 0).day;

// // // // // // //     final Map<String, String> result = {};

// // // // // // //     for (int day = 1; day <= totalDays; day++) {
// // // // // // //       final dateStr =
// // // // // // //           '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

// // // // // // //       final docId = '${classId}_$dateStr';

// // // // // // //       final doc = await _firestore.collection('attendance').doc(docId).get();

// // // // // // //       if (!doc.exists) continue;

// // // // // // //       final data = doc.data();
// // // // // // //       if (data == null) continue;

// // // // // // //       final records = Map<String, dynamic>.from(data['records'] ?? {});

// // // // // // //       if (records.containsKey(studentUid)) {
// // // // // // //         result[dateStr] =
// // // // // // //             records[studentUid].toString().trim().toLowerCase();
// // // // // // //       }
// // // // // // //     }

// // // // // // //     return result;
// // // // // // //   }
// // // // // // // }

// // // // // // import 'package:cloud_firestore/cloud_firestore.dart';

// // // // // // class AttendanceRepository {
// // // // // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// // // // // //   Future<Map<String, String>> getMonthlyAttendance({
// // // // // //     required String classId,
// // // // // //     required int year,
// // // // // //     required int month,
// // // // // //     required String studentUid,
// // // // // //   }) async {
// // // // // //     final totalDays = DateTime(year, month + 1, 0).day;
// // // // // //     final Map<String, String> result = {};

// // // // // //     for (int day = 1; day <= totalDays; day++) {
// // // // // //       final dateStr =
// // // // // //           '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

// // // // // //       final classDocId = '${classId}_$dateStr';
// // // // // //       final studentDocId = '${studentUid}_${year}_${month}_$day';

// // // // // //       // 1. Pehle class attendance doc check karo
// // // // // //       final classDoc =
// // // // // //           await _firestore.collection('attendance').doc(classDocId).get();

// // // // // //       if (classDoc.exists && classDoc.data() != null) {
// // // // // //         final data = classDoc.data()!;
// // // // // //         final records = Map<String, dynamic>.from(data['records'] ?? {});

// // // // // //         if (records.containsKey(studentUid)) {
// // // // // //           result[dateStr] =
// // // // // //               records[studentUid].toString().trim().toLowerCase();
// // // // // //         }
// // // // // //       }

// // // // // //       // 2. Phir student individual doc check karo
// // // // // //       // Individual doc ko priority deni hai, isliye baad me check kar rahe hain
// // // // // //       final studentDoc =
// // // // // //           await _firestore.collection('attendance').doc(studentDocId).get();

// // // // // //       if (studentDoc.exists && studentDoc.data() != null) {
// // // // // //         final data = studentDoc.data()!;

// // // // // //         final status = data['status'] ??
// // // // // //             data['attendanceStatus'] ??
// // // // // //             data['value'] ??
// // // // // //             data['record'];

// // // // // //         if (status != null) {
// // // // // //           result[dateStr] = status.toString().trim().toLowerCase();
// // // // // //         }
// // // // // //       }
// // // // // //     }

// // // // // //     return result;
// // // // // //   }
// // // // // // }

// // // // // import 'package:cloud_firestore/cloud_firestore.dart';

// // // // // class AttendanceRepository {
// // // // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// // // // //   Future<Map<String, String>> getMonthlyAttendance({
// // // // //     required String classId,
// // // // //     required int year,
// // // // //     required int month,
// // // // //     required String studentUid,
// // // // //   }) async {
// // // // //     final totalDays = DateTime(year, month + 1, 0).day;
// // // // //     final Map<String, String> result = {};

// // // // //     print('FETCHING ATTENDANCE...');
// // // // //     print('CLASS ID: $classId');
// // // // //     print('STUDENT UID: $studentUid');
// // // // //     print('YEAR: $year MONTH: $month');

// // // // //     for (int day = 1; day <= totalDays; day++) {
// // // // //       final dateStr =
// // // // //           '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

// // // // //       final classDocId = '${classId.trim()}_$dateStr';

// // // // //       final studentDocId1 = '${studentUid}_${year}_${month}_$day';
// // // // //       final studentDocId2 =
// // // // //           '${studentUid}_${year}_${month.toString().padLeft(2, '0')}_${day.toString().padLeft(2, '0')}';

// // // // //       print('CHECK CLASS DOC: $classDocId');
// // // // //       print('CHECK STUDENT DOC 1: $studentDocId1');
// // // // //       print('CHECK STUDENT DOC 2: $studentDocId2');

// // // // //       final classDoc =
// // // // //           await _firestore.collection('attendance').doc(classDocId).get();

// // // // //       if (classDoc.exists && classDoc.data() != null) {
// // // // //         final data = classDoc.data()!;
// // // // //         final records = Map<String, dynamic>.from(data['records'] ?? {});

// // // // //         print('CLASS DOC FOUND: $classDocId');
// // // // //         print('CLASS RECORD KEYS: ${records.keys.toList()}');

// // // // //         if (records.containsKey(studentUid)) {
// // // // //           result[dateStr] =
// // // // //               records[studentUid].toString().trim().toLowerCase();

// // // // //           print('CLASS STATUS FOUND $dateStr: ${result[dateStr]}');
// // // // //         }
// // // // //       }

// // // // //       final studentDoc1 =
// // // // //           await _firestore.collection('attendance').doc(studentDocId1).get();

// // // // //       if (studentDoc1.exists && studentDoc1.data() != null) {
// // // // //         final data = studentDoc1.data()!;
// // // // //         print('STUDENT DOC 1 FOUND: $studentDocId1');
// // // // //         print('STUDENT DOC DATA: $data');

// // // // //         final status = _extractStatus(data, studentUid);

// // // // //         if (status != null) {
// // // // //           result[dateStr] = status;
// // // // //           print('STUDENT STATUS FOUND $dateStr: $status');
// // // // //         }
// // // // //       }

// // // // //       final studentDoc2 =
// // // // //           await _firestore.collection('attendance').doc(studentDocId2).get();

// // // // //       if (studentDoc2.exists && studentDoc2.data() != null) {
// // // // //         final data = studentDoc2.data()!;
// // // // //         print('STUDENT DOC 2 FOUND: $studentDocId2');
// // // // //         print('STUDENT DOC DATA: $data');

// // // // //         final status = _extractStatus(data, studentUid);

// // // // //         if (status != null) {
// // // // //           result[dateStr] = status;
// // // // //           print('STUDENT STATUS FOUND $dateStr: $status');
// // // // //         }
// // // // //       }
// // // // //     }

// // // // //     print('FINAL RESULT: $result');
// // // // //     return result;
// // // // //   }

// // // // //   String? _extractStatus(
// // // // //     Map<String, dynamic> data,
// // // // //     String studentUid,
// // // // //   ) {
// // // // //     final directStatus = data['status'] ??
// // // // //         data['attendanceStatus'] ??
// // // // //         data['value'] ??
// // // // //         data['record'];

// // // // //     if (directStatus != null) {
// // // // //       return directStatus.toString().trim().toLowerCase();
// // // // //     }

// // // // //     if (data['records'] != null) {
// // // // //       final records = Map<String, dynamic>.from(data['records']);

// // // // //       if (records.containsKey(studentUid)) {
// // // // //         return records[studentUid].toString().trim().toLowerCase();
// // // // //       }
// // // // //     }

// // // // //     return null;
// // // // //   }
// // // // // }


// // // // import 'package:cloud_firestore/cloud_firestore.dart';

// // // // class AttendanceRepository {
// // // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// // // //   Future<Map<String, String>> getMonthlyAttendance({
// // // //     required String classId,
// // // //     required int year,
// // // //     required int month,
// // // //     required String studentUid,
// // // //   }) async {

// // // //     final totalDays = DateTime(year, month + 1, 0).day;

// // // //     final Map<String, String> result = {};

// // // //     for (int day = 1; day <= totalDays; day++) {

// // // //       final dateStr =
// // // //           '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

// // // //       /// CLASS DOC
// // // //       final classDocId = '${classId}_$dateStr';

// // // //       /// STUDENT CORRECTION DOC
// // // //       final studentDocId =
// // // //           '${studentUid}_${year}_${month}_$day';

// // // //       /// DEFAULT NULL
// // // //       String? finalStatus;

// // // //       // ===================================================
// // // //       // 1. CLASS ATTENDANCE CHECK
// // // //       // ===================================================

// // // //       final classDoc = await _firestore
// // // //           .collection('attendance')
// // // //           .doc(classDocId)
// // // //           .get();

// // // //       if (classDoc.exists && classDoc.data() != null) {

// // // //         final data = classDoc.data()!;

// // // //         final records =
// // // //             Map<String, dynamic>.from(
// // // //           data['records'] ?? {},
// // // //         );

// // // //         if (records.containsKey(studentUid)) {

// // // //           finalStatus = records[studentUid]
// // // //               .toString()
// // // //               .trim()
// // // //               .toLowerCase();

// // // //           print(
// // // //               'CLASS STATUS $dateStr => $finalStatus');
// // // //         }
// // // //       }

// // // //       // ===================================================
// // // //       // 2. INDIVIDUAL CORRECTION CHECK
// // // //       // ===================================================

// // // //       final studentDoc = await _firestore
// // // //           .collection('attendance')
// // // //           .doc(studentDocId)
// // // //           .get();

// // // //       if (studentDoc.exists &&
// // // //           studentDoc.data() != null) {

// // // //         final data = studentDoc.data()!;

// // // //         final docStudentId =
// // // //             data['studentId']
// // // //                 ?.toString()
// // // //                 .trim();

// // // //         final status =
// // // //             data['status']
// // // //                 ?.toString()
// // // //                 .trim()
// // // //                 .toLowerCase();

// // // //         /// SAME UID
// // // //         if (docStudentId == studentUid &&
// // // //             status != null) {

// // // //           /// OVERRIDE
// // // //           finalStatus = status;

// // // //           print(
// // // //               'CORRECTION STATUS $dateStr => $finalStatus');
// // // //         }
// // // //       }

// // // //       // ===================================================
// // // //       // FINAL SAVE
// // // //       // ===================================================

// // // //       if (finalStatus != null) {
// // // //         result[dateStr] = finalStatus;
// // // //       }
// // // //     }

// // // //     print('FINAL ATTENDANCE => $result');

// // // //     return result;
// // // //   }
// // // // }

// // // import 'package:cloud_firestore/cloud_firestore.dart';

// // // class AttendanceRepository {
// // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// // //   Future<Map<String, String>> getMonthlyAttendance({
// // //     required String classId,
// // //     required int year,
// // //     required int month,
// // //     required String studentUid,
// // //   }) async {
// // //     final totalDays = DateTime(year, month + 1, 0).day;
// // //     final Map<String, String> result = {};

// // //     final cleanClassId = classId.trim();
// // //     final cleanStudentUid = studentUid.trim();

// // //     print('CLASS ID => $cleanClassId');
// // //     print('STUDENT UID => $cleanStudentUid');
// // //     print('YEAR => $year MONTH => $month');

// // //     for (int day = 1; day <= totalDays; day++) {
// // //       final dateStr =
// // //           '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

// // //       final classDocId = '${cleanClassId}_$dateStr';
// // //       final studentDocId = '${cleanStudentUid}_${year}_${month}_$day';

// // //       print('CHECK CLASS DOC => $classDocId');
// // //       print('CHECK STUDENT DOC => $studentDocId');

// // //       String? finalStatus;

// // //       final classDoc =
// // //           await _firestore.collection('attendance').doc(classDocId).get();

// // //       if (classDoc.exists && classDoc.data() != null) {
// // //         final data = classDoc.data()!;
// // //         final records = Map<String, dynamic>.from(data['records'] ?? {});

// // //         print('CLASS DOC FOUND => $classDocId');
// // //         print('RECORD KEYS => ${records.keys.toList()}');

// // //         if (records.containsKey(cleanStudentUid)) {
// // //           finalStatus =
// // //               records[cleanStudentUid].toString().trim().toLowerCase();

// // //           print('CLASS STATUS => $dateStr : $finalStatus');
// // //         }
// // //       }

// // //       final studentDoc =
// // //           await _firestore.collection('attendance').doc(studentDocId).get();

// // //       if (studentDoc.exists && studentDoc.data() != null) {
// // //         final data = studentDoc.data()!;

// // //         print('STUDENT DOC FOUND => $studentDocId');
// // //         print('STUDENT DOC DATA => $data');

// // //         final docStudentId = data['studentId']?.toString().trim();
// // //         final status = data['status']?.toString().trim().toLowerCase();

// // //         if (docStudentId == cleanStudentUid && status != null) {
// // //           finalStatus = status;
// // //           print('CORRECTION STATUS => $dateStr : $finalStatus');
// // //         }
// // //       }

// // //       if (finalStatus != null) {
// // //         result[dateStr] = finalStatus;
// // //       }
// // //     }

// // //     print('FINAL ATTENDANCE => $result');
// // //     return result;
// // //   }
// // // }


// // import 'package:cloud_firestore/cloud_firestore.dart';

// // class AttendanceRepository {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// //   Future<Map<String, String>> getMonthlyAttendance({
// //     required String classId,
// //     required int year,
// //     required int month,
// //     required String studentUid,
// //   }) async {
// //     final totalDays = DateTime(year, month + 1, 0).day;

// //     final cleanClassId = classId.trim();
// //     final cleanStudentUid = studentUid.trim();

// //     final List<Future<DocumentSnapshot<Map<String, dynamic>>>> classFutures = [];
// //     final List<Future<DocumentSnapshot<Map<String, dynamic>>>> studentFutures = [];

// //     for (int day = 1; day <= totalDays; day++) {
// //       final dateStr =
// //           '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

// //       final classDocId = '${cleanClassId}_$dateStr';
// //       final studentDocId = '${cleanStudentUid}_${year}_${month}_$day';

// //       classFutures.add(
// //         _firestore.collection('attendance').doc(classDocId).get(),
// //       );

// //       studentFutures.add(
// //         _firestore.collection('attendance').doc(studentDocId).get(),
// //       );
// //     }

// //     final classDocs = await Future.wait(classFutures);
// //     final studentDocs = await Future.wait(studentFutures);

// //     final Map<String, String> result = {};

// //     for (int i = 0; i < totalDays; i++) {
// //       final day = i + 1;

// //       final dateStr =
// //           '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

// //       String? finalStatus;

// //       final classDoc = classDocs[i];

// //       if (classDoc.exists && classDoc.data() != null) {
// //         final data = classDoc.data()!;
// //         final records = Map<String, dynamic>.from(data['records'] ?? {});

// //         if (records.containsKey(cleanStudentUid)) {
// //           finalStatus =
// //               records[cleanStudentUid].toString().trim().toLowerCase();
// //         }
// //       }

// //       final studentDoc = studentDocs[i];

// //       if (studentDoc.exists && studentDoc.data() != null) {
// //         final data = studentDoc.data()!;

// //         final docStudentId = data['studentId']?.toString().trim();
// //         final status = data['status']?.toString().trim().toLowerCase();

// //         if (docStudentId == cleanStudentUid && status != null) {
// //           finalStatus = status;
// //         }
// //       }

// //       if (finalStatus != null) {
// //         result[dateStr] = finalStatus;
// //       }
// //     }

// //     return result;
// //   }
// // }

// // import 'package:cloud_firestore/cloud_firestore.dart';

// // class AttendanceRepository {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// //   Future<Map<String, String>> getMonthlyAttendance({
// //     required String classId,
// //     required int year,
// //     required int month,
// //     required String studentUid,
// //   }) async {
// //     final totalDays = DateTime(year, month + 1, 0).day;

// //     final cleanClassId = classId.trim();
// //     final cleanStudentUid = studentUid.trim();

// //     final classFutures =
// //         <Future<DocumentSnapshot<Map<String, dynamic>>>>[];

// //     final studentFutures =
// //         <Future<DocumentSnapshot<Map<String, dynamic>>>>[];

// //     for (int day = 1; day <= totalDays; day++) {
// //       final dateStr =
// //           '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

// //       final classDocId = '${cleanClassId}_$dateStr';
// //       final studentDocId = '${cleanStudentUid}_${year}_${month}_$day';

// //       classFutures.add(
// //         _firestore.collection('attendance').doc(classDocId).get(),
// //       );

// //       studentFutures.add(
// //         _firestore.collection('attendance').doc(studentDocId).get(),
// //       );
// //     }

// //     final classDocs = await Future.wait(classFutures);
// //     final studentDocs = await Future.wait(studentFutures);

// //     final Map<String, String> result = {};

// //     for (int i = 0; i < totalDays; i++) {
// //       final day = i + 1;

// //       final dateStr =
// //           '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

// //       String? finalStatus;

// //       final classDoc = classDocs[i];

// //       if (classDoc.exists && classDoc.data() != null) {
// //         final data = classDoc.data()!;
// //         final records = Map<String, dynamic>.from(data['records'] ?? {});

// //         if (records.containsKey(cleanStudentUid)) {
// //           finalStatus =
// //               records[cleanStudentUid].toString().trim().toLowerCase();
// //         }
// //       }

// //       final studentDoc = studentDocs[i];

// //       if (studentDoc.exists && studentDoc.data() != null) {
// //         final data = studentDoc.data()!;

// //         final docStudentId = data['studentId']?.toString().trim();
// //         final status = data['status']?.toString().trim().toLowerCase();

// //         if (docStudentId == cleanStudentUid && status != null) {
// //           finalStatus = status;
// //         }
// //       }

// //       if (finalStatus != null) {
// //         result[dateStr] = finalStatus;
// //       }
// //     }

// //     return result;
// //   }

// //   Future<List<String>> getStudentAttendanceMonths({
// //     required String classId,
// //     required String studentUid,
// //   }) async {
// //     final cleanClassId = classId.trim();
// //     final cleanStudentUid = studentUid.trim();

// //     final Set<String> months = {};

// //     final studentSnapshot = await _firestore
// //         .collection('attendance')
// //         .where('studentId', isEqualTo: cleanStudentUid)
// //         .get();

// //     for (final doc in studentSnapshot.docs) {
// //       final data = doc.data();
// //       final date = data['date'];

// //       if (date is Timestamp) {
// //         final d = date.toDate();
// //         months.add('${d.year}_${d.month}');
// //       }
// //     }

// //     final classSnapshot = await _firestore
// //         .collection('attendance')
// //         .where('classId', isEqualTo: cleanClassId)
// //         .get();

// //     for (final doc in classSnapshot.docs) {
// //       final data = doc.data();

// //       final records = Map<String, dynamic>.from(data['records'] ?? {});

// //       if (!records.containsKey(cleanStudentUid)) continue;

// //       final date = data['date'];

// //       if (date is Timestamp) {
// //         final d = date.toDate();
// //         months.add('${d.year}_${d.month}');
// //       }
// //     }

// //     return months.toList()
// //       ..sort((a, b) {
// //         final aParts = a.split('_');
// //         final bParts = b.split('_');

// //         final aDate = DateTime(
// //           int.parse(aParts[0]),
// //           int.parse(aParts[1]),
// //         );

// //         final bDate = DateTime(
// //           int.parse(bParts[0]),
// //           int.parse(bParts[1]),
// //         );

// //         return aDate.compareTo(bDate);
// //       });
// //   }
// // }


// // import 'package:cloud_firestore/cloud_firestore.dart';

// // class AttendanceRepository {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// //   // Future<Map<String, String>> getMonthlyAttendance({
// //   //   required String classId,
// //   //   required int year,
// //   //   required int month,
// //   //   required String studentUid,
// //   // }) async {
// //   //   final totalDays = DateTime(year, month + 1, 0).day;

// //   //   final cleanClassId = classId.trim();
// //   //   final cleanStudentUid = studentUid.trim();

// //   //   final classFutures = <Future<DocumentSnapshot<Map<String, dynamic>>>>[];
// //   //   final studentFutures = <Future<DocumentSnapshot<Map<String, dynamic>>>>[];

// //   //   for (int day = 1; day <= totalDays; day++) {
// //   //     final dateStr =
// //   //         '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

// //   //     final classDocId = '${cleanClassId}_$dateStr';
// //   //     final studentDocId = '${cleanStudentUid}_${year}_${month}_$day';

// //   //     classFutures.add(_firestore.collection('attendance').doc(classDocId).get());
// //   //     studentFutures.add(_firestore.collection('attendance').doc(studentDocId).get());
// //   //   }

// //   //   final classDocs = await Future.wait(classFutures);
// //   //   final studentDocs = await Future.wait(studentFutures);

// //   //   final result = <String, String>{};

// //   //   for (int i = 0; i < totalDays; i++) {
// //   //     final day = i + 1;

// //   //     final dateStr =
// //   //         '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

// //   //     String? finalStatus;

// //   //     final classDoc = classDocs[i];

// //   //     if (classDoc.exists && classDoc.data() != null) {
// //   //       final data = classDoc.data()!;
// //   //       final records = Map<String, dynamic>.from(data['records'] ?? {});

// //   //       if (records.containsKey(cleanStudentUid)) {
// //   //         finalStatus =
// //   //             records[cleanStudentUid].toString().trim().toLowerCase();
// //   //       }
// //   //     }

// //   //     final studentDoc = studentDocs[i];

// //   //     if (studentDoc.exists && studentDoc.data() != null) {
// //   //       final data = studentDoc.data()!;

// //   //       final docStudentId = data['studentId']?.toString().trim();
// //   //       final status = data['status']?.toString().trim().toLowerCase();

// //   //       if (docStudentId == cleanStudentUid && status != null) {
// //   //         finalStatus = status;
// //   //       }
// //   //     }

// //   //     if (finalStatus != null) {
// //   //       result[dateStr] = finalStatus;
// //   //     }
// //   //   }

// //   //   return result;
// //   // }

// //   // Future<List<String>> getStudentAttendanceMonths({
// //   //   required String classId,
// //   //   required String studentUid,
// //   // }) async {
// //   //   final cleanClassId = classId.trim();
// //   //   final cleanStudentUid = studentUid.trim();

// //   //   final months = <String>{};

// //   //   final studentSnapshot = await _firestore
// //   //       .collection('attendance')
// //   //       .where('studentId', isEqualTo: cleanStudentUid)
// //   //       .get();

// //   //   for (final doc in studentSnapshot.docs) {
// //   //     final data = doc.data();
// //   //     final date = data['date'];

// //   //     if (date is Timestamp) {
// //   //       final d = date.toDate();
// //   //       months.add('${d.year}_${d.month}');
// //   //     }
// //   //   }

// //   //   final classSnapshot = await _firestore
// //   //       .collection('attendance')
// //   //       .where('classId', isEqualTo: cleanClassId)
// //   //       .get();

// //   //   for (final doc in classSnapshot.docs) {
// //   //     final data = doc.data();
// //   //     final records = Map<String, dynamic>.from(data['records'] ?? {});

// //   //     if (!records.containsKey(cleanStudentUid)) continue;

// //   //     final date = data['date'];

// //   //     if (date is Timestamp) {
// //   //       final d = date.toDate();
// //   //       months.add('${d.year}_${d.month}');
// //   //     }
// //   //   }

// //   //   return months.toList()
// //   //     ..sort((a, b) {
// //   //       final aParts = a.split('_');
// //   //       final bParts = b.split('_');

// //   //       final aDate = DateTime(int.parse(aParts[0]), int.parse(aParts[1]));
// //   //       final bDate = DateTime(int.parse(bParts[0]), int.parse(bParts[1]));

// //   //       return aDate.compareTo(bDate);
// //   //     });
// //   // }

// // Future<Map<String, String>> getMonthlyAttendance({
// //   required String classId,
// //   required int year,
// //   required int month,
// //   required String studentUid,
// // }) async {
// //   final totalDays = DateTime(year, month + 1, 0).day;

// //   final cleanClassId = classId.trim();
// //   final cleanStudentUid = studentUid.trim();

// //   final classFutures =
// //       <Future<DocumentSnapshot<Map<String, dynamic>>>>[];

// //   final studentFutures1 =
// //       <Future<DocumentSnapshot<Map<String, dynamic>>>>[];

// //   final studentFutures2 =
// //       <Future<DocumentSnapshot<Map<String, dynamic>>>>[];

// //   for (int day = 1; day <= totalDays; day++) {
// //     final dateStr =
// //         '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

// //     final classDocId = '${cleanClassId}_$dateStr';

// //     // Format: UID_2026_5_6
// //     final studentDocId1 = '${cleanStudentUid}_${year}_${month}_$day';

// //     // Format: UID_2026_05_06
// //     final studentDocId2 =
// //         '${cleanStudentUid}_${year}_${month.toString().padLeft(2, '0')}_${day.toString().padLeft(2, '0')}';

// //     classFutures.add(
// //       _firestore.collection('attendance').doc(classDocId).get(),
// //     );

// //     studentFutures1.add(
// //       _firestore.collection('attendance').doc(studentDocId1).get(),
// //     );

// //     studentFutures2.add(
// //       _firestore.collection('attendance').doc(studentDocId2).get(),
// //     );
// //   }

// //   final results = await Future.wait([
// //     Future.wait(classFutures),
// //     Future.wait(studentFutures1),
// //     Future.wait(studentFutures2),
// //   ]);

// //   final classDocs =
// //       results[0] as List<DocumentSnapshot<Map<String, dynamic>>>;

// //   final studentDocs1 =
// //       results[1] as List<DocumentSnapshot<Map<String, dynamic>>>;

// //   final studentDocs2 =
// //       results[2] as List<DocumentSnapshot<Map<String, dynamic>>>;

// //   final result = <String, String>{};

// //   for (int i = 0; i < totalDays; i++) {
// //     final day = i + 1;

// //     final dateStr =
// //         '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

// //     String? finalStatus;

// //     // 1. Class sheet attendance
// //     final classDoc = classDocs[i];

// //     if (classDoc.exists && classDoc.data() != null) {
// //       final data = classDoc.data()!;

// //       final records =
// //           Map<String, dynamic>.from(data['records'] ?? {});

// //       if (records.containsKey(cleanStudentUid)) {
// //         finalStatus =
// //             records[cleanStudentUid].toString().trim().toLowerCase();
// //       }
// //     }

// //     // 2. Individual correction doc format 1
// //     final studentDoc1 = studentDocs1[i];

// //     if (studentDoc1.exists && studentDoc1.data() != null) {
// //       final data = studentDoc1.data()!;

// //       final docStudentId =
// //           data['studentId']?.toString().trim();

// //       final status =
// //           data['status']?.toString().trim().toLowerCase();

// //       if (docStudentId == cleanStudentUid && status != null) {
// //         finalStatus = status;
// //       }
// //     }

// //     // 3. Individual correction doc format 2
// //     final studentDoc2 = studentDocs2[i];

// //     if (studentDoc2.exists && studentDoc2.data() != null) {
// //       final data = studentDoc2.data()!;

// //       final docStudentId =
// //           data['studentId']?.toString().trim();

// //       final status =
// //           data['status']?.toString().trim().toLowerCase();

// //       if (docStudentId == cleanStudentUid && status != null) {
// //         finalStatus = status;
// //       }
// //     }

// //     if (finalStatus == 'present' || finalStatus == 'absent') {
// //       result[dateStr] = finalStatus!;
// //     }
// //   }

// //   return result;
// // }



// // Future<List<String>> getStudentAttendanceMonths({
// //   required String classId,
// //   required String studentUid,
// // }) async {
// //   final cleanClassId = classId.trim();
// //   final cleanStudentUid = studentUid.trim();

// //   final months = <String>{};

// //   final studentSnapshot = await _firestore
// //       .collection('attendance')
// //       .where('studentId', isEqualTo: cleanStudentUid)
// //       .get();

// //   for (final doc in studentSnapshot.docs) {
// //     final data = doc.data();
// //     final date = data['date'];

// //     if (date is Timestamp) {
// //       final d = date.toDate();
// //       months.add('${d.year}_${d.month}');
// //     }
// //   }

// //   final classSnapshot = await _firestore
// //       .collection('attendance')
// //       .where('classId', isEqualTo: cleanClassId)
// //       .get();

// //   for (final doc in classSnapshot.docs) {
// //     final data = doc.data();
// //     final records = Map<String, dynamic>.from(data['records'] ?? {});

// //     if (!records.containsKey(cleanStudentUid)) continue;

// //     final date = data['date'];

// //     if (date is Timestamp) {
// //       final d = date.toDate();
// //       months.add('${d.year}_${d.month}');
// //     }
// //   }

// //   return months.toList()
// //     ..sort((a, b) {
// //       final aParts = a.split('_');
// //       final bParts = b.split('_');

// //       final aDate = DateTime(
// //         int.parse(aParts[0]),
// //         int.parse(aParts[1]),
// //       );

// //       final bDate = DateTime(
// //         int.parse(bParts[0]),
// //         int.parse(bParts[1]),
// //       );

// //       return aDate.compareTo(bDate);
// //     });
// // }

// //   Future<Map<int, Map<String, int>>> getYearlyAttendanceSummary({
// //     required String classId,
// //     required int year,
// //     required String studentUid,
// //   }) async {
// //     final cleanClassId = classId.trim();
// //     final cleanStudentUid = studentUid.trim();

// //     final summary = <int, Map<String, int>>{};

// //     for (int month = 1; month <= 12; month++) {
// //       summary[month] = {
// //         'present': 0,
// //         'absent': 0,
// //       };
// //     }

// //     final studentSnapshot = await _firestore
// //         .collection('attendance')
// //         .where('studentId', isEqualTo: cleanStudentUid)
// //         .get();

// //     for (final doc in studentSnapshot.docs) {
// //       final data = doc.data();
// //       final date = data['date'];

// //       if (date is Timestamp) {
// //         final d = date.toDate();

// //         if (d.year == year) {
// //           final status = data['status']?.toString().trim().toLowerCase();

// //           if (status == 'present' || status == 'absent') {
// //             summary[d.month]![status!] = summary[d.month]![status!]! + 1;
// //           }
// //         }
// //       }
// //     }

// //     final classSnapshot = await _firestore
// //         .collection('attendance')
// //         .where('classId', isEqualTo: cleanClassId)
// //         .get();

// //     for (final doc in classSnapshot.docs) {
// //       final data = doc.data();
// //       final date = data['date'];

// //       if (date is Timestamp) {
// //         final d = date.toDate();

// //         if (d.year == year) {
// //           final records = Map<String, dynamic>.from(data['records'] ?? {});

// //           if (records.containsKey(cleanStudentUid)) {
// //             final status =
// //                 records[cleanStudentUid].toString().trim().toLowerCase();

// //             if (status == 'present' || status == 'absent') {
// //                   summary[d.month]![status!] = summary[d.month]![status!]! + 1;
// //             }
// //           }
// //         }
// //       }
// //     }

// //     return summary;
// //   }
// // }



// import 'package:cloud_firestore/cloud_firestore.dart';

// class AttendanceRepository {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;



//   List<String> _classIds(String classId) {
//   final clean = classId.trim();

//   return [
//     clean,
//     '${clean}B',
//     '${clean}G',
//   ];
// }

//   Future<Map<String, String>> getMonthlyAttendance({
//     required String classId,
//     required int year,
//     required int month,
//     required String studentUid,
//   }) async {
//     final totalDays = DateTime(year, month + 1, 0).day;

//     final cleanClassId = classId.trim();
// final classIds = _classIds(cleanClassId);
//     final cleanStudentUid = studentUid.trim();

//     final classFutures = <Future<DocumentSnapshot<Map<String, dynamic>>>>[];
//     final studentFutures1 = <Future<DocumentSnapshot<Map<String, dynamic>>>>[];
//     final studentFutures2 = <Future<DocumentSnapshot<Map<String, dynamic>>>>[];

//     for (int day = 1; day <= totalDays; day++) {
//       final dateStr =
//           '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

//       final classDocId = '${cleanClassId}_$dateStr';
//       final studentDocId1 = '${cleanStudentUid}_${year}_${month}_$day';
//       final studentDocId2 =
//           '${cleanStudentUid}_${year}_${month.toString().padLeft(2, '0')}_${day.toString().padLeft(2, '0')}';

//       classFutures.add(_firestore.collection('attendance').doc(classDocId).get());
//       studentFutures1.add(_firestore.collection('attendance').doc(studentDocId1).get());
//       studentFutures2.add(_firestore.collection('attendance').doc(studentDocId2).get());
//     }

//     final results = await Future.wait([
//       Future.wait(classFutures),
//       Future.wait(studentFutures1),
//       Future.wait(studentFutures2),
//     ]);

//     final classDocs = results[0] as List<DocumentSnapshot<Map<String, dynamic>>>;
//     final studentDocs1 = results[1] as List<DocumentSnapshot<Map<String, dynamic>>>;
//     final studentDocs2 = results[2] as List<DocumentSnapshot<Map<String, dynamic>>>;

//     final result = <String, String>{};

//     for (int i = 0; i < totalDays; i++) {
//       final day = i + 1;

//       final dateStr =
//           '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

//       String? finalStatus;

//       final classDoc = classDocs[i];

//       if (classDoc.exists && classDoc.data() != null) {
//         final data = classDoc.data()!;
//         final records = Map<String, dynamic>.from(data['records'] ?? {});

//         if (records.containsKey(cleanStudentUid)) {
//           finalStatus =
//               records[cleanStudentUid].toString().trim().toLowerCase();
//         }
//       }

//       final studentDoc1 = studentDocs1[i];

//       if (studentDoc1.exists && studentDoc1.data() != null) {
//         final data = studentDoc1.data()!;
//         final docStudentId = data['studentId']?.toString().trim();
//         final status = data['status']?.toString().trim().toLowerCase();

//         if (docStudentId == cleanStudentUid && status != null) {
//           finalStatus = status;
//         }
//       }

//       final studentDoc2 = studentDocs2[i];

//       if (studentDoc2.exists && studentDoc2.data() != null) {
//         final data = studentDoc2.data()!;
//         final docStudentId = data['studentId']?.toString().trim();
//         final status = data['status']?.toString().trim().toLowerCase();

//         if (docStudentId == cleanStudentUid && status != null) {
//           finalStatus = status;
//         }
//       }

//       if (finalStatus == 'present' || finalStatus == 'absent') {
//         result[dateStr] = finalStatus!;
//       }
//     }

//     return result;
//   }

//   Future<List<String>> getStudentAttendanceMonths({
//     required String classId,
//     required String studentUid,
//   }) async {
//     final cleanClassId = classId.trim();
//     final cleanStudentUid = studentUid.trim();

//     final months = <String>{};

//     final studentSnapshot = await _firestore
//         .collection('attendance')
//         .where('studentId', isEqualTo: cleanStudentUid)
//         .get();

//     for (final doc in studentSnapshot.docs) {
//       final date = doc.data()['date'];

//       if (date is Timestamp) {
//         final d = date.toDate();
//         months.add('${d.year}_${d.month}');
//       }
//     }

//     final classSnapshot = await _firestore
//         .collection('attendance')
//         .where('classId', isEqualTo: cleanClassId)
//         .get();

//     for (final doc in classSnapshot.docs) {
//       final data = doc.data();
//       final records = Map<String, dynamic>.from(data['records'] ?? {});

//       if (!records.containsKey(cleanStudentUid)) continue;

//       final date = data['date'];

//       if (date is Timestamp) {
//         final d = date.toDate();
//         months.add('${d.year}_${d.month}');
//       }
//     }

//     return months.toList()
//       ..sort((a, b) {
//         final aParts = a.split('_');
//         final bParts = b.split('_');

//         final aDate = DateTime(
//           int.parse(aParts[0]),
//           int.parse(aParts[1]),
//         );

//         final bDate = DateTime(
//           int.parse(bParts[0]),
//           int.parse(bParts[1]),
//         );

//         return aDate.compareTo(bDate);
//       });
//   }

//   Future<List<int>> getStudentAttendanceYears({
//     required String classId,
//     required String studentUid,
//   }) async {
//     final cleanClassId = classId.trim();
//     final cleanStudentUid = studentUid.trim();

//     final years = <int>{};

//     final studentSnapshot = await _firestore
//         .collection('attendance')
//         .where('studentId', isEqualTo: cleanStudentUid)
//         .get();

//     for (final doc in studentSnapshot.docs) {
//       final date = doc.data()['date'];

//       if (date is Timestamp) {
//         years.add(date.toDate().year);
//       }
//     }

//     final classSnapshot = await _firestore
//         .collection('attendance')
//         .where('classId', isEqualTo: cleanClassId)
//         .get();

//     for (final doc in classSnapshot.docs) {
//       final data = doc.data();
//       final records = Map<String, dynamic>.from(data['records'] ?? {});

//       if (!records.containsKey(cleanStudentUid)) continue;

//       final date = data['date'];

//       if (date is Timestamp) {
//         years.add(date.toDate().year);
//       }
//     }

//     return years.toList()..sort();
//   }

//   Future<Map<int, Map<String, int>>> getYearlyAttendanceSummary({
//     required String classId,
//     required int year,
//     required String studentUid,
//   }) async {
//     final cleanClassId = classId.trim();
//     final cleanStudentUid = studentUid.trim();

//     final summary = <int, Map<String, int>>{};

//     for (int month = 1; month <= 12; month++) {
//       summary[month] = {
//         'present': 0,
//         'absent': 0,
//       };
//     }

//     final studentSnapshot = await _firestore
//         .collection('attendance')
//         .where('studentId', isEqualTo: cleanStudentUid)
//         .get();

//     for (final doc in studentSnapshot.docs) {
//       final data = doc.data();
//       final date = data['date'];

//       if (date is Timestamp) {
//         final d = date.toDate();

//         if (d.year == year) {
//           final status = data['status']?.toString().trim().toLowerCase();

//           if (status == 'present') {
//             summary[d.month]!['present'] =
//                 summary[d.month]!['present']! + 1;
//           }

//           if (status == 'absent') {
//             summary[d.month]!['absent'] =
//                 summary[d.month]!['absent']! + 1;
//           }
//         }
//       }
//     }

//     final classSnapshot = await _firestore
//         .collection('attendance')
//         .where('classId', isEqualTo: cleanClassId)
//         .get();

//     for (final doc in classSnapshot.docs) {
//       final data = doc.data();
//       final date = data['date'];

//       if (date is Timestamp) {
//         final d = date.toDate();

//         if (d.year == year) {
//           final records = Map<String, dynamic>.from(data['records'] ?? {});

//           if (records.containsKey(cleanStudentUid)) {
//             final status =
//                 records[cleanStudentUid].toString().trim().toLowerCase();

//             if (status == 'present') {
//               summary[d.month]!['present'] =
//                   summary[d.month]!['present']! + 1;
//             }

//             if (status == 'absent') {
//               summary[d.month]!['absent'] =
//                   summary[d.month]!['absent']! + 1;
//             }
//           }
//         }
//       }
//     }

//     return summary;
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> _classIds(String classId) {
    final clean = classId.trim();

    if (clean.endsWith('B') || clean.endsWith('G')) {
      final base = clean.substring(0, clean.length - 1);

      return [
        clean,
        base,
      ];
    }

    return [
      clean,
      '${clean}B',
      '${clean}G',
    ];
  }

  Future<Map<String, String>> getMonthlyAttendance({
    required String classId,
    required int year,
    required int month,
    required String studentUid,
  }) async {
    final totalDays = DateTime(year, month + 1, 0).day;

    final cleanClassId = classId.trim();
    final cleanStudentUid = studentUid.trim();
    final classIds = _classIds(cleanClassId);

    final classFutures = <Future<DocumentSnapshot<Map<String, dynamic>>>>[];
    final studentFutures1 = <Future<DocumentSnapshot<Map<String, dynamic>>>>[];
    final studentFutures2 = <Future<DocumentSnapshot<Map<String, dynamic>>>>[];

    for (int day = 1; day <= totalDays; day++) {
      final dateStr =
          '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

      final studentDocId1 = '${cleanStudentUid}_${year}_${month}_$day';
      final studentDocId2 =
          '${cleanStudentUid}_${year}_${month.toString().padLeft(2, '0')}_${day.toString().padLeft(2, '0')}';

      for (final id in classIds) {
        final classDocId = '${id}_$dateStr';

        classFutures.add(
          _firestore.collection('attendance').doc(classDocId).get(),
        );
      }

      studentFutures1.add(
        _firestore.collection('attendance').doc(studentDocId1).get(),
      );

      studentFutures2.add(
        _firestore.collection('attendance').doc(studentDocId2).get(),
      );
    }

    final results = await Future.wait([
      Future.wait(classFutures),
      Future.wait(studentFutures1),
      Future.wait(studentFutures2),
    ]);

    final classDocs =
        results[0] as List<DocumentSnapshot<Map<String, dynamic>>>;
    final studentDocs1 =
        results[1] as List<DocumentSnapshot<Map<String, dynamic>>>;
    final studentDocs2 =
        results[2] as List<DocumentSnapshot<Map<String, dynamic>>>;

    final result = <String, String>{};

    for (int i = 0; i < totalDays; i++) {
      final day = i + 1;

      final dateStr =
          '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

      String? finalStatus;

      for (int c = 0; c < classIds.length; c++) {
        final classDoc = classDocs[(i * classIds.length) + c];

        if (classDoc.exists && classDoc.data() != null) {
          final data = classDoc.data()!;
          final records = Map<String, dynamic>.from(data['records'] ?? {});

          if (records.containsKey(cleanStudentUid)) {
            finalStatus =
                records[cleanStudentUid].toString().trim().toLowerCase();
            break;
          }
        }
      }

      final studentDoc1 = studentDocs1[i];

      if (studentDoc1.exists && studentDoc1.data() != null) {
        final data = studentDoc1.data()!;
        final docStudentId = data['studentId']?.toString().trim();
        final status = data['status']?.toString().trim().toLowerCase();

        if (docStudentId == cleanStudentUid && status != null) {
          finalStatus = status;
        }
      }

      final studentDoc2 = studentDocs2[i];

      if (studentDoc2.exists && studentDoc2.data() != null) {
        final data = studentDoc2.data()!;
        final docStudentId = data['studentId']?.toString().trim();
        final status = data['status']?.toString().trim().toLowerCase();

        if (docStudentId == cleanStudentUid && status != null) {
          finalStatus = status;
        }
      }

      if (finalStatus == 'present' || finalStatus == 'absent') {
        result[dateStr] = finalStatus!;
      }
    }

    return result;
  }

  Future<List<String>> getStudentAttendanceMonths({
    required String classId,
    required String studentUid,
  }) async {
    final cleanClassId = classId.trim();
    final cleanStudentUid = studentUid.trim();
    final classIds = _classIds(cleanClassId);

    final months = <String>{};

    final studentSnapshot = await _firestore
        .collection('attendance')
        .where('studentId', isEqualTo: cleanStudentUid)
        .get();

    for (final doc in studentSnapshot.docs) {
      final date = doc.data()['date'];

      if (date is Timestamp) {
        final d = date.toDate();
        months.add('${d.year}_${d.month}');
      }
    }

    final classSnapshot = await _firestore
        .collection('attendance')
        .where('classId', whereIn: classIds)
        .get();

    for (final doc in classSnapshot.docs) {
      final data = doc.data();
      final records = Map<String, dynamic>.from(data['records'] ?? {});

      if (!records.containsKey(cleanStudentUid)) continue;

      final date = data['date'];

      if (date is Timestamp) {
        final d = date.toDate();
        months.add('${d.year}_${d.month}');
      }
    }

    return months.toList()
      ..sort((a, b) {
        final aParts = a.split('_');
        final bParts = b.split('_');

        final aDate = DateTime(
          int.parse(aParts[0]),
          int.parse(aParts[1]),
        );

        final bDate = DateTime(
          int.parse(bParts[0]),
          int.parse(bParts[1]),
        );

        return aDate.compareTo(bDate);
      });
  }

  Future<List<int>> getStudentAttendanceYears({
    required String classId,
    required String studentUid,
  }) async {
    final cleanClassId = classId.trim();
    final cleanStudentUid = studentUid.trim();
    final classIds = _classIds(cleanClassId);

    final years = <int>{};

    final studentSnapshot = await _firestore
        .collection('attendance')
        .where('studentId', isEqualTo: cleanStudentUid)
        .get();

    for (final doc in studentSnapshot.docs) {
      final date = doc.data()['date'];

      if (date is Timestamp) {
        years.add(date.toDate().year);
      }
    }

    final classSnapshot = await _firestore
        .collection('attendance')
        .where('classId', whereIn: classIds)
        .get();

    for (final doc in classSnapshot.docs) {
      final data = doc.data();
      final records = Map<String, dynamic>.from(data['records'] ?? {});

      if (!records.containsKey(cleanStudentUid)) continue;

      final date = data['date'];

      if (date is Timestamp) {
        years.add(date.toDate().year);
      }
    }

    return years.toList()..sort();
  }

  Future<Map<int, Map<String, int>>> getYearlyAttendanceSummary({
    required String classId,
    required int year,
    required String studentUid,
  }) async {
    final cleanClassId = classId.trim();
    final cleanStudentUid = studentUid.trim();
    final classIds = _classIds(cleanClassId);

    final summary = <int, Map<String, int>>{};

    for (int month = 1; month <= 12; month++) {
      summary[month] = {
        'present': 0,
        'absent': 0,
      };
    }

    final studentSnapshot = await _firestore
        .collection('attendance')
        .where('studentId', isEqualTo: cleanStudentUid)
        .get();

    for (final doc in studentSnapshot.docs) {
      final data = doc.data();
      final date = data['date'];

      if (date is Timestamp) {
        final d = date.toDate();

        if (d.year == year) {
          final status = data['status']?.toString().trim().toLowerCase();

          if (status == 'present') {
            summary[d.month]!['present'] =
                summary[d.month]!['present']! + 1;
          }

          if (status == 'absent') {
            summary[d.month]!['absent'] =
                summary[d.month]!['absent']! + 1;
          }
        }
      }
    }

    final classSnapshot = await _firestore
        .collection('attendance')
        .where('classId', whereIn: classIds)
        .get();

    for (final doc in classSnapshot.docs) {
      final data = doc.data();
      final date = data['date'];

      if (date is Timestamp) {
        final d = date.toDate();

        if (d.year == year) {
          final records = Map<String, dynamic>.from(data['records'] ?? {});

          if (records.containsKey(cleanStudentUid)) {
            final status =
                records[cleanStudentUid].toString().trim().toLowerCase();

            if (status == 'present') {
              summary[d.month]!['present'] =
                  summary[d.month]!['present']! + 1;
            }

            if (status == 'absent') {
              summary[d.month]!['absent'] =
                  summary[d.month]!['absent']! + 1;
            }
          }
        }
      }
    }

    return summary;
  }
}