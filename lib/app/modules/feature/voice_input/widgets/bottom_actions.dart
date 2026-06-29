import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';

class BottomActions
    extends StatelessWidget {

  const BottomActions({super.key});

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceEvenly,

      children: [

        /// CANCEL
        Column(
          children: [

            Container(
              width: 72,
              height: 72,

              decoration: BoxDecoration(
                color: Colors.white,

                shape: BoxShape.circle,

                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(.04),

                    blurRadius: 14,
                    offset:
                        const Offset(0, 8),
                  ),
                ],
              ),

              child: const Icon(
                Iconsax.close_circle,
                size: 34,
                color: Color(0xFF8A8395),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Cancel",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
              ),
            ),
          ],
        ),

        /// SAVE
        Column(
          children: [

            Container(
              width: 72,
              height: 72,

              decoration: BoxDecoration(

                gradient:
                    const LinearGradient(
                  colors: [
                    AppColors.primary,
                    Color(0xFFA855F7),
                  ],
                ),

                shape: BoxShape.circle,

                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary
                        .withOpacity(.18),

                    blurRadius: 14,
                    offset:
                        const Offset(0, 8),
                  ),
                ],
              ),

              child: const Icon(
                Iconsax.tick_circle,
                size: 34,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Save Task",

              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}