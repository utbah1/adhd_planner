class FocusPlanCreateResult {
  final String planId;
  final int totalCycles;
  final String message;

  FocusPlanCreateResult({
    required this.planId,
    required this.totalCycles,
    required this.message,
  });

  factory FocusPlanCreateResult.fromJson(Map<String, dynamic> json) {
    return FocusPlanCreateResult(
      planId: json["plan_id"] ?? "",
      totalCycles: json["total_cycles"] ?? 0,
      message: json["message"] ?? "",
    );
  }
}
