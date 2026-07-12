import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_textfield.dart';
import '../controllers/profile_controller.dart';

class PersonalInfoView extends GetView<ProfileController> {
  const PersonalInfoView({super.key});

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
          "Personal Info",
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
          padding: const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 24),
          child: Column(
            children: [
              const SizedBox(height: 12),

              /// Avatar picker
              GestureDetector(
                onTap: controller.pickImageFromGallery,
                child: Obx(() {
                  final selected = controller.selectedImage.value;
                  final user = controller.userController.user.value;

                  return Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      /// Avatar circle
                      Obx(() {
                        final isUploading =
                            controller.isUploadingPhoto.value;

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
                            child: isUploading
                                ? Container(
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : selected != null
                                    // Preview foto yang baru dipilih
                                    ? Image.file(
                                        selected,
                                        fit: BoxFit.cover,
                                      )
                                    : user != null &&
                                            user.photoUrl.isNotEmpty
                                        // Foto dari server
                                        ? Image.network(
                                            user.photoUrl,
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) =>
                                                _defaultAvatar(),
                                          )
                                        : _defaultAvatar(),
                          ),
                        );
                      }),

                      /// Camera badge
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(.4),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Iconsax.camera,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  );
                }),
              ),

              const SizedBox(height: 12),

              /// Tap hint
              Obx(() {
                final selected = controller.selectedImage.value;
                return Text(
                  selected != null
                      ? "Foto baru dipilih — tap untuk ganti"
                      : "Tap foto untuk pilih dari galeri",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9D97A8),
                  ),
                  textAlign: TextAlign.center,
                );
              }),

              const SizedBox(height: 36),

              /// Nama
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Nama Lengkap",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6A6274),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: "Masukkan nama lengkap",
                icon: Iconsax.user,
                controller: controller.fullnameController,
              ),

              const SizedBox(height: 24),

              /// Email (read-only)
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6A6274),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Obx(() {
                final user = controller.userController.user.value;
                return CustomTextField(
                  hint: "Email",
                  icon: Iconsax.sms,
                  controller:
                      TextEditingController(text: user?.email ?? ""),
                  enabled: false,
                );
              }),
              const SizedBox(height: 6),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email tidak dapat diubah",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9D97A8),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              /// Simpan
              Obx(
                () => CustomButton(
                  text: controller.isUploadingPhoto.value
                      ? "Mengupload foto..."
                      : "Simpan Perubahan",
                  loading: controller.isSaving.value ||
                      controller.isUploadingPhoto.value,
                  onTap: controller.updatePersonalInfo,
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _defaultAvatar() {
    return Image.asset(
      'assets/images/Hilman.png',
      fit: BoxFit.cover,
    );
  }
}
