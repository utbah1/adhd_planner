class LoginResponse {
  final String uid;
  final String fullname;
  final String email;
  final String photoUrl;
  final int streak;
  final int productivityScore;
  final String accessToken;

  LoginResponse({
    required this.uid,
    required this.fullname,
    required this.email,
    required this.photoUrl,
    required this.streak,
    required this.productivityScore,
    required this.accessToken,
  });

  factory LoginResponse.fromJson(
      Map<String, dynamic> json) {
    return LoginResponse(
      uid: json["uid"],
      fullname: json["fullname"],
      email: json["email"],
      photoUrl: json["photo_url"] ?? "",
      streak: json["streak"] ?? 0,
      productivityScore:
          json["productivity_score"] ?? 0,
      accessToken: json["access_token"],
    );
  }
}