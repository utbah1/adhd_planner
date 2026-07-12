class TaskUpdateRequest {
  final String? title;
  final String? description;
  final String? priority;
  final String? status;
  final String? dueDate;
  final String? startTime;
  final int? durationMinutes;

  TaskUpdateRequest({
    this.title,
    this.description,
    this.priority,
    this.status,
    this.dueDate,
    this.startTime,
    this.durationMinutes,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (title != null) map["title"] = title;
    if (description != null)
      map["description"] = description;
    if (priority != null) map["priority"] = priority;
    if (status != null) map["status"] = status;
    if (dueDate != null) map["due_date"] = dueDate;
    if (startTime != null) map["start_time"] = startTime;
    if (durationMinutes != null)
      map["duration_minutes"] = durationMinutes;

    return map;
  }
}