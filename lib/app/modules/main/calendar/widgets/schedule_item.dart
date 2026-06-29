import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ScheduleItem extends StatelessWidget {

  final String time;
  final String title;
  final String subtitle;
  final IconData icon;

  const ScheduleItem({
    super.key,
    required this.time,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
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
              color: Color(0xFF5B5563),
            ),
          ),
        ),

        Container(
          width: 2,
          height: 90,
          color: const Color(0xFFE5E5EA),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: Container(
            padding: const EdgeInsets.all(24),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(24),
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
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        subtitle,
                        style: const TextStyle(
                          color:
                              Color(0xFF8A8395),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                Icon(
                  icon,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}