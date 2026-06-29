import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class InputCard extends StatelessWidget {

  final IconData icon;
  final String title;
  final String subtitle;
  final bool active;

  const InputCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(28),
      ),

      child: Row(
        children: [

          /// ICON
          Container(
            width: 82,
            height: 82,

            decoration: BoxDecoration(

              gradient: active
                  ? const LinearGradient(
                      colors: [
                        AppColors.primary,
                        Color(0xFFA855F7),
                      ],
                    )
                  : null,

              color: active
                  ? null
                  : const Color(0xFFE5DDF7),

              borderRadius:
                  BorderRadius.circular(24),
            ),

            child: Icon(
              icon,

              color: active
                  ? Colors.white
                  : const Color(0xFF5B5563),

              size: 34,
            ),
          ),

          const SizedBox(width: 18),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              mainAxisSize: MainAxisSize.min,

              children: [

                Text(
                  title,

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                    height: 1.3,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  subtitle,

                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: Color(0xFF6A6274),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          /// ARROW
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Color(0xFFC2B9CF),
          ),
        ],
      ),
    );
  }
}