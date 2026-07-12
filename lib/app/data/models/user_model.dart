class UserModel {
  final String uid;
  final String fullname;
  final String email;
  final String photoUrl;
  final int streak;
  final int productivityScore;
  final int focusTime;
  final int tasksDone;

  const UserModel({
    required this.uid,
    required this.fullname,
    required this.email,
    required this.photoUrl,
    required this.streak,
    required this.productivityScore,
    required this.focusTime,
    required this.tasksDone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"] ?? "",
      fullname: json["fullname"] ?? "",
      email: json["email"] ?? "",
      photoUrl: json["photo_url"] ?? "",
      streak: json["streak"] ?? 0,
      productivityScore: json["productivity_score"] ?? 0,
      focusTime: json["focus_time"] ?? 0,
      tasksDone: json["tasks_done"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "fullname": fullname,
      "email": email,
      "photo_url": photoUrl,
      "streak": streak,
      "productivity_score": productivityScore,
      "focus_time": focusTime,
      "tasks_done": tasksDone,
    };
  }

  UserModel copyWith({
    String? uid,
    String? fullname,
    String? email,
    String? photoUrl,
    int? streak,
    int? productivityScore,
    int? focusTime,
    int? tasksDone,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      streak: streak ?? this.streak,
      productivityScore:
          productivityScore ?? this.productivityScore,
      focusTime: focusTime ?? this.focusTime,
      tasksDone: tasksDone ?? this.tasksDone,
    );
  }
}