import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../core/constants/app_colors.dart';
import '../../routes/app_pages.dart';

class CustomNavbar extends StatelessWidget {

  final int currentIndex;
  final Function(int) onTap;

  const CustomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

@override
Widget build(BuildContext context) {

  return Container(

    color: Colors.transparent,

    child: Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        0,
        20,
        20,
      ),

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(32),

          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withOpacity(.05),

              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

          children: [

            navItem(
              icon: Iconsax.element_4,
              index: 0,
            ),

            navItem(
              icon: Iconsax.calendar,
              index: 1,
            ),

            navItem(
              icon: Iconsax.chart_2,
              index: 2,
            ),

            navItem(
              icon: Iconsax.profile_circle,
              index: 3,
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget navItem({
    required IconData icon,
    required int index,
  }) {

    bool isActive =
        currentIndex == index;

    return GestureDetector(

      onTap: () {

        onTap(index);

        if(index == 0) {
          Get.offAllNamed(
            Routes.DASHBOARD,
          );
        }

        if(index == 1) {
          Get.offAllNamed(
            Routes.CALENDAR,
          );
        }

        if(index == 2) {
          Get.offAllNamed(
            Routes.ANALYTICS,
          );
        }

        if(index == 3) {
          Get.offAllNamed(
            Routes.PROFILE,
          );
        }
      },

      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 250),

        width: 55,
        height: 55,

        decoration: BoxDecoration(

          color: isActive
              ? AppColors.primary
              : Colors.transparent,

          shape: BoxShape.circle,

          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.primary
                        .withOpacity(.22),

                    blurRadius: 18,
                    offset:
                        const Offset(0, 8),
                  ),
                ]
              : [],
        ),

        child: Icon(
          icon,

          color: isActive
              ? Colors.white
              : const Color(0xFF5B5563),

          size: 25,
        ),
      ),
    );
  }
}