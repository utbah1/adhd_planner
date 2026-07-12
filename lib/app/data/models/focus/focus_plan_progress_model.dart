class FocusPlanProgressModel {
  final int completedCycles;
  final int totalCycles;
  final double progress;
  final String status;

  FocusPlanProgressModel({
    required this.completedCycles,
    required this.totalCycles,
    required this.progress,
    required this.status,
  });

  factory FocusPlanProgressModel.fromJson(Map<String, dynamic> json) {
    return FocusPlanProgressModel(
      completedCycles: json["completed_cycles"] ?? 0,
      totalCycles: json["total_cycles"] ?? 0,
      progress: (json["progress"] ?? 0).toDouble(),
      status: json["status"] ?? "active",
    );
  }
}
