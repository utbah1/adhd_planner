import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class MotivationCard extends StatelessWidget {

  const MotivationCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 220,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),

        image: const DecorationImage(
          image: AssetImage(
            'assets/images/onboarding2.jpeg',
          ),
          fit: BoxFit.cover,
        ),
      ),

      child: Container(
        padding: const EdgeInsets.all(24),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),

          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,

            colors: [
              AppColors.primary.withOpacity(.82),
              Colors.transparent,
            ],
          ),
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          mainAxisAlignment:
              MainAxisAlignment.end,

          children: const [

            Text(
              "Terus Fokus, Alex",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "Anda 12% lebih produktif hari ini daripada minggu lalu.",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}