import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/task/task_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/widgets2/custom_navbar.dart';
import '../../../../shared/widgets2/custom_topbar.dart';
import '../controllers/home_controller.dart';
import '../widgets/active_timeline_card.dart';
import '../widgets/ai_insight_card.dart';
import '../widgets/efficiency_card.dart';
import '../widgets/ritual_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/timeline_card.dart';

class HomeView extends StatefulWidget {

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int currentIndex = 0;

  final HomeController controller = Get.find<HomeController>();

  void _openTask(TaskModel task) {
    Get.toNamed(
      Routes.TASK_DETAIL,
      arguments: task.id,
    );
  }

  /// Builds the time-range label (e.g. "09:00 - 10:00") from a task.
  String _timeRange(TaskModel task) {
    if (task.startTime == null) return "--:--";
    return task.displayTime.isNotEmpty ? task.displayTime : task.startTime!;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      extendBody: true,

      backgroundColor: const Color(0xFFF6F4FA),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),

        onPressed: () {
          Get.toNamed(Routes.ADD_TASK);
        },

        child: const Icon(
          Iconsax.task_square,
          color: Colors.white,
        ),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat,

      floatingActionButtonAnimator:
          FloatingActionButtonAnimator.noAnimation,

      appBar: CustomTopbar(
        icon: Iconsax.element_4,
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
          onRefresh: controller.refresh,

          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),

            child: Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 6,
                bottom: 24,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  const AiInsightCard(),

                  // ── Stats + Efficiency ──────────────────────
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const SizedBox(
                        height: 240,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (controller.errorMessage.value.isNotEmpty) {
                      return Container(
                        padding: const EdgeInsets.all(20),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              controller.errorMessage.value,
                              style: const TextStyle(
                                color: Colors.redAccent,
                              ),
                            ),

                            const SizedBox(height: 12),

                            TextButton(
                              onPressed: controller.refresh,
                              child: const Text("Coba lagi"),
                            ),
                          ],
                        ),
                      );
                    }

                    final dashboard = controller.dashboard.value;
                    final weekly    = controller.weekly.value;

                    return Column(
                      children: [
                        const SizedBox(height: 15),
                        Row(
                          children: [

                            Expanded(
                              child: StatCard(
                                completedTasks:
                                    dashboard?.completedTasks ?? 0,
                                totalTasks:
                                    dashboard?.totalTasks ?? 0,
                              ),
                            ),

                            const SizedBox(width: 20),

                            Expanded(
                              child: EfficiencyCard(
                                weeklyMinutes: weekly?.toChartMap(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),

                  const SizedBox(height: 20),

                  // ── Daily Rituals ───────────────────────────
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [

                      const Text(
                        "Daily Rituals",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        "Edit",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,

                    child: Row(
                      children: [

                        RitualCard(
                          title: "Mindful Morning",
                          time: "10 min",
                          icon: Iconsax.sun_1,
                        ),

                        SizedBox(width: 16),

                        RitualCard(
                          title: "Focus Break",
                          time: "5 min",
                          icon: Iconsax.coffee,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Today's Timeline ────────────────────────
                  const Text(
                    "Today's Timeline",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Obx(() {

                    // Tunggu loading selesai
                    if (controller.isLoading.value) {
                      return const SizedBox(
                        height: 120,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final tasks      = controller.todayTasks;
                    final highlighted = controller.highlightedTask;

                    // Tidak ada task hari ini
                    if (tasks.isEmpty) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(28),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),

                        child: Column(
                          children: [
                            Icon(
                              Iconsax.calendar_tick,
                              size: 40,
                              color: AppColors.primary.withOpacity(.4),
                            ),

                            const SizedBox(height: 12),

                            const Text(
                              "Tidak ada tugas hari ini",
                              style: TextStyle(
                                color: Color(0xFF8A8395),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    final items = <Widget>[];

                    for (final task in tasks) {
                      final isHighlighted =
                          highlighted != null &&
                          task.id == highlighted.id;

                      if (isHighlighted) {
                        // countdownFor dipanggil langsung di dalam Obx
                        // sehingga tiap timer tick (_now berubah) nilai ini
                        // ikut re-evaluate secara reaktif.
                        items.add(
                          GestureDetector(
                            onTap: () => _openTask(task),
                            child: ActiveTimelineCard(
                              timeRange: _timeRange(task),
                              title: task.title,
                              subtitle:
                                  task.description ?? task.priority,
                              countdown: controller.countdownFor(task),
                            ),
                          ),
                        );
                      } else {
                        items.add(
                          TimelineCard(
                            timeRange: _timeRange(task),
                            title: task.title,
                            subtitle:
                                task.description ?? task.priority,
                            isCompleted: task.isCompleted,
                            onTap: () => _openTask(task),
                          ),
                        );
                      }

                      items.add(const SizedBox(height: 20));
                    }

                    if (items.isNotEmpty) items.removeLast();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
