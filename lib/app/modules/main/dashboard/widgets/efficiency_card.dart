import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';

class EfficiencyCard extends StatelessWidget {

  const EfficiencyCard({super.key});

  @override
  Widget build(BuildContext context) {

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

              Expanded(
                child: Text(
                  "Efficiency",

                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
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
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              bar(40),
              bar(60),
              activeBar(90),
              bar(50),
              bar(65),
            ],
          ),

          const SizedBox(height: 20),

          const Text(
            "+12% vs yesterday",
            style: TextStyle(
              color: Color(0xFF5B5563),
            ),
          ),
        ],
      ),
    );
  }

  Widget bar(double height) {
    return Container(
      width: 16,
      height: height,

      decoration: BoxDecoration(
        color: const Color(0xFFE5D8FA),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget activeBar(double height) {
    return Container(
      width: 16,
      height: height,

      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}