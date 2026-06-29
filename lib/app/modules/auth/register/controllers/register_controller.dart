import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/auth/register_request.dart';
import '../../../../data/services/auth_service.dart';
import '../../../../shared/widgets2/custom_snackbar.dart';
import '../widgets/verify_otp_dialog.dart';

class RegisterController extends GetxController {
  final fullnameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController =
      TextEditingController();

  final hidePassword = true.obs;

  final loading = false.obs;

  void togglePassword() {
    hidePassword.toggle();
  }

  Future<void> register() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final fullname =
        fullnameController.text.trim();

    final email =
        emailController.text.trim();

    final password =
        passwordController.text;

    final confirmPassword =
        confirmPasswordController.text;

    /// Fullname
    if (fullname.isEmpty) {
      CustomSnackbar.error(
        title: "Register",
        message: "Nama lengkap wajib diisi",
      );
      return;
    }

    /// Email
    if (email.isEmpty) {
      CustomSnackbar.error(
        title: "Register",
        message: "Email wajib diisi",
      );
      return;
    }

    if (!GetUtils.isEmail(email)) {
      CustomSnackbar.error(
        title: "Register",
        message: "Format email tidak valid",
      );
      return;
    }

    /// Password
    if (password.isEmpty) {
      CustomSnackbar.error(
        title: "Register",
        message: "Password wajib diisi",
      );
      return;
    }

    if (password.length < 6) {
      CustomSnackbar.error(
        title: "Register",
        message:
            "Password minimal 6 karakter",
      );
      return;
    }

    /// Confirm Password
    if (confirmPassword.isEmpty) {
      CustomSnackbar.error(
        title: "Register",
        message:
            "Konfirmasi password wajib diisi",
      );
      return;
    }

    if (password != confirmPassword) {
      CustomSnackbar.error(
        title: "Register",
        message:
            "Konfirmasi password tidak sama",
      );
      return;
    }

    try {
      loading.value = true;

      await AuthService.register(
        RegisterRequest(
          fullname: fullname,
          email: email,
          password: password,
        ),
      );

      CustomSnackbar.success(
        title: "Register Berhasil",
        message:
            "Kode OTP berhasil dikirim ke email Anda.",
      );

      Get.dialog(
        VerifyOtpDialog(
          email: email,
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      CustomSnackbar.error(
        title: "Register Gagal",
        message: e.toString(),
      );
    } finally {
      loading.value = false;
    }
  }

  @override
  void onClose() {
    fullnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.onClose();
  }
}