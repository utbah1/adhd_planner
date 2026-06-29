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

          const SizedBox(height: 18),

          const Text(
            "Target\nMingguan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "24/30",
            style: TextStyle(
              fontSize: 37,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

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
        ],
      ),
    );
  }
}