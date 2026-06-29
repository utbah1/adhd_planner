import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/widgets2/custom_navbar.dart';
import '../../../../shared/widgets2/custom_topbar.dart';

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

      appBar: CustomTopbar(
        title: "Good morning, Alex",
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
        

        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                const CalendarCard(),

                const SizedBox(height: 40),

                const TodayHeader(),

                const SizedBox(height: 28),

                const ScheduleItem(
                  time: "09:00",
                  title: "Ritual Pagi",
                  subtitle: "Meditasi & Jurnal",
                  icon: Iconsax.sun_1,
                ),

                const SizedBox(height: 24),

                const ActiveScheduleCard(),

                const SizedBox(height: 24),

                const ScheduleItem(
                  time: "14:00",
                  title: "Review Proyek",
                  subtitle: "Tim Engineering",
                  icon: Iconsax.people,
                ),

                const SizedBox(height: 40),

                Align(
                  alignment: Alignment.centerRight,

                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(30),
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

                const SizedBox(height: 55),
              ],
            ),
          ),
        ),
      ),
    );
  }
}