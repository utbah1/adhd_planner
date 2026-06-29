import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/auth/login_request.dart';
import '../../../../data/services/auth_service.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/widgets2/custom_snackbar.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final loading = false.obs;

  final hidePassword = true.obs;

  void togglePassword() {
    hidePassword.toggle();
  }

  Future<void> login() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (emailController.text.trim().isEmpty) {
      CustomSnackbar.error(
        title: "Login",
        message: "Email wajib diisi",
      );
      return;
    }

    if (passwordController.text.isEmpty) {
      CustomSnackbar.error(
        title: "Login",
        message: "Password wajib diisi",
      );
      return;
    }

    try {
      loading.value = true;

      final response = await AuthService.login(
        LoginRequest(
          email: emailController.text.trim(),
          password: passwordController.text,
        ),
      );

      debugPrint(response.accessToken);

      CustomSnackbar.success(
        title: "Login Berhasil",
        message: "Selamat datang kembali!",
      );

      Get.offAllNamed(
        Routes.DASHBOARD,
      );

    } catch (e) {
      CustomSnackbar.error(
        title: "Login Gagal",
        message: e.toString(),
      );
    } finally {
      loading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}