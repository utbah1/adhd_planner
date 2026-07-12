import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileHeader extends GetView<ProfileController> {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user = controller.userController.user.value;

      return Column(
        children: [
          Text(
            user?.fullname.isNotEmpty == true
                ? user!.fullname
                : "Unknown User",
            style: const TextStyle(
              fontSize: 29,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            user?.email ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17,
              color: Color(0xFF6A6274),
            ),
          ),
        ],
      );
    });
  }
}