import 'package:flutter/material.dart';

class TodayHeader extends StatelessWidget {

  const TodayHeader({super.key});

  @override
  Widget build(BuildContext context) {

    return const Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,

      children: [

        Text(
          "Agenda Hari Ini",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}