import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';

class ActiveScheduleCard
    extends StatelessWidget {

  const ActiveScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        const SizedBox(
          width: 70,

          child: Text(
            "10:30",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),

        Container(
          width: 2,
          height: 110,
          color: const Color(0xFFE5E5EA),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: Container(
            padding: const EdgeInsets.all(24),

            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.primary,
                  Color(0xFFA855F7),
                ],
              ),

              borderRadius:
                  BorderRadius.circular(26),
            ),

            child: Row(
              children: [

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Text(
                        "Deep Work Session",

                        overflow:
                            TextOverflow.ellipsis,

                        maxLines: 1,

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Design UI App Baru",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                Container(
                  width: 55,
                  height: 55,

                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white24,
                    ),

                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Iconsax.scan,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}