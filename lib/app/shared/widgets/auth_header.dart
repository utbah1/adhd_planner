import 'package:flutter/material.dart';

import '../../core/constants/app_text_styles.dart';

class AuthHeader extends StatelessWidget {

  final String title;

  const AuthHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        Container(
          width: 90,
          height: 90,

          decoration: BoxDecoration(
            color: const Color(0xFF8B3DFF),
            borderRadius: BorderRadius.circular(50),
          ),

          child: const Icon(
            Icons.psychology_alt,
            color: Colors.white,
            size: 40,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          title,
          style: AppTextStyles.heading,
        ),
      ],
    );
  }
}