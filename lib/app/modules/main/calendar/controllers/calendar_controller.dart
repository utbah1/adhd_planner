import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/user_controller.dart';
import '../../../../data/models/task/task_model.dart';
import '../../../../data/services/profile_service.dart';
import '../../../../data/services/task_service.dart';

class CalendarController extends GetxController {

  final UserController _userController = Get.find<UserController>();

  final RxBool isLoading = true.obs;
  final RxString errorMessage = "".obs;

  final RxList<TaskModel> allTasks = <TaskModel>[].obs;

  final Rx<DateTime> selectedDate =
      Rx<DateTime>(_dateOnly(DateTime.now()));

  final Rx<DateTime> weekStart =
      Rx<DateTime>(_startOfWeek(DateTime.now()));

  @override
  void onInit() {
    super.onInit();
    _loadUserIfNeeded();
    fetchTasks();
  }

  Future<void> _loadUserIfNeeded() async {
    if (_userController.hasUser) return;
    try {
      final user = await ProfileService.getProfile();
      _userController.setUser(user);
    } catch (_) {}
  }

  static DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static DateTime _startOfWeek(DateTime date) {
    final normalized = _dateOnly(date);
    final offset = normalized.weekday % 7; // Sunday -> 0
    return normalized.subtract(Duration(days: offset));
  }

  Future<void> fetchTasks() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      final tasks = await TaskService.getTasks();
      allTasks.value = tasks;
    } catch (e) {
      errorMessage.value =
          e.toString().replaceFirst("Exception: ", "");
    } finally {
      isLoading.value = false;
    }
  }

  
  Future<void> refresh() => fetchTasks();

  List<DateTime> get weekDates => List.generate(
        7,
        (i) => weekStart.value.add(Duration(days: i)),
      );

  void selectDate(DateTime date) {
    selectedDate.value = _dateOnly(date);
  }

  void jumpToDate(DateTime date) {
    final normalized = _dateOnly(date);
    weekStart.value = _startOfWeek(normalized);
    selectedDate.value = normalized;
  }

  void goToPreviousWeek() {
    weekStart.value =
        weekStart.value.subtract(const Duration(days: 7));
  }

  void goToNextWeek() {
    weekStart.value = weekStart.value.add(const Duration(days: 7));
  }

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;
  }

  bool get isSelectedToday =>
      isSameDate(selectedDate.value, DateTime.now());

  String _dateKey(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final dd = d.day.toString().padLeft(2, '0');
    return "$y-$m-$dd";
  }

  List<TaskModel> get tasksForSelectedDate {
    final key = _dateKey(selectedDate.value);

    final list =
        allTasks.where((t) => t.dueDate == key).toList();

    list.sort((a, b) {
      final at = a.startTime ?? "23:59";
      final bt = b.startTime ?? "23:59";
      return at.compareTo(bt);
    });

    return list;
  }

  TaskModel? get highlightedTask {
    if (!isSelectedToday) return null;

    final candidates = tasksForSelectedDate
        .where((t) => !t.isCompleted && t.startTime != null)
        .toList();

    if (candidates.isEmpty) return null;

    final now = TimeOfDay.now();
    final nowMinutes = now.hour * 60 + now.minute;

    TaskModel? next;

    for (final t in candidates) {
      final parts = t.startTime!.split(":");
      final startMinutes =
          int.parse(parts[0]) * 60 + int.parse(parts[1]);
      final endMinutes =
          startMinutes + (t.durationMinutes ?? 60);

      if (nowMinutes >= startMinutes && nowMinutes < endMinutes) {
        return t;
      }

      if (startMinutes > nowMinutes && next == null) {
        next = t;
      }
    }

    return next;
  }

  List<TaskModel> get otherTasks {
    final highlighted = highlightedTask;
    if (highlighted == null) return tasksForSelectedDate;

    return tasksForSelectedDate
        .where((t) => t.id != highlighted.id)
        .toList();
  }
}