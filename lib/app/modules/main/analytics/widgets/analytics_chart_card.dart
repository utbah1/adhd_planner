import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';

class AnalyticsChartCard
    extends StatelessWidget {

  const AnalyticsChartCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: const [

                  Text(
                    "Efisiensi Anda",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "87%",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),

              Container(
                width: 50,
                height: 50,

                decoration: BoxDecoration(
                  color: const Color(0xFFF1E8FF),
                  borderRadius:
                      BorderRadius.circular(16),
                ),

                child: const Icon(
                  Iconsax.flash_1,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 35),

          Row(
            crossAxisAlignment:
                CrossAxisAlignment.end,

            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              bar(40),
              bar(60),
              bar(30),
              bar(85),
              bar(55),
              bar(45),
              activeBar(100),
              bar(75),
              bar(52),
              bar(68),
            ],
          ),

          const SizedBox(height: 20),

          const Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              Text("08:00"),
              Text("12:00"),
              Text("16:00"),
              Text("20:00"),
            ],
          ),
        ],
      ),
    );
  }

  static Widget bar(double height) {

    return Container(
      width: 18,
      height: height,

      decoration: BoxDecoration(
        color: const Color(0xFFE5D8FA),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  static Widget activeBar(double height) {

    return Container(
      width: 18,
      height: height,

      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}