import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';

import '../controllers/focus_mode_controller.dart';

class FocusTimerCircle extends StatelessWidget {

  final FocusModeController controller;

  const FocusTimerCircle({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 380,
      height: 380,

      decoration: BoxDecoration(
        shape: BoxShape.circle,

        border: Border.all(
          color: AppColors.primary,
          width: 10,
        ),

        boxShadow: [
          BoxShadow(
            color:
                AppColors.primary.withOpacity(.15),

            blurRadius: 25,
            offset: const Offset(0, 10),
          )
        ],
      ),

      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          /// TIMER
          Obx(
            () => Text(
              controller.formattedTime,

              style: const TextStyle(
                fontSize: 90,
                fontWeight: FontWeight.bold,
                color: Color(0xFF132238),
              ),
            ),
          ),

          const SizedBox(height: 18),

          /// STATUS
          const Row(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              Icon(
                Iconsax.flash_1,
                color: AppColors.primary,
                size: 18,
              ),

              SizedBox(width: 8),

              Text(
                "FOCUSING",

                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 26,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
