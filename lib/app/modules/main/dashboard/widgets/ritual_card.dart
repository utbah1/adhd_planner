import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class RitualCard extends StatelessWidget {

  final String title;
  final String time;
  final IconData icon;

  const RitualCard({
    super.key,
    required this.title,
    required this.time,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 270,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),

      child: Row(
        children: [

          Container(
            width: 55,
            height: 55,

            decoration: BoxDecoration(
              color: const Color(0xFFF1E8FF),
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  time,
                  style: const TextStyle(
                    color: Color(0xFF5B5563),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}