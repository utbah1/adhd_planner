class EndpointConstants {
  EndpointConstants._();

  /// Authentication
  static const login = "/auth/login";
  static const register = "/auth/register";
  static const verifyOtp = "/auth/verify-otp";
  static const resendOtp = "/auth/resend-otp";
  static const String googleLogin = "/auth/google-login";

  /// Task
  static const tasks = "/tasks";

  /// Focus
  static const focusPlans = "/focus/plans";
  static const focusSessions = "/focus/sessions";
  static const focusHistory = "/focus/history";

  /// Analytics
  static const dashboard = "/analytics/dashboard";
  static const weekly = "/analytics/weekly";

  /// Profile
  static const profile = "/profile";
  static const uploadPhoto = "/profile/upload-photo";
  static const changePassword = "/profile/change-password";
}
