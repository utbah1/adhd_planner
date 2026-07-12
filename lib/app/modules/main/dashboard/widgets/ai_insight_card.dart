import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../routes/app_pages.dart';

class AiInsightCard extends StatelessWidget {

  const AiInsightCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),

        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const Text(
            "AI INSIGHT",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            "Waktu Fokus Mendalam Sedang \nDimulai",
            style: TextStyle(
              fontSize: 28,
              height: 1.2,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Beban kognitif Anda sedang \nrendah. Ini waktu yang tepat \nuntuk meninjau arsitektur \n"Project Alpha".',
            style: TextStyle(
              fontSize: 16,
              height: 1.7,
              color: Color(0xFF5B5563),
            ),
          ),

          const SizedBox(height: 28),

          GestureDetector(

            onTap: () {
              Get.toNamed(Routes.FOCUS_MODE);
            },

            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 18,
              ),

              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(22),
              ),

              child: const Text(
                "Mulai Sesi Fokus",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}