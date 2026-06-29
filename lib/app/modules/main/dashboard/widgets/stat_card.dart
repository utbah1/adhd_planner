import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class StatCard extends StatelessWidget {

  const StatCard({super.key});

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
}