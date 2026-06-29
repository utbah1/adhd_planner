import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class CornerWidget extends StatelessWidget {

  final bool reverse;
  final bool bottom;

  const CornerWidget({
    super.key,
    this.reverse = false,
    this.bottom = false,
  });

  @override
  Widget build(BuildContext context) {

    return Transform.rotate(

      angle: bottom
          ? (reverse ? 3.14 : -1.57)
          : (reverse ? 1.57 : 0),

      child: Container(
        width: 55,
        height: 55,

        decoration: BoxDecoration(

          border: Border(

            left: BorderSide(
              color: AppColors.primary,
              width: 5,
            ),

            top: BorderSide(
              color: AppColors.primary,
              width: 5,
            ),
          ),

          borderRadius:
              BorderRadius.circular(14),
        ),
      ),
    );
  }
}