import 'package:get/get.dart';

import '../../../core/storage/onboarding_storage.dart';
import '../../../core/storage/token_storage.dart';
import '../../../data/services/profile_service.dart';
import '../../../routes/app_pages.dart';
import '../../../controller/user_controller.dart';

class SplashController extends GetxController {
  final UserController userController =
      Get.find<UserController>();

  @override
  void onReady() {
    super.onReady();

    checkLogin();
  }

Future<void> checkLogin() async {
  print('=== SPLASH: checkLogin started ===');
  
  final onboarding = await OnboardingStorage.isCompleted();
  print('=== SPLASH: onboarding=$onboarding ===');

  if (!onboarding) {
    Get.offAllNamed(Routes.ONBOARDING);
    return;
  }

  final token = await TokenStorage.getToken();
  print('=== SPLASH: token=$token ===');

  if (token == null) {
    Get.offAllNamed(Routes.LOGIN);
    return;
  }

  try {
    print('=== SPLASH: calling getProfile... ===');
    final user = await ProfileService.getProfile();
    print('=== SPLASH: profile success ===');
    userController.setUser(user);
    Get.offAllNamed(Routes.DASHBOARD);
  } catch (e) {
    print('=== SPLASH: error=$e ===');
    await TokenStorage.clearToken();
    userController.clearUser();
    Get.offAllNamed(Routes.LOGIN);
  }
}
}