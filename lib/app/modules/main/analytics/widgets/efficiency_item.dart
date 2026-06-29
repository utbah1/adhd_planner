import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class EfficiencyItem extends StatelessWidget {

  final String title;
  final String subtitle;
  final String value;
  final IconData icon;
  final bool active;

  const EfficiencyItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.icon,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),

        border: active
            ? Border.all(
                color: AppColors.primary,
                width: 2,
              )
            : null,
      ),

      child: Row(
        children: [

          /// LEFT
          Expanded(
            child: Row(
              children: [

                Container(
                  width: 60,
                  height: 60,

                  decoration: BoxDecoration(
                    color: active
                        ? const Color(0xFFF1E8FF)
                        : const Color(0xFFE8EEF9),

                    borderRadius:
                        BorderRadius.circular(18),
                  ),

                  child: Icon(
                    icon,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(width: 18),

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
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        subtitle,

                        overflow:
                            TextOverflow.ellipsis,

                        maxLines: 1,

                        style: const TextStyle(
                          color:
                              Color(0xFF8A8395),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          /// VALUE
          Text(
            value,
            style: TextStyle(
              color: active
                  ? AppColors.primary
                  : const Color(0xFF5B5563),

              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}