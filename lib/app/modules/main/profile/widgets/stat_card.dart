import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ProfileStatCard extends StatelessWidget {

  final IconData icon;
  final String value;
  final String title;

  const ProfileStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 24,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),

      child: Column(
        children: [

          Icon(
            icon,
            color: AppColors.primary,
            size: 28,
          ),

          const SizedBox(height: 18),

          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            title,
            textAlign: TextAlign.center,

            style: const TextStyle(
              color: Color(0xFF6A6274),
            ),
          ),
        ],
      ),
    );
  }
}