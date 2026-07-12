import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {

  const PageHeader({super.key});

  @override
  Widget build(BuildContext context) {

    return const Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Text(
          "Analitik Produktivitas",
          style: TextStyle(
            fontSize: 28,
            height: 1.2,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 5),

        Text(
          "Lacak Kemajuan Dan Optimalkan \nRitme Kerja Anda.",
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
            color: Color(0xFF5B5563),
          ),
        ),
      ],
    );
  }
}