class DateFormatter {

  DateFormatter._();

  static const _dayNames = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
    "Minggu",
  ];

  static const _monthNames = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember",
  ];

  /// e.g. "Selasa, 19 Mei"
  static String full(DateTime date) {
    final dayName = _dayNames[date.weekday - 1];
    final monthName = _monthNames[date.month - 1];
    return "$dayName, ${date.day} $monthName";
  }

  /// e.g. "19 Mei"
  static String shortDate(DateTime date) {
    final monthName = _monthNames[date.month - 1];
    return "${date.day} $monthName";
  }
}
