import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';
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
              padding: const EdgeInsets.only(left: 24, right: 24, top: 6, bottom: 24),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  const AiInsightCard(),

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
                    final weekly = controller.weekly.value;

                    return Column(
                      children: [
                        const SizedBox(height: 15),
                        Row(
                      children: [

                        Expanded(
                          child: StatCard(
                            completedTasks:
                                dashboard?.completedTasks ?? 0,
                            totalTasks: dashboard?.totalTasks ?? 0,
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

                  /// DAILY RITUALS
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

                  const Text(
                    "Today's Timeline",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const TimelineCard(
                    time: "08:00 AM - 09:00 AM",
                    title: "Morning Rituals",
                    icon: Iconsax.tick_circle,
                  ),

                  const SizedBox(height: 20),

                  const ActiveTimelineCard(),

                  const SizedBox(height: 20),

                  const TimelineCard(
                    time: "01:00 PM - 02:00 PM",
                    title: "Sync Meeting",
                    icon: Iconsax.people,
                  ),

                  const SizedBox(height: 20),

                  const TimelineCard(
                    time: "03:30 PM - 04:30 PM",
                    title: "Inbox Zero",
                    icon: Iconsax.sms,
                  ),

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