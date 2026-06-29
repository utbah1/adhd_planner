import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';

class ProTipCard extends StatelessWidget {

  const ProTipCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: const Color(0xFFEFE5FF),

        borderRadius:
            BorderRadius.circular(28),

        boxShadow: [
          BoxShadow(
            color:
                AppColors.primary.withOpacity(.06),

            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          /// HEADER
          Row(
            children: [

              Container(
                width: 40,
                height: 40,

                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(.45),

                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Iconsax.lamp_1,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),

              const SizedBox(width: 12),

              const Text(
                "Pro Tip",

                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight:
                      FontWeight.bold,

                  fontSize: 16,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          /// CONTENT
          const Text(
            "Use Voice Input for rapid brainstorming. Our AI will automatically categorize tasks for your planner.",

            style: TextStyle(
              fontSize: 15,
              height: 1.8,
              color: Color(0xFF4B4257),
            ),
          ),
        ],
      ),
    );
  }
}