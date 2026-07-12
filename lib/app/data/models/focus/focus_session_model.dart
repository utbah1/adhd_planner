class FocusSessionModel {
  final String sessionId;
  final String planId;
  final String userId;
  final int cycle;
  final String type;
  final int duration;
  final bool completed;

  FocusSessionModel({
    required this.sessionId,
    required this.planId,
    required this.userId,
    required this.cycle,
    required this.type,
    required this.duration,
    required this.completed,
  });

  factory FocusSessionModel.fromJson(Map<String, dynamic> json) {
    return FocusSessionModel(
      sessionId: json["session_id"] ?? "",
      planId: json["plan_id"] ?? "",
      userId: json["user_id"] ?? "",
      cycle: json["cycle"] ?? 0,
      type: json["type"] ?? "focus",
      duration: json["duration"] ?? 0,
      completed: json["completed"] ?? false,
    );
  }
}
