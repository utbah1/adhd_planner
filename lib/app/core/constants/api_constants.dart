class ApiConstants {
  ApiConstants._();

  static const String baseUrl =
      "http://192.168.1.10:8000";

  static const String login =
      "/auth/login";

  static const String register =
      "/auth/register";

  static const String verifyOtp =
      "/auth/verify-otp";

  static const String resendOtp =
      "/auth/resend-otp";

  static const String tasks =
      "/tasks";

  static const String focusPlans =
      "/focus/plans";

  static const String focusSessions =
      "/focus/sessions";

  static const String dashboard =
      "/analytics/dashboard";

  static const String weekly =
      "/analytics/weekly";

  static const String profile =
      "/profile";
}

  
  /// Base URL

  /// Production
  // static const String baseUrl =
  //   "https://api.yourdomain.com";

  /// Android Emulator
  // static const String baseUrl =
  //  "http://10.0.2.2:8000";

  /// Android Real Device
  ///  static const String baseUrl =
  ///   "http:// IPv4 Address:8000";