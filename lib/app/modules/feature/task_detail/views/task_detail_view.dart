import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../data/models/task/task_model.dart';
import '../../../../shared/widgets2/custom_topbar_feature.dart';
import '../controllers/task_detail_controller.dart';

class TaskDetailView extends StatelessWidget {
  const TaskDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.find<TaskDetailController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F4FA),
      appBar: const CustomTopbarFeature(
        title: "Task Detail",
        rightIcon: Iconsax.more,
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final task = controller.task.value;
          if (task == null) {
            return const Center(
              child: Text("Task tidak ditemukan"),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  /// STATUS CARD
                  _buildStatusCard(
                    task: task,
                    controller: controller,
                  ),

                  const SizedBox(height: 24),

                  /// EDIT MODE / VIEW MODE
                  if (!controller.isEditMode.value)
                    _buildViewMode(
                      task: task,
                      controller: controller,
                    )
                  else
                    _buildEditMode(
                      task: task,
                      controller: controller,
                    ),

                  const SizedBox(height: 24),

                  /// TASK INFO CARD
                  _buildTaskInfoCard(task: task),

                  const SizedBox(height: 24),

                  /// ACTION BUTTONS
                  _buildActionButtons(
                    controller: controller,
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusCard({
    required TaskModel task,
    required TaskDetailController controller,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: task.isCompleted
            ? Colors.green[100]
            : Colors.orange[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: task.isCompleted
              ? Colors.green[300]!
              : Colors.orange[300]!,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                task.isCompleted
                    ? "✅ Completed"
                    : "⏳ Pending",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: task.isCompleted
                      ? Colors.green[800]
                      : Colors.orange[800],
                ),
              ),
              if (task.isOverdue && !task.isCompleted)
                Padding(
                  padding:
                      const EdgeInsets.only(top: 4),
                  child: Text(
                    "⚠️ Overdue",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red[700],
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          Obx(
            () => ElevatedButton.icon(
              onPressed: controller.isUpdating.value
                  ? null
                  : () {
                      controller
                          .toggleTaskStatus();
                    },
              icon: Icon(
                task.isCompleted
                    ? Icons.undo
                    : Icons.check_circle,
              ),
              label: Text(
                task.isCompleted ? "Reopen" : "Done",
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    task.isCompleted
                        ? Colors.orange[400]
                        : Colors.green[400],
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewMode({
    required TaskModel task,
    required TaskDetailController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TITLE
        Text(
          task.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 12),

        /// PRIORITY BADGE
        Container(
          decoration: BoxDecoration(
            color: _priorityColor(task.priority),
            borderRadius:
                BorderRadius.circular(20),
          ),
          padding:
              const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          child: Text(
            task.priority,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(height: 16),

        /// DESCRIPTION
        if (task.description != null &&
            task.description!.isNotEmpty)
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                task.description!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),

        /// EDIT BUTTON
        SizedBox(
          width: double.infinity,
          child: Obx(
            () => ElevatedButton.icon(
              onPressed: controller.isUpdating.value
                  ? null
                  : () {
                      controller
                          .toggleEditMode();
                    },
              icon: const Icon(Iconsax.edit_2),
              label: const Text("Edit Task"),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.deepPurple[400],
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditMode({
    required TaskModel task,
    required TaskDetailController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Editing Task",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 16),

        /// TITLE FIELD
        _buildTextField(
          label: "Title",
          controller: controller.titleController,
        ),

        const SizedBox(height: 12),

        /// DESCRIPTION FIELD
        _buildTextField(
          label: "Description",
          controller:
              controller.descriptionController,
          maxLines: 3,
        ),

        const SizedBox(height: 12),

        /// PRIORITY DROPDOWN
        Obx(
          () => _buildDropdown(
            label: "Priority",
            value: controller.editPriority.value,
            items:
                TaskDetailController.priorities,
            onChanged: (val) {
              if (val != null) {
                controller.setPriority(val);
              }
            },
          ),
        ),

        const SizedBox(height: 20),

        /// ACTION BUTTONS
        Row(
          children: [
            Expanded(
              child: Obx(
                () => OutlinedButton(
                  onPressed: controller.isUpdating.value
                      ? null
                      : () {
                          controller.toggleEditMode();
                        },
                  child: const Text("Cancel"),
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Obx(
                () => ElevatedButton(
                  onPressed: controller.isUpdating.value
                      ? null
                      : () {
                          controller.saveChanges();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: controller.isUpdating.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text("Save"),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildTaskInfoCard({
    required TaskModel task,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[200]!,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            "Task Info",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            label: "Due Date",
            value: task.dueDate,
            icon: Iconsax.calendar,
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            label: "Time",
            value: task.displayTime,
            icon: Iconsax.clock,
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            label: "Created",
            value:
                "${task.createdAt.day}/${task.createdAt.month}/${task.createdAt.year}",
            icon: Iconsax.calendar_add,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons({
    required TaskDetailController controller,
  }) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
            },
            icon: const Icon(Iconsax.timer_1),
            label: const Text("Start Focus Session"),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.deepPurple[400],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                vertical: 12,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: Obx(
            () => OutlinedButton.icon(
              onPressed: controller.isUpdating.value
                  ? null
                  : () {
                      controller.deleteTask();
                    },
              icon: const Icon(Iconsax.trash),
              label: const Text("Delete Task"),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          minLines: maxLines == 1 ? 1 : 3,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(12),
            ),
            contentPadding:
                const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: items
              .map(
                (priority) =>
                    DropdownMenuItem<String>(
                  value: priority,
                  child: Text(priority),
                ),
              )
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(12),
            ),
            contentPadding:
                const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }

  Color _priorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case "high":
        return Colors.red[400]!;
      case "medium":
        return Colors.orange[400]!;
      case "low":
        return Colors.green[400]!;
      default:
        return Colors.grey[400]!;
    }
  }
}