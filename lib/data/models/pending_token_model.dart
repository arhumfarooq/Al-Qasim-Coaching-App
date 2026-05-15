class PendingTokenModel {
  final int id;
  final String tokenNo;
  final String receiverName;
  final String rashanDistribute;
  final int flagType;

  PendingTokenModel({
    required this.id,
    required this.tokenNo,
    required this.receiverName,
    required this.rashanDistribute,
    required this.flagType,
  });

  factory PendingTokenModel.fromJson(Map<String, dynamic> json) {
    return PendingTokenModel(
      id: json['Id'] ?? 0,
      tokenNo: json['TokenNo'] ?? '',
      receiverName: json['ReceiverName'] ?? '',
      rashanDistribute: json['RashanDistribute'] ?? '',
      flagType: json['FlagTypeId'] ?? '',
    );
  }
}
