import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {

  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {

    return const Column(
      children: [

        Text(
          "Alexx",
          style: TextStyle(
            fontSize: 44,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 8),

        Text(
          "Mindful Productivity Enthusiast",
          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF6A6274),
          ),
        ),
      ],
    );
  }
}