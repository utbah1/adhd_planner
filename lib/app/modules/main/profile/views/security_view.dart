import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_textfield.dart';
import '../controllers/profile_controller.dart';

class SecurityView extends GetView<ProfileController> {
  const SecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.06),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              Iconsax.arrow_left,
              color: Color(0xFF2B2238),
              size: 20,
            ),
          ),
        ),
        title: const Text(
          "Security",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2B2238),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              /// Info box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(.08),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.shield_tick,
                      color: AppColors.primary,
                      size: 22,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        "Password minimal 6 karakter dan pastikan konfirmasi password cocok.",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6A6274),
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              /// Current Password
              const Text(
                "Password Saat Ini",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6A6274),
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => CustomTextField(
                  hint: "Masukkan password saat ini",
                  icon: Iconsax.lock,
                  controller: controller.currentPasswordController,
                  obscure: controller.hideCurrentPassword.value,
                  suffixIcon: GestureDetector(
                    onTap: () => controller.hideCurrentPassword.toggle(),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(
                        controller.hideCurrentPassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye,
                        color: AppColors.textGrey,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// New Password
              const Text(
                "Password Baru",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6A6274),
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => CustomTextField(
                  hint: "Masukkan password baru",
                  icon: Iconsax.key,
                  controller: controller.newPasswordController,
                  obscure: controller.hideNewPassword.value,
                  suffixIcon: GestureDetector(
                    onTap: () => controller.hideNewPassword.toggle(),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(
                        controller.hideNewPassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye,
                        color: AppColors.textGrey,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// Confirm Password
              const Text(
                "Konfirmasi Password Baru",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6A6274),
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => CustomTextField(
                  hint: "Ulangi password baru",
                  icon: Iconsax.key,
                  controller: controller.confirmPasswordController,
                  obscure: controller.hideConfirmPassword.value,
                  suffixIcon: GestureDetector(
                    onTap: () => controller.hideConfirmPassword.toggle(),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(
                        controller.hideConfirmPassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye,
                        color: AppColors.textGrey,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              /// Save button
              Obx(
                () => CustomButton(
                  text: "Ubah Password",
                  loading: controller.isSaving.value,
                  onTap: controller.changePassword,
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
