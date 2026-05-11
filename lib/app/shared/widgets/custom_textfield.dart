import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {

  final String hint;
  final IconData icon;
  final bool obscure;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 62,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border,
        ),
      ),

      child: TextField(
        obscureText: obscure,

        decoration: InputDecoration(
          border: InputBorder.none,

          hintText: hint,

          prefixIcon: Icon(
            icon,
            color: AppColors.textGrey,
          ),

          suffixIcon: obscure
              ? const Icon(
                  Iconsax.eye,
                  color: AppColors.textGrey,
                )
              : null,
        ),
      ),
    );
  }
}