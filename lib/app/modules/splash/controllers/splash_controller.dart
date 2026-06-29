import 'package:get/get.dart';

import '../../../data/services/session_service.dart';
import '../../../routes/app_pages.dart';

class SplashController
    extends GetxController {

  @override
  void onInit() {
    super.onInit();

    checkSession();
  }

  Future<void> checkSession() async {

    await Future.delayed(
      const Duration(seconds: 2),
    );

    final loggedIn =
        await SessionService.isLoggedIn();

    if (loggedIn) {

      Get.offAllNamed(
        Routes.DASHBOARD,
      );

      return;
    }

    final firstLaunch =
        await SessionService.isFirstLaunch();

    if (firstLaunch) {

      Get.offAllNamed(
        Routes.ONBOARDING,
      );

      return;
    }

    Get.offAllNamed(
      Routes.LOGIN,
    );
  }
}