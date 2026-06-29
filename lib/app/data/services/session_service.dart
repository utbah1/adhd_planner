import '../../core/storage/preference_storage.dart';
import '../../core/storage/token_storage.dart';

class SessionService {
  SessionService._();

  static const String _firstLaunchKey =
      "first_launch";

  static Future<bool> isLoggedIn() async {
    final token =
        await TokenStorage.getToken();

    return token != null &&
        token.isNotEmpty;
  }

  static Future<bool> isFirstLaunch() async {
    return !(await PreferenceStorage.getBool(
      _firstLaunchKey,
    ));
  }

  static Future<void> finishOnboarding() async {
    await PreferenceStorage.saveBool(
      _firstLaunchKey,
      true,
    );
  }

  static Future<void> logout() async {
    await TokenStorage.clearToken();
  }
}