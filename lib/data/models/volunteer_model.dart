
// class Volunteer {
//   final int id;
//   final String volunteerId;
//   final String userName;
//   final String fatherName;
//   final String userStatus;
//   final bool isApproved;

//   Volunteer({
//     required this.id,
//     required this.volunteerId,
//     required this.userName,
//     required this.fatherName,
//     required this.userStatus,
//     required this.isApproved,
//   });

//   factory Volunteer.fromJson(Map<String, dynamic> json) {
//     return Volunteer(
//       id: json['Id'],
//       volunteerId: json['VolunteerId'] ?? '',
//       userName: json['UserName'] ?? '',
//       fatherName: json['FatherName'] ?? '',
//       userStatus: json['UserStatus'] ?? '',
//       isApproved: json['IsApproved'] ?? false,
//     );
//   }
// }


// models/volunteer_model.dart
class Volunteer {
  final int id;
  final String volunteerId;
  final String userName;
  final String fatherName;
  final String cnicNo;
  final String address;
  final String mobileNo;
  final String password;
  final int statusId;
  final int volunteerTypeId;
  final dynamic oathOn;
  final dynamic isOath;
  final int totalForm;
  final String volunteerType;
  final String statusType;
  final dynamic referenceById;
  final bool isApproved;
  final String userStatus;

  Volunteer({
    required this.id,
    required this.volunteerId,
    required this.userName,
    required this.fatherName,
    required this.cnicNo,
    required this.address,
    required this.mobileNo,
    required this.password,
    required this.statusId,
    required this.volunteerTypeId,
    required this.oathOn,
    required this.isOath,
    required this.totalForm,
    required this.volunteerType,
    required this.statusType,
    required this.referenceById,
    required this.isApproved,
    required this.userStatus,
  });

  factory Volunteer.fromJson(Map<String, dynamic> json) {
    return Volunteer(
      id: json['Id'] ?? 0,
      volunteerId: json['VolunteerId']?.toString() ?? '',
      userName: json['UserName']?.toString() ?? '',
      fatherName: json['FatherName']?.toString() ?? '',
      cnicNo: json['CNICNo']?.toString() ?? '',
      address: json['Address']?.toString() ?? '',
      mobileNo: json['MobileNo']?.toString() ?? '',
      password: json['Password']?.toString() ?? '',
      statusId: json['StatusId'] ?? 0,
      volunteerTypeId: json['VolunteerTypeId'] ?? 0,
      oathOn: json['OathOn'],
      isOath: json['IsOath'],
      totalForm: json['TotalForm'] ?? 0,
      volunteerType: json['VolunteerType']?.toString() ?? '',
      statusType: json['StatusType']?.toString() ?? '',
      referenceById: json['ReferencebyId'],
      isApproved: json['IsApproved'] ?? false,
      userStatus: json['UserStatus']?.toString() ?? 'Pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'VolunteerId': volunteerId,
      'UserName': userName,
      'FatherName': fatherName,
      'CNICNo': cnicNo,
      'Address': address,
      'MobileNo': mobileNo,
      'Password': password,
      'StatusId': statusId,
      'VolunteerTypeId': volunteerTypeId,
      'OathOn': oathOn,
      'IsOath': isOath,
      'TotalForm': totalForm,
      'VolunteerType': volunteerType,
      'StatusType': statusType,
      'ReferencebyId': referenceById,
      'IsApproved': isApproved,
      'UserStatus': userStatus,
    };
  }
}