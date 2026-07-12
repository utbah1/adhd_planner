import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';

class WeeklyTargetCard
    extends StatelessWidget {

  const WeeklyTargetCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Icon(
            Iconsax.activity,
            color: AppColors.primary,
          ),

          const SizedBox(height: 6),

          const Text(
            "Target\nMingguan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            "24/30",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Container(
            height: 8,

            decoration: BoxDecoration(
              color: const Color(0xFFE5E5EA),
              borderRadius:
                  BorderRadius.circular(10),
            ),

            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: .75,

              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            "Selesaikan 4 Task Lagi",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}