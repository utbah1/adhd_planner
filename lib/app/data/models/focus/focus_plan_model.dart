class FocusPlanModel {
  final String planId;
  final String userId;
  final String? taskId;
  final int totalFocusMinutes;
  final int focusDuration;
  final int breakDuration;
  final int totalCycles;
  final int completedCycles;
  final String status;

  FocusPlanModel({
    required this.planId,
    required this.userId,
    this.taskId,
    required this.totalFocusMinutes,
    required this.focusDuration,
    required this.breakDuration,
    required this.totalCycles,
    required this.completedCycles,
    required this.status,
  });

  factory FocusPlanModel.fromJson(Map<String, dynamic> json) {
    return FocusPlanModel(
      planId: json["plan_id"] ?? "",
      userId: json["user_id"] ?? "",
      taskId: json["task_id"],
      totalFocusMinutes: json["total_focus_minutes"] ?? 0,
      focusDuration: json["focus_duration"] ?? 0,
      breakDuration: json["break_duration"] ?? 0,
      totalCycles: json["total_cycles"] ?? 0,
      completedCycles: json["completed_cycles"] ?? 0,
      status: json["status"] ?? "active",
    );
  }
}
