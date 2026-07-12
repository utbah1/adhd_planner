class TaskCreateRequest {
  final String title;
  final String? description;
  final String priority;
  final String dueDate;
  final String? startTime;
  final int? durationMinutes;

  TaskCreateRequest({
    required this.title,
    this.description,
    required this.priority,
    required this.dueDate,
    this.startTime,
    this.durationMinutes,
  });

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "priority": priority,
    "due_date": dueDate,
    "start_time": startTime,
    "duration_minutes": durationMinutes,
  };
}