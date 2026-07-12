import 'package:get/get.dart';

import '../../../../controller/user_controller.dart';
import '../../../../data/services/profile_service.dart';

class AnalyticsController extends GetxController {
  //TODO: Implement AnalyticsController

  final UserController _userController = Get.find<UserController>();

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserIfNeeded();
  }
  
  Future<void> _loadUserIfNeeded() async {
    if (_userController.hasUser) return;
    try {
      final user = await ProfileService.getProfile();
      _userController.setUser(user);
    } catch (_) {}
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
