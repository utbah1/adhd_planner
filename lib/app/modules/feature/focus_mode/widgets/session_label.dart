import 'package:flutter/material.dart';

class SessionLabel extends StatelessWidget {

  const SessionLabel({super.key});

  @override
  Widget build(BuildContext context) {

    return const Text(
      "DESIGNING THE FUTURE",

      style: TextStyle(
        letterSpacing: 2,
        fontWeight: FontWeight.w600,
        color: Color(0xFF5B5563),
      ),
    );
  }
}