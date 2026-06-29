import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class TagWidget extends StatelessWidget {

  final String text;

  const TagWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),

      decoration: BoxDecoration(
        color: const Color(0xFFF1E8FF),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}