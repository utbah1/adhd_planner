class FocusPlanCreateRequest {
  final int totalFocusMinutes;
  final int focusDuration;
  final int breakDuration;
  final String? taskId;

  FocusPlanCreateRequest({
    required this.totalFocusMinutes,
    this.focusDuration = 30,
    this.breakDuration = 5,
    this.taskId,
  });

  Map<String, dynamic> toJson() {
    return {
      "total_focus_minutes": totalFocusMinutes,
      "focus_duration": focusDuration,
      "break_duration": breakDuration,
      "task_id": taskId,
    };
  }
}
