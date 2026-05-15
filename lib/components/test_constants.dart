class AppDateUtils {

  static const List<String> shortMonths = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const List<String> fullMonths = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static String formatDate(DateTime date) {
    return '${shortMonths[date.month - 1]} ${date.day}, ${date.year}';
  }

  static String getMonthName(int month) {
    return fullMonths[month - 1];
  }

  static String getShortMonthName(int month) {
    return shortMonths[month - 1];
  }
}