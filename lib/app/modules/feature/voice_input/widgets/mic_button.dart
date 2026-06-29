import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';

class MicButton extends StatelessWidget {

  const MicButton({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 120,
      height: 120,

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
            color:
                AppColors.primary.withOpacity(.3),

            blurRadius: 25,
            offset: const Offset(0, 14),
          )
        ],
      ),

      child: const Icon(
        Iconsax.microphone,
        color: Colors.white,
        size: 52,
      ),
    );
  }
}