import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets2/custom_navbar.dart';

class HomeView extends StatefulWidget {

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF6F4FA),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),

        onPressed: () {},

        child: const Icon(
          Iconsax.task_square,
          color: Colors.white,
        ),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat,

      bottomNavigationBar: CustomNavbar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                /// TOP BAR
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    const Text(
                      "Good morning, Alex",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),

                    Container(
                      width: 50,
                      height: 50,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(18),
                      ),

                      child: const Icon(
                        Iconsax.element_4,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                /// AI CARD
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),

                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(.08),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      const Text(
                        "AI INSIGHT",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        "Waktu fokus mendalam\nsedang dimulai",
                        style: TextStyle(
                          fontSize: 34,
                          height: 1.2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Beban kognitif Anda sedang rendah.\nIni waktu yang tepat untuk meninjau\narsitektur "Project Alpha".',
                        style: TextStyle(
                          fontSize: 18,
                          height: 1.7,
                          color: Color(0xFF5B5563),
                        ),
                      ),

                      const SizedBox(height: 28),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 18,
                        ),

                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(22),

                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(.3),
                              blurRadius: 18,
                              offset: const Offset(0, 10),
                            )
                          ],
                        ),

                        child: const Text(
                          "Mulai Sesi Fokus",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                /// STATS
                Row(
                  children: [

                    Expanded(
                      child: statCard(),
                    ),

                    const SizedBox(width: 20),

                    Expanded(
                      child: efficiencyCard(),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                /// DAILY RITUALS
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    const Text(
                      "Daily Rituals",
                      style: TextStyle(
                        fontSize: 30,
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

                const SizedBox(height: 20),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: Row(
                    children: [

                      ritualCard(
                        title: "Mindful Morning",
                        time: "10 min",
                        icon: Iconsax.sun_1,
                      ),

                      const SizedBox(width: 16),

                      ritualCard(
                        title: "Focus Break",
                        time: "5 min",
                        icon: Iconsax.coffee,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                /// TIMELINE
                const Text(
                  "Today's Timeline",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                timelineCard(
                  time: "08:00 AM - 09:00 AM",
                  title: "Morning Rituals",
                  icon: Iconsax.tick_circle,
                ),

                const SizedBox(height: 20),

                activeTimelineCard(),

                const SizedBox(height: 20),

                timelineCard(
                  time: "01:00 PM - 02:00 PM",
                  title: "Sync Meeting",
                  icon: Iconsax.people,
                ),

                const SizedBox(height: 20),

                timelineCard(
                  time: "03:30 PM - 04:30 PM",
                  title: "Inbox Zero",
                  icon: Iconsax.sms,
                ),

                const SizedBox(height: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget statCard() {
    return Container(
      height: 240,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Container(
            width: 110,
            height: 110,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary,
                width: 8,
              ),
            ),

            child: const Center(
              child: Text(
                "75%",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Daily Goal",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "6 of 8 tasks done",
            style: TextStyle(
              color: Color(0xFF5B5563),
            ),
          ),
        ],
      ),
    );
  }

  Widget efficiencyCard() {
    return Container(
      height: 240,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              const Text(
                "Efficiency",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Icon(
                Iconsax.chart_2,
                color: AppColors.primary,
              ),
            ],
          ),

          const Spacer(),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,

            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              bar(40),
              bar(60),
              activeBar(90),
              bar(50),
              bar(65),
            ],
          ),

          const SizedBox(height: 20),

          const Text(
            "+12% vs yesterday",
            style: TextStyle(
              color: Color(0xFF5B5563),
            ),
          ),
        ],
      ),
    );
  }

  Widget bar(double height) {
    return Container(
      width: 22,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFE5D8FA),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget activeBar(double height) {
    return Container(
      width: 22,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),

        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
    );
  }

  Widget ritualCard({
    required String title,
    required String time,
    required IconData icon,
  }) {

    return Container(
      width: 270,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),

      child: Row(
        children: [

          Container(
            width: 55,
            height: 55,

            decoration: BoxDecoration(
              color: const Color(0xFFF1E8FF),
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  time,
                  style: const TextStyle(
                    color: Color(0xFF5B5563),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget timelineCard({
    required String time,
    required String title,
    required IconData icon,
  }) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                time,
                style: const TextStyle(
                  color: Color(0xFF8A8395),
                ),
              ),

              const SizedBox(height: 8),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Icon(
            icon,
            color: const Color(0xFF6A6274),
          ),
        ],
      ),
    );
  }

  Widget activeTimelineCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),

        border: Border.all(
          color: AppColors.primary,
          width: 2,
        ),

        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(.12),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const Text(
            "09:30 AM - 11:30 AM (NOW)",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            "Deep Work: Architecture",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [

              tag("PRIORITY"),

              const SizedBox(width: 10),

              tag("FOCUS"),
            ],
          ),
        ],
      ),
    );
  }

  Widget tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),

      decoration: BoxDecoration(
        color: const Color(0xFFF1E8FF),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}