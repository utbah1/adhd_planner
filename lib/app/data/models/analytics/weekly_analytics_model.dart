class WeeklyAnalyticsModel {
  final int monday;
  final int tuesday;
  final int wednesday;
  final int thursday;
  final int friday;
  final int saturday;
  final int sunday;

  WeeklyAnalyticsModel({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory WeeklyAnalyticsModel.fromJson(Map<String, dynamic> json) {
    return WeeklyAnalyticsModel(
      monday: json["Monday"] ?? 0,
      tuesday: json["Tuesday"] ?? 0,
      wednesday: json["Wednesday"] ?? 0,
      thursday: json["Thursday"] ?? 0,
      friday: json["Friday"] ?? 0,
      saturday: json["Saturday"] ?? 0,
      sunday: json["Sunday"] ?? 0,
    );
  }

  /// Handy for feeding straight into a bar/line chart widget.
  Map<String, int> toChartMap() {
    return {
      "Mon": monday,
      "Tue": tuesday,
      "Wed": wednesday,
      "Thu": thursday,
      "Fri": friday,
      "Sat": saturday,
      "Sun": sunday,
    };
  }
}
