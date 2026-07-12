import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/task/task_model.dart';
import '../../../../data/models/task/task_update_request.dart';
import '../../../../data/services/task_service.dart';
import '../../../../shared/widgets2/custom_snackbar.dart';

class TaskDetailController extends GetxController {
  String taskId = "";

  final Rxn<TaskModel> task = Rxn<TaskModel>();
  final RxBool isLoading = false.obs;
  final RxBool isUpdating = false.obs;

  /// Edit mode
  final RxBool isEditMode = false.obs;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final RxString editPriority = "Medium".obs;

  static const priorities = ["Low", "Medium", "High"];

  @override
  void onInit() {
    super.onInit();
    taskId = Get.arguments?.toString() ?? "";

    titleController = TextEditingController();
    descriptionController = TextEditingController();

    if (taskId.isNotEmpty) {
      loadTask();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CustomSnackbar.error(
          title: "Error",
          message: "Task ID tidak valid",
        );
        Get.back();
      });
    }
  }

  Future<void> loadTask() async {
    try {
      isLoading.value = true;

      final taskData =
          await TaskService.getTask(taskId);

      task.value = taskData;

      /// Initialize edit controllers
      titleController.text = taskData.title;
      descriptionController.text =
          taskData.description ?? "";
      editPriority.value = taskData.priority;
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CustomSnackbar.error(
          title: "Gagal memuat task",
          message: e
              .toString()
              .replaceFirst("Exception: ", ""),
        );
        Get.back();
      });
    } finally {
      isLoading.value = false;
    }
  }

  void toggleEditMode() {
    if (isEditMode.value) {
      /// Cancel edit
      isEditMode.value = false;
      titleController.text = task.value?.title ?? "";
      descriptionController.text =
          task.value?.description ?? "";
      editPriority.value =
          task.value?.priority ?? "Medium";
    } else {
      /// Enter edit mode
      isEditMode.value = true;
    }
  }

  Future<void> saveChanges() async {
    final title = titleController.text.trim();

    if (title.isEmpty) {
      CustomSnackbar.error(
        title: "Judul kosong",
        message: "Tulis judul task dulu ya.",
      );
      return;
    }

    try {
      isUpdating.value = true;

      final description =
          descriptionController.text.trim();

      await TaskService.updateTask(
        taskId,
        TaskUpdateRequest(
          title: title,
          description: description.isEmpty
              ? null
              : description,
          priority: editPriority.value,
        ),
      );

      /// Update local task
      if (task.value != null) {
        task.value = TaskModel(
          id: task.value!.id,
          userId: task.value!.userId,
          title: title,
          description: description.isEmpty
              ? null
              : description,
          priority: editPriority.value,
          status: task.value!.status,
          dueDate: task.value!.dueDate,
          startTime: task.value!.startTime,
          durationMinutes:
              task.value!.durationMinutes,
          createdAt: task.value!.createdAt,
          updatedAt: DateTime.now(),
        );
      }

      isEditMode.value = false;

      CustomSnackbar.success(
        title: "Task diperbarui",
        message: "Perubahan berhasil disimpan.",
      );
    } catch (e) {
      CustomSnackbar.error(
        title: "Gagal memperbarui task",
        message: e
            .toString()
            .replaceFirst("Exception: ", ""),
      );
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> toggleTaskStatus() async {
    if (task.value == null) return;

    try {
      isUpdating.value = true;

      final newStatus = task.value!.isCompleted
          ? "Pending"
          : "Completed";

      await TaskService.updateTask(
        taskId,
        TaskUpdateRequest(status: newStatus),
      );

      /// Update local task
      task.value = TaskModel(
        id: task.value!.id,
        userId: task.value!.userId,
        title: task.value!.title,
        description: task.value!.description,
        priority: task.value!.priority,
        status: newStatus,
        dueDate: task.value!.dueDate,
        startTime: task.value!.startTime,
        durationMinutes:
            task.value!.durationMinutes,
        createdAt: task.value!.createdAt,
        updatedAt: DateTime.now(),
      );

      CustomSnackbar.success(
        title: newStatus == "Completed"
            ? "Task selesai! 🎉"
            : "Task dibuka kembali",
        message: "",
      );
    } catch (e) {
      CustomSnackbar.error(
        title: "Gagal mengubah status",
        message: e
            .toString()
            .replaceFirst("Exception: ", ""),
      );
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> deleteTask() async {
    /// Show confirmation dialog
    Get.dialog(
      AlertDialog(
        title: const Text("Hapus Task?"),
        content: const Text(
          "Aksi ini tidak bisa dibatalkan.",
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              await _performDelete();
            },
            child: const Text(
              "Hapus",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _performDelete() async {
    try {
      isUpdating.value = true;

      await TaskService.deleteTask(taskId);

      CustomSnackbar.success(
        title: "Task dihapus",
        message: "Task berhasil dihapus.",
      );

      Get.offAllNamed('/calendar');
    } catch (e) {
      CustomSnackbar.error(
        title: "Gagal menghapus task",
        message: e
            .toString()
            .replaceFirst("Exception: ", ""),
      );
    } finally {
      isUpdating.value = false;
    }
  }

  void setPriority(String value) =>
      editPriority.value = value;

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}