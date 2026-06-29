import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ProfileAvatar extends StatelessWidget {

  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 150,
      height: 150,

      decoration: BoxDecoration(
        shape: BoxShape.circle,

        border: Border.all(
          color: AppColors.primary,
          width: 5,
        ),

        image: const DecorationImage(
          image: AssetImage(
            'assets/images/Hilman.png',
          ),
          fit: BoxFit.cover,
        ),

        boxShadow: [
          BoxShadow(
            color:
                AppColors.primary.withOpacity(.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
    );
  }
}