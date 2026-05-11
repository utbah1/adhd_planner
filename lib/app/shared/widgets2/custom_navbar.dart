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
      margin: const EdgeInsets.all(20),

      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

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
    );
  }

  Widget navItem({
    required IconData icon,
    required int index,
  }) {

    bool isActive = currentIndex == index;

    return GestureDetector(

      onTap: () {

        onTap(index);

        /// HOME
        if(index == 0) {
          Get.offAllNamed(Routes.HOME);
        }

        /// CALENDAR
        if(index == 1) {
          Get.offAllNamed(Routes.CALENDAR);
        }

        /// ANALYTICS
        if(index == 2) {
          Get.offAllNamed(Routes.ANALYTICS);
        }

        /// PROFILE
        if(index == 3) {
          Get.offAllNamed(Routes.PROFILE);
        }

      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

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
                    color: AppColors.primary.withOpacity(.25),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  )
                ]
              : [],
        ),

        child: Icon(
          icon,

          color: isActive
              ? Colors.white
              : const Color(0xFF5B5563),

          size: 26,
        ),
      ),
    );
  }
}