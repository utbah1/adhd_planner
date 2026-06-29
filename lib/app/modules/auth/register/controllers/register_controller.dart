import 'package:adhd_planner/app/shared/widgets2/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../../routes/app_pages.dart';


class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController =
      TextEditingController();

  var isLoading = false.obs;

  Future<void> register() async {
    try {
      if (emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty) {

        CustomSnackbar.error(
          title: "Error",
          message: "Semua field wajib diisi",
        );

        return;
      }

      if (passwordController.text !=
          confirmPasswordController.text) {

        CustomSnackbar.error(
          title: "Error",
          message: "Password tidak sama",
        );

        return;
      }

      isLoading.value = true;

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      CustomSnackbar.success(
        title: "Berhasil",
        message: "Registrasi berhasil",
      );

      Get.offAllNamed(Routes.DASHBOARD);

    } on FirebaseAuthException catch (e) {

      CustomSnackbar.error(
        title: "Error",
        message:
            e.message ?? "Registrasi gagal",
      );

    } catch (e) {

      CustomSnackbar.error(
        title: "Error",
        message: e.toString(),
      );

    } finally {

      isLoading.value = false;
    }
  }

  @override
  void onClose() {

    emailController.dispose();

    passwordController.dispose();

    confirmPasswordController.dispose();

    super.onClose();
  }
}