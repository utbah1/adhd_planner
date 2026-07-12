class AnalyticsDashboardModel {
  final int totalTasks;
  final int completedTasks;
  final int pendingTasks;
  final double focusHours;
  final int completedFocusPlans;
  final int activeFocusPlans;
  final int currentStreak;
  final double productivityScore;

  AnalyticsDashboardModel({
    required this.totalTasks,
    required this.completedTasks,
    required this.pendingTasks,
    required this.focusHours,
    required this.completedFocusPlans,
    required this.activeFocusPlans,
    required this.currentStreak,
    required this.productivityScore,
  });

  factory AnalyticsDashboardModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsDashboardModel(
      totalTasks: json["total_tasks"] ?? 0,
      completedTasks: json["completed_tasks"] ?? 0,
      pendingTasks: json["pending_tasks"] ?? 0,
      focusHours: (json["focus_hours"] ?? 0).toDouble(),
      completedFocusPlans: json["completed_focus_plans"] ?? 0,
      activeFocusPlans: json["active_focus_plans"] ?? 0,
      currentStreak: json["current_streak"] ?? 0,
      productivityScore: (json["productivity_score"] ?? 0).toDouble(),
    );
  }
}
