import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/utils/date_formatter.dart';
import '../controllers/calendar_controller.dart';

import 'day_item.dart';

// ignore_for_file: use_build_context_synchronously

class CalendarCard extends StatelessWidget {

  const CalendarCard({super.key});

  Future<void> _openDatePicker(
    BuildContext context,
    CalendarController controller,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      controller.jumpToDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {

    final CalendarController controller = Get.find();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 24),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),

      child: Column(
        children: [

          /// HEADER
          Obx(
            () => Row(
              children: [

                Expanded(
                  child: GestureDetector(
                    onTap: () => _openDatePicker(context, controller),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            DateFormatter.full(
                              controller.selectedDate.value,
                            ),

                            overflow: TextOverflow.ellipsis,

                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1F1F29),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: controller.goToPreviousWeek,
                  child: calendarButton(
                    Iconsax.arrow_left_2,
                  ),
                ),

                const SizedBox(width: 10),

                GestureDetector(
                  onTap: controller.goToNextWeek,
                  child: calendarButton(
                    Iconsax.arrow_right_3,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          /// DAYS
          Row(
            children: [

              Expanded(child: dayLabel("M")),
              Expanded(child: dayLabel("S")),
              Expanded(child: dayLabel("S")),
              Expanded(child: dayLabel("R")),
              Expanded(child: dayLabel("K")),
              Expanded(child: dayLabel("J")),
              Expanded(child: dayLabel("S")),
            ],
          ),

          const SizedBox(height: 24),

          /// DATES
          Obx(
            () => Row(
              children: controller.weekDates.map((date) {

                final isActive = controller.isSameDate(
                  date,
                  controller.selectedDate.value,
                );

                return Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: () =>
                          controller.selectDate(date),

                      child: DayItem(
                        day: "${date.day}",
                        isActive: isActive,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  static Widget dayLabel(String text) {

    return Center(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF7B7484),
        ),
      ),
    );
  }

  Widget calendarButton(IconData icon) {

    return Container(
      width: 36,
      height: 36,

      decoration: BoxDecoration(
        color: const Color(0xFFF7F7FB),
        borderRadius: BorderRadius.circular(12),
      ),

      child: Icon(
        icon,
        size: 18,
        color: const Color(0xFF6F687A),
      ),
    );
  }
}