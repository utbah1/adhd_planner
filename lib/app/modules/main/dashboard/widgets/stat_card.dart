import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class StatCard extends StatelessWidget {
  final int completedTasks;
  final int totalTasks;

  const StatCard({
    super.key,
    this.completedTasks = 6,
    this.totalTasks = 8,
  });

  int get _percentage {
    if (totalTasks <= 0) return 0;
    return ((completedTasks / totalTasks) * 100).round();
  }

  @override
  Widget build(BuildContext context) {

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

            child: Center(
              child: Text(
                "$_percentage%",
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            "Daily Goal",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "$completedTasks of $totalTasks tasks done",
            style: const TextStyle(
              color: Color(0xFF5B5563),
            ),
          ),
        ],
      ),
    );
  }
}