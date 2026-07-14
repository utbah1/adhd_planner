import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';

class TimelineCard extends StatelessWidget {

  final String timeRange;
  final String title;
  final String subtitle;
  final bool isCompleted;
  final VoidCallback? onTap;

  const TimelineCard({
    super.key,
    required this.timeRange,
    required this.title,
    this.subtitle = "",
    this.isCompleted = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(
                    timeRange,
                    style: const TextStyle(
                      color: Color(0xFF8A8395),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Color(0xFF8A8395),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(width: 12),

            Icon(
              isCompleted
                  ? Iconsax.tick_circle5
                  : Iconsax.record_circle,
              color: isCompleted
                  ? AppColors.primary
                  : const Color(0xFF6A6274),
            ),
          ],
        ),
      ),
    );
  }
}
