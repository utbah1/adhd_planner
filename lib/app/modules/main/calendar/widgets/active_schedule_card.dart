import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';

class ActiveScheduleCard
    extends StatelessWidget {

  final String time;
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const ActiveScheduleCard({
    super.key,
    this.time = "10:30",
    this.title = "Deep Work Session",
    this.subtitle = "Design UI App Baru",
    this.icon = Iconsax.scan,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          SizedBox(
            width: 70,

            child: Text(
              time,
              style: const TextStyle(
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

                        Text(
                          title,

                          overflow:
                              TextOverflow.ellipsis,

                          maxLines: 1,

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          subtitle,

                          overflow:
                              TextOverflow.ellipsis,

                          maxLines: 1,

                          style: const TextStyle(
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

                    child: Icon(
                      icon,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
