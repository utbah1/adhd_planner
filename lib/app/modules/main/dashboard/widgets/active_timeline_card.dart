import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import 'tag_widget.dart';

class ActiveTimelineCard extends StatelessWidget {

  const ActiveTimelineCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),

        border: Border.all(
          color: AppColors.primary,
          width: 2,
        ),

        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(.12),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const Text(
            "09:30 AM - 11:30 AM (NOW)",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            "Deep Work: Architecture",
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          const Row(
            children: [

              TagWidget(
                text: "PRIORITY",
              ),

              SizedBox(width: 10),

              TagWidget(
                text: "FOCUS",
              ),
            ],
          ),
        ],
      ),
    );
  }
}