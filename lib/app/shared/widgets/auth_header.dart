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

        Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.contain,
          width: 175,
          height: 175,
        ),

        Text(
          title,
          style: AppTextStyles.heading,
        ),
      ],
    );
  }
}