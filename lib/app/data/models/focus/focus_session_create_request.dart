class FocusSessionCreateRequest {
  final int cycle;
  final String type; 
  final int duration;

  FocusSessionCreateRequest({
    required this.cycle,
    required this.type,
    required this.duration,
  });

  Map<String, dynamic> toJson() {
    return {
      "cycle": cycle,
      "type": type,
      "duration": duration,
    };
  }
}
