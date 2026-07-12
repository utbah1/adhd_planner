import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../controllers/profile_controller.dart';

class ProfileAvatar extends GetView<ProfileController> {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user = controller.userController.user.value;
      final selected = controller.selectedImage.value;

      return Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.primary,
            width: 5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipOval(
          child: selected != null
              // Tampilkan preview lokal kalau ada foto baru dipilih
              ? Image.file(
                  selected,
                  fit: BoxFit.cover,
                )
              : user != null && user.photoUrl.isNotEmpty
                  ? Image.network(
                      user.photoUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _defaultAvatar(),
                    )
                  : _defaultAvatar(),
        ),
      );
    });
  }

  Widget _defaultAvatar() {
    return Container(
      color: AppColors.primary.withOpacity(0.1),
      child: Center(
        child: Icon(
          Icons.person,
          size: 80,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
