import 'package:flutter/material.dart';

class AccountSection extends StatelessWidget {

  const AccountSection({super.key});

  @override
  Widget build(BuildContext context) {

    return const Align(
      alignment: Alignment.centerLeft,

      child: Text(
        "Account",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF6A6274),
        ),
      ),
    );
  }
}