import 'package:flutter/material.dart';

class TimelineCard extends StatelessWidget {

  final String time;
  final String title;
  final IconData icon;

  const TimelineCard({
    super.key,
    required this.time,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  time,
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
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Icon(
            icon,
            color: const Color(0xFF6A6274),
          ),
        ],
      ),
    );
  }
}