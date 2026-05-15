class ApiConstants {
  static const String baseUrl = "http://108.181.202.39:407/api";

  // Auth
  static const String login = "/VolunteerRegistration/Login";

  // Volunteer
  static const String loadVolunteers =
      "/VolunteerRegistration/LoadAllData";

  static const String approveVolunteer =
      "/VolunteerRegistration/ApproveVolunteer";

  // Rashan
  static const String submitQr =
      "/RashanDistributeVerification/RashanDistributed";

  static const String loadPendingTokens =
      "/RashanDistributeVerification/LoadAllData";


  static const String allowScaning =
      "/RashanDistributeVerification/AllowScaning";

}
