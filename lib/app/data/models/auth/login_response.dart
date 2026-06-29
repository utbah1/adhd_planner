class LoginResponse {

  final String uid;
  final String accessToken;

  LoginResponse({

    required this.uid,

    required this.accessToken,

  });

  factory LoginResponse.fromJson(
      Map<String, dynamic> json) {

    return LoginResponse(

      uid: json["uid"],

      accessToken: json["access_token"],

    );

  }

}