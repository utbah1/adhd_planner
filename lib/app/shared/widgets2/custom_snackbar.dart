import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../core/constants/app_colors.dart';

class CustomSnackbar {

  static void success({
    required String title,
    required String message,
  }) {

    Get.snackbar(

      title,
      message,

      snackPosition:
          SnackPosition.BOTTOM,

      backgroundColor:
          Colors.white.withOpacity(.96),

      colorText:
          const Color(0xFF2B2238),

      borderRadius: 24,

      margin: const EdgeInsets.all(20),

      padding:
          const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),

      boxShadows: [
        BoxShadow(
          color:
              Colors.black.withOpacity(.08),

          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],

      icon: Container(
        width: 42,
        height: 42,

        decoration: BoxDecoration(
          color: AppColors.primary
              .withOpacity(.12),

          shape: BoxShape.circle,
        ),

        child: const Icon(
          Iconsax.tick_circle,
          color: AppColors.primary,
        ),
      ),

      shouldIconPulse: false,

      duration:
          const Duration(seconds: 3),

      animationDuration:
          const Duration(
        milliseconds: 400,
      ),
    );
  }

  static void error({
    required String title,
    required String message,
  }) {

    Get.snackbar(

      title,
      message,

      snackPosition:
          SnackPosition.BOTTOM,

      backgroundColor:
          Colors.white.withOpacity(.96),

      colorText:
          const Color(0xFF2B2238),

      borderRadius: 24,

      margin: const EdgeInsets.all(20),

      padding:
          const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),

      boxShadows: [
        BoxShadow(
          color:
              Colors.black.withOpacity(.08),

          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],

      icon: Container(
        width: 42,
        height: 42,

        decoration: BoxDecoration(
          color: Colors.red
              .withOpacity(.12),

          shape: BoxShape.circle,
        ),

        child: const Icon(
          Iconsax.close_circle,
          color: Colors.red,
        ),
      ),

      shouldIconPulse: false,

      duration:
          const Duration(seconds: 3),

      animationDuration:
          const Duration(
        milliseconds: 400,
      ),
    );
  }
}