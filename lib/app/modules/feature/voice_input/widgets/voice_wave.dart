import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class VoiceWave extends StatelessWidget {

  final double height;
  final bool active;

  const VoiceWave({
    super.key,
    required this.height,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 10,
      height: height,

      margin:
          const EdgeInsets.symmetric(
        horizontal: 4,
      ),

      decoration: BoxDecoration(

        color: active
            ? AppColors.primary
            : const Color(0xFFD9C5FA),

        borderRadius:
            BorderRadius.circular(20),

        boxShadow: active
            ? [
                BoxShadow(
                  color: AppColors.primary
                      .withOpacity(.25),

                  blurRadius: 10,
                  offset:
                      const Offset(0, 6),
                )
              ]
            : [],
      ),
    );
  }
}