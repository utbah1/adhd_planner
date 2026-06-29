import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class DayItem extends StatelessWidget {

  final String day;
  final bool isActive;

  const DayItem({
    super.key,
    required this.day,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {

    if (isActive) {

      return Container(
        width: 55,
        height: 55,

        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),

        child: Center(
          child: Text(
            day,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Text(
      day,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}