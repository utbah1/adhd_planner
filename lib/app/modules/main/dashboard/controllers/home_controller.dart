import 'dart:async';

import 'package:get/get.dart';

import '../../../../controller/user_controller.dart';
import '../../../../data/models/analytics/analytics_dashboard_model.dart';
import '../../../../data/models/analytics/weekly_analytics_model.dart';
import '../../../../data/models/task/task_model.dart';
import '../../../../data/services/analytics_service.dart';
import '../../../../data/services/profile_service.dart';
import '../../../../data/services/task_service.dart';

class HomeController extends GetxController {

  final UserController _userController = Get.find<UserController>();

  final RxBool isLoading = true.obs;
  final RxString errorMessage = "".obs;

  final Rxn<AnalyticsDashboardModel> dashboard =
      Rxn<AnalyticsDashboardModel>();

  final Rxn<WeeklyAnalyticsModel> weekly =
      Rxn<WeeklyAnalyticsModel>();

  // ── Today's tasks ─────────────────────────────────────────────
  final RxList<TaskModel> todayTasks = <TaskModel>[].obs;

  /// Reactive "now" — diupdate tiap 30 detik agar UI countdown auto-refresh.
  final Rx<DateTime> _now = Rx<DateTime>(DateTime.now());
  Timer? _clockTimer;

  @override
  void onInit() {
    super.onInit();
    _loadUserIfNeeded();
    fetchDashboard();
    _startClock();
  }

  @override
  void onClose() {
    _clockTimer?.cancel();
    super.onClose();
  }

  void _startClock() {
    _clockTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _now.value = DateTime.now();
    });
  }

  Future<void> _loadUserIfNeeded() async {
    if (_userController.hasUser) return;
    try {
      final user = await ProfileService.getProfile();
      _userController.setUser(user);
    } catch (_) {}
  }

  Future<void> fetchDashboard() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      final results = await Future.wait([
        AnalyticsService.getDashboardForToday(),
        AnalyticsService.getWeekly(),
        TaskService.getTasks(),
      ]);

      dashboard.value = results[0] as AnalyticsDashboardModel;
      weekly.value    = results[1] as WeeklyAnalyticsModel;

      final allTasks = results[2] as List<TaskModel>;
      final todayKey = _dateKey(DateTime.now());
      final list = allTasks
          .where((t) => t.dueDate == todayKey)
          .toList();

      list.sort((a, b) {
        final at = a.startTime ?? "23:59";
        final bt = b.startTime ?? "23:59";
        return at.compareTo(bt);
      });

      todayTasks.value = list;
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst("Exception: ", "");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refresh() => fetchDashboard();

  // ── Helpers ───────────────────────────────────────────────────

  String _dateKey(DateTime d) {
    final y  = d.year.toString().padLeft(4, '0');
    final m  = d.month.toString().padLeft(2, '0');
    final dd = d.day.toString().padLeft(2, '0');
    return "$y-$m-$dd";
  }

  int _taskStartMinutes(TaskModel t) {
    if (t.startTime == null) return 24 * 60;
    final parts = t.startTime!.split(":");
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  /// Task yang sedang berlangsung ATAU task berikutnya hari ini.
  ///
  /// Aturan prioritas:
  /// 1. Task sedang berlangsung = startTime <= now < endTime.
  ///    endTime hanya dihitung kalau [durationMinutes] eksplisit (> 0).
  ///    Task tanpa durasi → dianggap selesai begitu startTime terlewat.
  /// 2. Task pertama yang startTime > now (belum mulai).
  /// 3. Semua sudah lewat → null.
  ///
  /// Membaca _now.value agar Obx di view rebuild otomatis setiap timer tick.
  TaskModel? get highlightedTask {
    final nowMins = _now.value.hour * 60 + _now.value.minute;

    final candidates = todayTasks
        .where((t) => !t.isCompleted && t.startTime != null)
        .toList();

    if (candidates.isEmpty) return null;

    // Prioritas 1: sedang berlangsung (hanya kalau durasi eksplisit).
    for (final t in candidates) {
      final dur = t.durationMinutes;
      if (dur == null || dur <= 0) continue;

      final startMins = _taskStartMinutes(t);
      final endMins   = startMins + dur;

      if (nowMins >= startMins && nowMins < endMins) {
        return t;
      }
    }

    // Prioritas 2: task pertama yang belum mulai.
    for (final t in candidates) {
      if (_taskStartMinutes(t) > nowMins) return t;
    }

    // Semua sudah lewat.
    return null;
  }

  /// Semua task hari ini kecuali yang di-highlight.
  List<TaskModel> get otherTasks {
    final h = highlightedTask;
    if (h == null) return List.from(todayTasks);
    return todayTasks.where((t) => t.id != h.id).toList();
  }

  /// Teks countdown untuk ActiveTimelineCard.
  ///
  /// Case A — task sedang berlangsung (durasi eksplisit):
  ///   → sisa waktu hingga selesai, misal "45M left" / "1H 5M left"
  ///
  /// Case B — task belum mulai (highlighted sebagai "next"):
  ///   → waktu hingga mulai, misal "3M" / "1H 10M"
  ///
  /// Membaca _now.value agar Obx track dependency ini.
  String countdownFor(TaskModel task) {
    final nowMins   = _now.value.hour * 60 + _now.value.minute;
    final startMins = _taskStartMinutes(task);
    final dur       = task.durationMinutes;

    // Case A: sedang berlangsung (durasi eksplisit).
    if (dur != null && dur > 0) {
      final endMins = startMins + dur;
      if (nowMins >= startMins && nowMins < endMins) {
        final remaining = endMins - nowMins;
        if (remaining <= 0) return "NOW";
        if (remaining < 60) return "${remaining}M left";
        final h = remaining ~/ 60;
        final m = remaining % 60;
        return m == 0 ? "${h}H left" : "${h}H ${m}M left";
      }
    }

    // Case B: belum mulai → hitung waktu sampai startTime.
    final diff = startMins - nowMins;
    if (diff <= 0) return "NOW";
    if (diff < 60) return "${diff}M";
    final h = diff ~/ 60;
    final m = diff % 60;
    return m == 0 ? "${h}H" : "${h}H ${m}M";
  }
}
