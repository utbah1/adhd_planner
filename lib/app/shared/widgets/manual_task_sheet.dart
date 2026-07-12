import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../modules/feature/add_task/controllers/add_task_controller.dart';

void showManualTaskSheet(BuildContext context) {
  final controller = Get.find<AddTaskController>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _ManualTaskSheet(
      controller: controller,
    ),
  );
}

class _ManualTaskSheet extends StatefulWidget {
  final AddTaskController controller;

  const _ManualTaskSheet({
    required this.controller,
  });

  @override
  State<_ManualTaskSheet> createState() =>
      _ManualTaskSheetState();
}

class _ManualTaskSheetState
    extends State<_ManualTaskSheet> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            24,
            24,
            MediaQuery.of(context).viewInsets.bottom +
                24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: [
              /// HEADER
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Add Task Manually",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// TITLE FIELD
              _buildTextField(
                controller:
                    widget.controller.titleController,
                label: "Task Title",
                hintText: "Apa judul task-mu?",
                icon: Iconsax.edit_2,
              ),

              const SizedBox(height: 16),

              /// DESCRIPTION FIELD
              _buildTextField(
                controller: widget
                    .controller.descriptionController,
                label: "Description (Optional)",
                hintText: "Deskripsikan task-mu...",
                icon: Iconsax.note,
                maxLines: 3,
              ),

              const SizedBox(height: 16),

              /// PRIORITY DROPDOWN
              Obx(
                () => _buildDropdown(
                  label: "Priority",
                  value:
                      widget.controller.priority.value,
                  items: AddTaskController.priorities,
                  onChanged: (val) {
                    if (val != null) {
                      widget.controller
                          .setPriority(val);
                    }
                  },
                ),
              ),

              const SizedBox(height: 16),

              /// DUE DATE PICKER
              Obx(
                () => _buildDatePickerField(
                  label: "Due Date",
                  value: widget.controller.dueDate.value,
                  onTap: () async {
                    final picked =
                        await showDatePicker(
                      context: context,
                      initialDate:
                          widget.controller.dueDate
                                  .value ??
                              DateTime.now().add(
                                const Duration(days: 1),
                              ),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        const Duration(days: 365),
                      ),
                    );

                    if (picked != null) {
                      widget.controller
                          .setDueDate(picked);
                    }
                  },
                ),
              ),

              const SizedBox(height: 16),

              /// START TIME PICKER
              Obx(
                () => _buildTimePickerField(
                  label: "Start Time",
                  value:
                      widget.controller.startTime.value,
                  onTap: () async {
                    final picked =
                        await showTimePicker(
                      context: context,
                      initialTime: widget.controller
                              .startTime.value ??
                          TimeOfDay.now(),
                    );

                    if (picked != null) {
                      widget.controller
                          .setStartTime(picked);
                    }
                  },
                ),
              ),

              const SizedBox(height: 16),

              /// DURATION SELECTOR (OPTIONAL)
              Obx(
                () => Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.only(bottom: 8),
                      child: Text(
                        "Duration (Optional)",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight:
                              FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300]!,
                        ),
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Wrap(
                          spacing: 4,
                          children: [
                            ...AddTaskController
                                .durations
                                .map(
                              (duration) =>
                                  _buildDurationChip(
                                duration: duration,
                                selected: widget
                                        .controller
                                        .durationMinutes
                                        .value ==
                                    duration,
                                onSelected: (selected) {
                                  if (selected) {
                                    widget.controller
                                        .setDurationMinutes(
                                      duration,
                                    );
                                  } else {
                                    widget.controller
                                        .clearDurationMinutes();
                                  }
                                },
                              ),
                            ),
                            if (widget.controller
                                    .durationMinutes
                                    .value !=
                                null)
                              FilterChip(
                                label: const Icon(
                                  Icons.close,
                                  size: 16,
                                ),
                                onSelected: (_) {
                                  widget.controller
                                      .clearDurationMinutes();
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (widget.controller
                            .displayTimeRange.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: Text(
                          "⏱️ ${widget.controller.displayTimeRange}",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                            fontWeight:
                                FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              /// SUBMIT BUTTON
              Obx(
                () => ElevatedButton(
                  onPressed: widget.controller
                          .isSubmitting.value
                      ? null
                      : () async {
                          final success = await widget
                              .controller
                              .submit();

                          if (success) {
                            Get.back();
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.deepPurple[400],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                  ),
                  child: widget.controller
                          .isSubmitting.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<
                                    Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text(
                          "Create Task",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextField(
          controller: controller,
          maxLines: maxLines,
          minLines: maxLines == 1 ? 1 : 3,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon),
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
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
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

  Widget _buildDatePickerField({
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[300]!,
              ),
              borderRadius:
                  BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value != null
                      ? "${value.day}/${value.month}/${value.year}"
                      : "Select date",
                  style: TextStyle(
                    color: value != null
                        ? Colors.black
                        : Colors.grey[500],
                  ),
                ),
                Icon(
                  Iconsax.calendar,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimePickerField({
    required String label,
    required TimeOfDay? value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[300]!,
              ),
              borderRadius:
                  BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value != null
                      ? "${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}"
                      : "Select time",
                  style: TextStyle(
                    color: value != null
                        ? Colors.black
                        : Colors.grey[500],
                  ),
                ),
                Icon(
                  Iconsax.clock,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDurationChip({
    required int duration,
    required bool selected,
    required Function(bool) onSelected,
  }) {
    return FilterChip(
      label: Text(
        "${duration}m",
        style: TextStyle(
          color: selected ? Colors.white : null,
          fontWeight: selected
              ? FontWeight.w600
              : FontWeight.w500,
        ),
      ),
      selected: selected,
      onSelected: onSelected,
      backgroundColor: selected
          ? Colors.deepPurple[400]
          : Colors.grey[100],
      side: selected
          ? BorderSide(
              color: Colors.deepPurple[400]!,
            )
          : BorderSide(
              color: Colors.grey[300]!,
            ),
    );
  }
}