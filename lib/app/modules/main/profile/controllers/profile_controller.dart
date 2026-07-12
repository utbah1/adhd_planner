import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../controller/user_controller.dart';
import '../../../../data/services/profile_service.dart';
import '../../../../shared/widgets2/custom_snackbar.dart';

class ProfileController extends GetxController {
  final UserController userController = Get.find<UserController>();

  final isLoading = false.obs;
  final isSaving = false.obs;
  final isUploadingPhoto = false.obs;

  // Personal Info
  final fullnameController = TextEditingController();

  // Foto yang dipilih dari galeri (preview lokal)
  final Rxn<File> selectedImage = Rxn<File>();

  // Security
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final hideCurrentPassword = true.obs;
  final hideNewPassword = true.obs;
  final hideConfirmPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  // Load profile

  Future<void> loadProfile() async {
    try {
      isLoading.value = true;
      final user = await ProfileService.getProfile();
      userController.setUser(user);
      fullnameController.text = user.fullname;
    } catch (e) {
      CustomSnackbar.error(
        title: "Error",
        message: e.toString().replaceFirst("Exception: ", ""),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshProfile() async => loadProfile();

  // Pilih foto dari galeri

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (picked != null) {
      selectedImage.value = File(picked.path);
    }
  }

  // Simpan perubahan personal info

  Future<void> updatePersonalInfo() async {
    final name = fullnameController.text.trim();

    if (name.isEmpty) {
      CustomSnackbar.error(
        title: "Personal Info",
        message: "Nama tidak boleh kosong",
      );
      return;
    }

    try {
      isSaving.value = true;

      String? newPhotoUrl;

      // Upload foto ke backend dulu kalau ada yang dipilih
      if (selectedImage.value != null) {
        isUploadingPhoto.value = true;
        newPhotoUrl = await ProfileService.uploadPhoto(selectedImage.value!);
        isUploadingPhoto.value = false;
      }

      // Update nama (dan photo_url kalau ada yang baru)
      final updated = await ProfileService.updateProfile(
        fullname: name,
        photoUrl: newPhotoUrl,
      );

      userController.setUser(updated);
      selectedImage.value = null;

      CustomSnackbar.success(
        title: "Berhasil",
        message: "Profil berhasil diperbarui",
      );

      Get.back();
    } catch (e) {
      isUploadingPhoto.value = false;
      CustomSnackbar.error(
        title: "Gagal",
        message: e.toString().replaceFirst("Exception: ", ""),
      );
    } finally {
      isSaving.value = false;
    }
  }

  // Ganti password─

  Future<void> changePassword() async {
    final current = currentPasswordController.text;
    final newPass = newPasswordController.text;
    final confirm = confirmPasswordController.text;

    if (current.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      CustomSnackbar.error(
        title: "Security",
        message: "Semua field wajib diisi",
      );
      return;
    }

    if (newPass.length < 6) {
      CustomSnackbar.error(
        title: "Security",
        message: "Password baru minimal 6 karakter",
      );
      return;
    }

    if (newPass != confirm) {
      CustomSnackbar.error(
        title: "Security",
        message: "Konfirmasi password tidak cocok",
      );
      return;
    }

    try {
      isSaving.value = true;

      await ProfileService.changePassword(
        currentPassword: current,
        newPassword: newPass,
      );

      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();

      CustomSnackbar.success(
        title: "Berhasil",
        message: "Password berhasil diubah",
      );

      Get.back();
    } catch (e) {
      CustomSnackbar.error(
        title: "Gagal",
        message: e.toString().replaceFirst("Exception: ", ""),
      );
    } finally {
      isSaving.value = false;
    }
  }

  // Helpers

  void initPersonalInfoControllers() {
    final user = userController.currentUser;
    if (user != null) {
      fullnameController.text = user.fullname;
    }
    selectedImage.value = null;
  }

  void clearSecurityControllers() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    hideCurrentPassword.value = true;
    hideNewPassword.value = true;
    hideConfirmPassword.value = true;
  }

  @override
  void onClose() {
    fullnameController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
