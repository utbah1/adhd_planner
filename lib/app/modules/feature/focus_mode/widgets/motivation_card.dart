import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';

class MotivationCard extends StatelessWidget {

  const MotivationCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(34),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(.05),

            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      ),

      child: Row(
        children: [

          /// ICON
          Container(
            width: 70,
            height: 70,

            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),

            child: const Icon(
              Iconsax.star_1,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 18),

          /// TEXT
          const Expanded(
            child: Text(
              '"You\'re doing great, Alex. One\nstep at a time."',

              style: TextStyle(
                fontSize: 18,
                height: 1.6,
                color: Color(0xFF4B4257),
              ),
            ),
          ),
        ],
      ),
    );
  }
}