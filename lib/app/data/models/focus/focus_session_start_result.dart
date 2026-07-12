class FocusSessionStartResult {
  final String sessionId;
  final String message;

  FocusSessionStartResult({
    required this.sessionId,
    required this.message,
  });

  factory FocusSessionStartResult.fromJson(Map<String, dynamic> json) {
    return FocusSessionStartResult(
      sessionId: json["session_id"] ?? "",
      message: json["message"] ?? "",
    );
  }
}
