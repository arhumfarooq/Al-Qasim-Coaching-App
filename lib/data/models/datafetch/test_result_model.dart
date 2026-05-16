// import 'package:cloud_firestore/cloud_firestore.dart';

// class TestResultModel {
//   final String id;
//   final String classId;
//   final String title;
//   final DateTime testDate;
//   final int totalMarks;
//   final int obtainedMarks;
//   final String chapterName;
//   final int rank;

//   TestResultModel({
//     required this.id,
//     required this.classId,
//     required this.title,
//     required this.testDate,
//     required this.totalMarks,
//     required this.obtainedMarks, required this.chapterName, this.rank = 0,
//   });

//   double get percentage {
//     if (totalMarks == 0) return 0;
//     return (obtainedMarks / totalMarks) * 100;
//   }

//   // factory TestResultModel.fromDoc({
//   //   required QueryDocumentSnapshot<Map<String, dynamic>> doc,
//   //   required String studentUid,
//   // }) {
//   //   final data = doc.data();

//   //   final scores = Map<String, dynamic>.from(data['scores'] ?? {});

//   //   return TestResultModel(
//   //     id: doc.id,
//   //     classId: data['classId']?.toString() ?? '',
//   //     title: data['title']?.toString() ?? '',
//   //     testDate: data['testDate'] is Timestamp
//   //         ? (data['testDate'] as Timestamp).toDate()
//   //         : DateTime.now(),
//   //     totalMarks: int.tryParse(data['totalMarks'].toString()) ?? 0,
//   //     obtainedMarks: int.tryParse(scores[studentUid].toString()) ?? 0,
//   //   );
//   // }

// //   factory TestResultModel.fromDoc({
// //   required QueryDocumentSnapshot<Map<String, dynamic>> doc,
// //   required String studentKey,
// // }) {
// //   final data = doc.data();
// //   final scores = Map<String, dynamic>.from(data['scores'] ?? {});

// //   return TestResultModel(
// //     id: doc.id,
// //     classId: data['classId']?.toString() ?? '',
// //     title: data['title']?.toString() ?? '',
// //     testDate: data['testDate'] is Timestamp
// //         ? (data['testDate'] as Timestamp).toDate()
// //         : DateTime.now(),
// //     totalMarks: int.tryParse(data['totalMarks'].toString()) ?? 0,
// //     obtainedMarks: int.tryParse(scores[studentKey].toString()) ?? 0,
// //     chapterName: data['chapterName']?.toString() ?? '',
// //     // rank: int.tryParse(data['rank'].toString()) ?? 0,

    
// //   );
// // }

// factory TestResultModel.fromDoc({
//   required QueryDocumentSnapshot<Map<String, dynamic>> doc,
//   required String studentKey,
// }) {

//   final data = doc.data();

//   final scores =
//       Map<String, dynamic>.from(data['scores'] ?? {});

//   /// STUDENT MARKS
//   final obtainedMarks =
//       int.tryParse(
//         scores[studentKey]?.toString() ?? '0',
//       ) ?? 0;

//   /// ALL SCORES
//   final allScores = scores.values
//       .map(
//         (e) => int.tryParse(e.toString()) ?? 0,
//       )
//       .toList()
//     ..sort((a, b) => b.compareTo(a));

//   /// CALCULATE RANK
//   final rankIndex =
//       allScores.indexOf(obtainedMarks);

//   final rank =
//       rankIndex == -1 ? 0 : rankIndex + 1;

//   return TestResultModel(
//     id: doc.id,

//     classId:
//         data['classId']?.toString() ?? '',

//     title:
//         data['title']?.toString() ?? '',

//     testDate:
//         data['testDate'] is Timestamp
//             ? (data['testDate'] as Timestamp)
//                 .toDate()
//             : DateTime.now(),

//     totalMarks:
//         int.tryParse(
//           data['totalMarks'].toString(),
//         ) ?? 0,

//     obtainedMarks: obtainedMarks,

//     chapterName:
//         data['chapterName']?.toString() ?? '',

//     rank: rank,
//   );
// }
// }



import 'package:cloud_firestore/cloud_firestore.dart';

class TestResultModel {
  final String id;
  final String classId;
  final String title;
  final DateTime testDate;
  final int totalMarks;
  final int obtainedMarks;
  final String chapterName;
  final int rank;
  final String rollNo;

  TestResultModel({
    required this.id,
    required this.classId,
    required this.title,
    required this.testDate,
    required this.totalMarks,
    required this.obtainedMarks,
    this.chapterName = '',
    this.rank = 0, required this.rollNo,
  });

  double get percentage {
    if (totalMarks == 0) return 0;
    return (obtainedMarks / totalMarks) * 100;
  }

  factory TestResultModel.fromDoc({
    required QueryDocumentSnapshot<Map<String, dynamic>> doc,
    required String studentKey,
  }) {
    final data = doc.data();

    final scores = Map<String, dynamic>.from(data['scores'] ?? {});

    final obtainedMarks =
        int.tryParse(scores[studentKey]?.toString() ?? '0') ?? 0;

    final allScores = scores.values
        .map((e) => int.tryParse(e?.toString() ?? '0') ?? 0)
        .toList()
      ..sort((a, b) => b.compareTo(a));

    final rankIndex = allScores.indexOf(obtainedMarks);
    final calculatedRank = rankIndex == -1 ? 0 : rankIndex + 1;

    return TestResultModel(
      id: doc.id,
      classId: data['classId']?.toString() ?? '',
      title: data['title']?.toString() ?? '', 
      testDate: data['testDate'] is Timestamp
          ? (data['testDate'] as Timestamp).toDate()
          : DateTime.now(),
      totalMarks: int.tryParse(data['totalMarks']?.toString() ?? '0') ?? 0,
      obtainedMarks: obtainedMarks,
      chapterName: data['chapterName']?.toString() ?? '',
      rank: calculatedRank, rollNo: studentKey,
    );
  }
}