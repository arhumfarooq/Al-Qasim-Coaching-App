class YearlyMonthModel {
  final int year;
  final int month;
  final String monthName;
  final int present;
  final int absent;
  final int holiday;
  final bool hasData;

  YearlyMonthModel({
    required this.year,
    required this.month,
    required this.monthName,
    required this.present,
    required this.absent,
    required this.holiday,
    required this.hasData,
  });

  int get workingDays => present + absent;

  double get percentage {
    if (workingDays == 0) return 0;
    return (present / workingDays) * 100;
  }
}