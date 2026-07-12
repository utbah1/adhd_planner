import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/task/task_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/widgets2/custom_navbar.dart';
import '../../../../shared/widgets2/custom_topbar.dart';

import '../controllers/calendar_controller.dart';
import '../widgets/active_schedule_card.dart';
import '../widgets/calendar_card.dart';
import '../widgets/schedule_item.dart';
import '../widgets/today_header.dart';

class CalendarView extends StatefulWidget {

  const CalendarView({super.key});

  @override
  State<CalendarView> createState() =>
      _CalendarViewState();
}

class _CalendarViewState
    extends State<CalendarView> {

  int currentIndex = 1;

  final CalendarController controller = Get.find();

  IconData _iconForTask(TaskModel task) {
    switch (task.priority) {
      case "High":
        return Iconsax.flash_1;
      case "Low":
        return Iconsax.calendar_1;
      default:
        return Iconsax.task_square;
    }
  }

  void _openTask(TaskModel task) {
    Get.toNamed(
      Routes.TASK_DETAIL,
      arguments: task.id,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      extendBody: true,

      backgroundColor: const Color(0xFFF6F4FA),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,

        onPressed: () {
          Get.toNamed(Routes.ADD_TASK);
        },

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      floatingActionButtonAnimator:
          FloatingActionButtonAnimator.noAnimation,

      appBar: CustomTopbar(
        icon: Iconsax.calendar_1,
      ),

      bottomNavigationBar: CustomNavbar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),

      body: SafeArea(

        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: controller.refresh,

          child: SingleChildScrollView(
            physics:
                const AlwaysScrollableScrollPhysics(),

child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 6, bottom: 24),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const CalendarCard(),

                  const SizedBox(height: 10),

                  const TodayHeader(),

                  const SizedBox(height: 28),

                  Obx(() {

                    if (controller.isLoading.value) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 40,
                        ),
                        child: Center(
                          child:
                              CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      );
                    }

                    if (controller
                        .errorMessage.value.isNotEmpty) {
                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 40,
                        ),
                        child: Center(
                          child: Text(
                            controller
                                .errorMessage.value,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF8A8395),
                            ),
                          ),
                        ),
                      );
                    }

                    final tasks =
                        controller.tasksForSelectedDate;
                    final highlighted =
                        controller.highlightedTask;

                    if (tasks.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 40,
                        ),
                        child: Center(
                          child: Text(
                            "Tidak ada tugas pada tanggal ini",
                            style: TextStyle(
                              color: Color(0xFF8A8395),
                            ),
                          ),
                        ),
                      );
                    }

                    final items = <Widget>[];

                    for (final task in tasks) {

                      final isHighlighted = highlighted !=
                              null &&
                          task.id == highlighted.id;

                      items.add(
                        isHighlighted
                            ? ActiveScheduleCard(
                                time: task.startTime ??
                                    "--:--",
                                title: task.title,
                                subtitle:
                                    task.description ??
                                        task.priority,
                                icon: _iconForTask(task),
                                onTap: () =>
                                    _openTask(task),
                              )
                            : ScheduleItem(
                                time: task.startTime ??
                                    "--:--",
                                title: task.title,
                                subtitle:
                                    task.description ??
                                        task.priority,
                                icon: _iconForTask(task),
                                onTap: () =>
                                    _openTask(task),
                              ),
                      );

                      items.add(
                        const SizedBox(height: 24),
                      );
                    }

                    // Remove the trailing spacer.
                    if (items.isNotEmpty) {
                      items.removeLast();
                    }

                    return Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: items,
                    );
                  }),

                  const SizedBox(height: 55),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
