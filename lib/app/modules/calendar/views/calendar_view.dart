import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets2/custom_navbar.dart';

class CalendarView extends StatefulWidget {

  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {

  int currentIndex = 1;

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
          Icons.add,
          color: Colors.white,
          size: 32,
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

                    Row(
                      children: [

                        Container(
                          width: 45,
                          height: 45,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(14),
                          ),

                          child: const Icon(
                            Iconsax.calendar_1,
                            color: AppColors.primary,
                          ),
                        ),

                        const SizedBox(width: 16),

                        const Text(
                          "Januari",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                /// CALENDAR CARD
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                  ),

                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,

                        children: [

                          const Text(
                            "Senin, 15 Januari",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          Row(
                            children: [

                              Icon(
                                Iconsax.arrow_left_2,
                                color: Colors.grey.shade600,
                              ),

                              const SizedBox(width: 8),

                              Icon(
                                Iconsax.arrow_right_3,
                                color: Colors.grey.shade600,
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceAround,

                        children: const [

                          Text("M"),
                          Text("S"),
                          Text("S"),
                          Text("R"),
                          Text("K"),
                          Text("J"),
                          Text("S"),
                        ],
                      ),

                      const SizedBox(height: 22),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceAround,

                        children: [

                          dayItem("14"),

                          activeDay("15"),

                          dayItem("16"),

                          dayItem("17"),

                          dayItem("18"),

                          dayItem("19"),

                          dayItem("20"),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                /// TITLE
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    const Text(
                      "Agenda Hari Ini",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                scheduleItem(
                  time: "09:00",
                  title: "Ritual Pagi",
                  subtitle: "Meditasi & Jurnal",
                  icon: Iconsax.sun_1,
                ),

                const SizedBox(height: 24),

                activeSchedule(),

                const SizedBox(height: 24),

                scheduleItem(
                  time: "14:00",
                  title: "Review Proyek",
                  subtitle: "Tim Engineering",
                  icon: Iconsax.people,
                ),

                const SizedBox(height: 40),

                Align(
                  alignment: Alignment.centerRight,

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(30),

                      boxShadow: [
                        BoxShadow(
                          color:
                              AppColors.primary.withOpacity(.1),
                          blurRadius: 18,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),

                    child: const Text(
                      "Tambah Tugas",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dayItem(String day) {
    return Text(
      day,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget activeDay(String day) {
    return Container(
      width: 55,
      height: 55,

      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,

        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(.3),
            blurRadius: 12,
            offset: const Offset(0, 8),
          )
        ],
      ),

      child: Center(
        child: Text(
          day,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget scheduleItem({
    required String time,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        SizedBox(
          width: 70,

          child: Text(
            time,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: time == "10:30"
                  ? AppColors.primary
                  : const Color(0xFF5B5563),
            ),
          ),
        ),

        Container(
          width: 2,
          height: 90,
          color: const Color(0xFFE5E5EA),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: Container(
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
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF8A8395),
                      ),
                    ),
                  ],
                ),

                Icon(
                  icon,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget activeSchedule() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        const SizedBox(
          width: 70,

          child: Text(
            "10:30",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),

        Container(
          width: 2,
          height: 110,
          color: const Color(0xFFE5E5EA),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: Container(
            padding: const EdgeInsets.all(24),

            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.primary,
                  Color(0xFFA855F7),
                ],
              ),

              borderRadius: BorderRadius.circular(26),

              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(.25),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),

            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const Text(
                      "Deep Work Session",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Design UI App Baru",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),

                Container(
                  width: 55,
                  height: 55,

                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white24,
                    ),

                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Iconsax.scan,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}