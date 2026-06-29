import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {

  const TitleSection({super.key});

  @override
  Widget build(BuildContext context) {

    return const Center(
      child: Column(
        children: [

          Text(
            "Capture Idea",

            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),

          SizedBox(height: 12),

          Text(
            "How would you like to record your thought\ntoday?",

            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Color(0xFF6A6274),
            ),
          ),
        ],
      ),
    );
  }
}