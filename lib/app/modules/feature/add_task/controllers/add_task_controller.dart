import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/task/task_create_request.dart';
import '../../../../data/services/task_service.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/widgets2/custom_snackbar.dart';
import '../../../main/calendar/controllers/calendar_controller.dart';

class AddTaskController extends GetxController {

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final RxString priority = "Medium".obs;
  final Rxn<DateTime> dueDate = Rxn<DateTime>();
  final Rxn<TimeOfDay> startTime = Rxn<TimeOfDay>();
  final Rxn<int> durationMinutes = Rxn<int>();

  final RxBool isSubmitting = false.obs;

  static const priorities = [
    "Low",
    "Medium",
    "High"
  ];
  static const durations = [
    15,
    30,
    45,
    60,
    90,
    120
  ];

  void setPriority(String value) =>
      priority.value = value;

  void setDueDate(DateTime value) =>
      dueDate.value = value;

  void setStartTime(TimeOfDay value) =>
      startTime.value = value;

  void setDurationMinutes(int value) =>
      durationMinutes.value = value;

  void clearDurationMinutes() =>
      durationMinutes.value = null;

  String get formattedDueDate {
    final date = dueDate.value;
    if (date == null) return "";

    final month =
        date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return "${date.year}-$month-$day";
  }

  String get formattedStartTime {
    final time = startTime.value;
    if (time == null) return "";

    final hour =
        time.hour.toString().padLeft(2, '0');
    final minute =
        time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  String get displayTimeRange {
    if (startTime.value == null) return "";

    final startHour = startTime.value!.hour
        .toString()
        .padLeft(2, '0');
    final startMinute = startTime.value!.minute
        .toString()
        .padLeft(2, '0');
    final timeStr = "$startHour:$startMinute";

    if (durationMinutes.value == null) {
      return timeStr;
    }

    final endTime = _calculateEndTime(
      startTime.value!,
      durationMinutes.value!,
    );
    final endHour =
        endTime.hour.toString().padLeft(2, '0');
    final endMinute =
        endTime.minute.toString().padLeft(2, '0');

    return "$timeStr - $endHour:$endMinute";
  }

  TimeOfDay _calculateEndTime(
    TimeOfDay start,
    int durationMin,
  ) {
    final totalMinutes = start.hour * 60 +
        start.minute +
        durationMin;
    final endHour = (totalMinutes ~/ 60) % 24;
    final endMinute = totalMinutes % 60;

    return TimeOfDay(
      hour: endHour,
      minute: endMinute,
    );
  }

  /// Returns true on success so the caller can pop / refresh.
  Future<bool> submit() async {
    final title = titleController.text.trim();

    if (title.isEmpty) {
      CustomSnackbar.error(
        title: "Judul kosong",
        message: "Tulis judul task dulu ya.",
      );
      return false;
    }

    if (dueDate.value == null) {
      CustomSnackbar.error(
        title: "Tanggal belum dipilih",
        message:
            "Pilih tanggal deadline untuk task ini.",
      );
      return false;
    }

    if (startTime.value == null) {
      CustomSnackbar.error(
        title: "Jam mulai belum dipilih",
        message: "Pilih jam berapa task ini dimulai.",
      );
      return false;
    }

    try {
      isSubmitting.value = true;

      final description =
          descriptionController.text.trim();

      /// Create task dan dapatkan task_id
      final taskId =
          await TaskService.createTask(
        TaskCreateRequest(
          title: title,
          description: description.isEmpty
              ? null
              : description,
          priority: priority.value,
          dueDate: formattedDueDate,
          startTime: formattedStartTime,
          durationMinutes: durationMinutes.value,
        ),
      );

      CustomSnackbar.success(
        title: "Task dibuat",
        message:
            "\"$title\" berhasil ditambahkan.",
      );

      _resetForm();

      // Refresh CalendarController kalau masih ada di memory
      // (user bisa datang dari calendar maupun dashboard)
      if (Get.isRegistered<CalendarController>()) {
        Get.find<CalendarController>().fetchTasks();
      }

      /// Navigate ke task detail, hapus halaman add_task dari stack
      /// agar tombol back di task_detail langsung kembali ke calendar/dashboard
      Get.offNamed(
        Routes.TASK_DETAIL,
        arguments: taskId,
      );

      return true;
    } catch (e) {
      CustomSnackbar.error(
        title: "Gagal membuat task",
        message: e
            .toString()
            .replaceFirst("Exception: ", ""),
      );
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  void _resetForm() {
    titleController.clear();
    descriptionController.clear();
    priority.value = "Medium";
    dueDate.value = null;
    startTime.value = null;
    durationMinutes.value = null;
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}