import 'package:flutter/material.dart';

class QuickActionChip
    extends StatelessWidget {

  final String text;

  const QuickActionChip({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 26,
        vertical: 16,
      ),

      decoration: BoxDecoration(
        color: const Color(0xFFF1EAFB),

        borderRadius:
            BorderRadius.circular(30),
      ),

      child: Text(
        text,

        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF4B4257),
        ),
      ),
    );
  }
}