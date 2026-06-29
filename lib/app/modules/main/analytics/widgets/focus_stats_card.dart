import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';

class FocusStatsCard extends StatelessWidget {

  const FocusStatsCard({super.key});

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
            Iconsax.scan,
            color: AppColors.primary,
          ),

          const SizedBox(height: 18),

          const Text(
            "Statistik Fokus",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "5.2j",
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "+12% vs Kemarin",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}