class RegisterRequest {

  final String fullname;
  final String email;
  final String password;

  RegisterRequest({

    required this.fullname,

    required this.email,

    required this.password,

  });

  Map<String, dynamic> toJson() {

    return {

      "fullname": fullname,

      "email": email,

      "password": password,

    };

  }

}