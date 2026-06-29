import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'day_item.dart';

class CalendarCard extends StatelessWidget {

  const CalendarCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),

      child: Column(
        children: [

          /// HEADER
          Row(
            children: [

              const Expanded(
                child: Text(
                  "Selasa, 19 Mei",

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F1F29),
                  ),
                ),
              ),

              calendarButton(
                Iconsax.arrow_left_2,
              ),

              const SizedBox(width: 10),

              calendarButton(
                Iconsax.arrow_right_3,
              ),
            ],
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
          const Row(
            children: [

              Expanded(
                child: Center(
                  child: DayItem(day: "17"),
                ),
              ),

              Expanded(
                child: Center(
                  child: DayItem(day: "18"),
                ),
              ),

              Expanded(
                child: Center(
                  child: DayItem(
                    day: "19",
                    isActive: true,
                  ),
                ),
              ),

              Expanded(
                child: Center(
                  child: DayItem(day: "20"),
                ),
              ),

              Expanded(
                child: Center(
                  child: DayItem(day: "21"),
                ),
              ),

              Expanded(
                child: Center(
                  child: DayItem(day: "22"),
                ),
              ),

              Expanded(
                child: Center(
                  child: DayItem(day: "23"),
                ),
              ),
            ],
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