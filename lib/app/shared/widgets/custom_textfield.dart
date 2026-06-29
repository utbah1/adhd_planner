import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hint;

  final IconData icon;

  final TextEditingController controller;

  final bool obscure;

  final Widget? suffixIcon;

  final TextInputType keyboardType;

  final int maxLines;

  final bool enabled;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.obscure = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxLines == 1 ? 68 : null,

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(22),

        border: Border.all(
          color: AppColors.border,
        ),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: TextField(
        controller: controller,

        obscureText: obscure,

        keyboardType: keyboardType,

        maxLines:
            obscure ? 1 : maxLines,

        enabled: enabled,

        style: const TextStyle(
          fontSize: 17,
          color: Color(0xFF2B2238),
          fontWeight: FontWeight.w500,
        ),

        decoration: InputDecoration(
          border: InputBorder.none,

          contentPadding:
              const EdgeInsets.symmetric(
            vertical: 20,
          ),

          hintText: hint,

          hintStyle: const TextStyle(
            color: Color(0xFF9D97A8),
            fontSize: 17,
          ),

          prefixIcon: Padding(
            padding: const EdgeInsets.only(
              left: 18,
              right: 14,
            ),

            child: Icon(
              icon,
              color: AppColors.textGrey,
            ),
          ),

          prefixIconConstraints:
              const BoxConstraints(
            minWidth: 60,
          ),

          suffixIcon: suffixIcon,

          suffixIconConstraints:
              const BoxConstraints(
            minWidth: 60,
          ),
        ),
      ),
    );
  }
}