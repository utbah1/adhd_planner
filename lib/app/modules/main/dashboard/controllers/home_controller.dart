import 'package:get/get.dart';

import '../../../../controller/user_controller.dart';
import '../../../../data/models/analytics/analytics_dashboard_model.dart';
import '../../../../data/models/analytics/weekly_analytics_model.dart';
import '../../../../data/services/analytics_service.dart';
import '../../../../data/services/profile_service.dart';

class HomeController extends GetxController {

  final UserController _userController = Get.find<UserController>();

  final RxBool isLoading = true.obs;
  final RxString errorMessage = "".obs;

  final Rxn<AnalyticsDashboardModel> dashboard =
      Rxn<AnalyticsDashboardModel>();

  final Rxn<WeeklyAnalyticsModel> weekly =
      Rxn<WeeklyAnalyticsModel>();

  @override
  void onInit() {
    super.onInit();
    _loadUserIfNeeded();
    fetchDashboard();
  }

  // Jika UserController belum punya data (misalnya session lama atau
  // Google login yang belum set user), fetch profile dari backend
  // agar topbar langsung menampilkan nama yang benar tanpa harus
  // buka halaman Profile terlebih dahulu.
  Future<void> _loadUserIfNeeded() async {
    if (_userController.hasUser) return;
    try {
      final user = await ProfileService.getProfile();
      _userController.setUser(user);
    } catch (_) {
      // Biarkan topbar tetap "Guest" jika gagal — tidak perlu crash
    }
  }

  Future<void> fetchDashboard() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      // Run both calls together instead of awaiting one after another.
      final results = await Future.wait([
        AnalyticsService.getDashboard(),
        AnalyticsService.getWeekly(),
      ]);

      dashboard.value = results[0] as AnalyticsDashboardModel;
      weekly.value = results[1] as WeeklyAnalyticsModel;
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst("Exception: ", "");
    } finally {
      isLoading.value = false;
    }
  }

  /// Pull-to-refresh entry point.
  Future<void> refresh() => fetchDashboard();
}