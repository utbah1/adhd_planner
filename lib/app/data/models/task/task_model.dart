class TaskModel {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final String priority;
  final String status;
  final String dueDate;
  final String? startTime;
  final int? durationMinutes;
  final DateTime createdAt;
  final DateTime updatedAt;

  TaskModel({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    required this.priority,
    required this.status,
    required this.dueDate,
    this.startTime,
    this.durationMinutes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TaskModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TaskModel(
      id: json["id"] ?? "",
      userId: json["user_id"] ?? "",
      title: json["title"] ?? "",
      description: json["description"],
      priority: json["priority"] ?? "Medium",
      status: json["status"] ?? "Pending",
      dueDate: json["due_date"] ?? "",
      startTime: json["start_time"],
      durationMinutes: json["duration_minutes"],
      createdAt: json["created_at"] != null
          ? DateTime.parse(json["created_at"])
          : DateTime.now(),
      updatedAt: json["updated_at"] != null
          ? DateTime.parse(json["updated_at"])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "description": description,
    "priority": priority,
    "status": status,
    "due_date": dueDate,
    "start_time": startTime,
    "duration_minutes": durationMinutes,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

  /// Display time range (e.g., "11:00" atau "11:00-12:00")
  String get displayTime {
    if (startTime == null) return "";

    if (durationMinutes == null) {
      return startTime!;
    }

    try {
      final parts = startTime!.split(":");
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      final endMinutes =
          hour * 60 + minute + durationMinutes!;
      final endHour = (endMinutes ~/ 60) % 24;
      final endMinute = endMinutes % 60;

      final endHourStr =
          endHour.toString().padLeft(2, '0');
      final endMinStr =
          endMinute.toString().padLeft(2, '0');

      return "$startTime - $endHourStr:$endMinStr";
    } catch (_) {
      return startTime ?? "";
    }
  }

  /// Convenience: is this task completed?
  bool get isCompleted => status == "Completed";

  /// Convenience: is this task overdue?
  bool get isOverdue {
    if (isCompleted) return false;

    try {
      final parts = dueDate.split("-");
      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final day = int.parse(parts[2]);

      final dueDateTime =
          DateTime(year, month, day, 23, 59);
      return DateTime.now().isAfter(dueDateTime);
    } catch (_) {
      return false;
    }
  }
}