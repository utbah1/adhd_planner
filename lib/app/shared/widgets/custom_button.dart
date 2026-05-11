import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class CustomButton extends StatelessWidget {

  final String text;
  final VoidCallback onTap;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,

      child: Container(
        height: 60,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),

          gradient: const LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.secondary,
            ],
          ),

          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(.3),
              blurRadius: 15,
              offset: const Offset(0, 10),
            )
          ],
        ),

        child: Center(
          child: Text(
            text,
            style: AppTextStyles.button,
          ),
        ),
      ),
    );
  }
}