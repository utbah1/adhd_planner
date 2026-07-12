import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';

class EfficiencyCard extends StatelessWidget {
  final Map<String, int>? weeklyMinutes;

  const EfficiencyCard({
    super.key,
    this.weeklyMinutes,
  });

  static const _defaultData = {
    "Mon": 40,
    "Tue": 60,
    "Wed": 90,
    "Thu": 50,
    "Fri": 65,
    "Sat": 0,
    "Sun": 0,
  };

  @override
  Widget build(BuildContext context) {

    final data = weeklyMinutes ?? _defaultData;
    final values = data.values.toList();
    final maxVal = values.isEmpty
        ? 1
        : values.reduce((a, b) => a > b ? a : b).clamp(1, 1 << 30);

    final heights = values
        .map((v) => v <= 0 ? 12.0 : 12.0 + (v / maxVal) * 88.0)
        .toList();

    final todayIndex = DateTime.now().weekday - 1; 
    final activeIndex = todayIndex.clamp(0, heights.length - 1);

    String deltaText = "This week's focus time";
    if (values.length > 1) {
      final today = values[activeIndex];
      final prevIndex = activeIndex == 0 ? values.length - 1 : activeIndex - 1;
      final yesterday = values[prevIndex];

      if (yesterday > 0) {
        final change = (((today - yesterday) / yesterday) * 100).round();
        final sign = change >= 0 ? "+" : "";
        deltaText = "$sign$change% vs yesterday";
      } else if (today > 0) {
        deltaText = "First focus session this week";
      }
    }

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
            children: [

              const Expanded(
                child: Text(
                  "Efficiency",

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Icon(
                Iconsax.chart_2,
                color: AppColors.primary,
                size: 20,
              ),
            ],
          ),

          const Spacer(),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              for (int i = 0; i < heights.length; i++)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: bar(heights[i], active: i == activeIndex),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 20),

          Text(
            deltaText,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              color: Color(0xFF5B5563),
            ),
          ),
        ],
      ),
    );
  }

  Widget bar(double height, {bool active = false}) {
    return Container(
      height: height,
      width: double.infinity,

      decoration: BoxDecoration(
        color: active ? AppColors.primary : const Color(0xFFE5D8FA),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}