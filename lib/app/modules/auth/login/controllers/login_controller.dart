import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

import '../../../../shared/widgets2/custom_snackbar.dart';

class LoginController extends GetxController {

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final isLoading = false.obs;

  final FirebaseAuth auth =
      FirebaseAuth.instance;

  Future<void> login() async {

    final email =
        emailController.text.trim();

    final password =
        passwordController.text.trim();

    /// VALIDASI
    if (email.isEmpty ||
        password.isEmpty) {

      CustomSnackbar.error(
        title: "Oops",
        message:
            "Email dan password wajib diisi",
      );

      return;
    }

    try {

      isLoading.value = true;

      /// FIREBASE LOGIN
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      CustomSnackbar.success(
        title: "Berhasil",
        message: "Login berhasil",
      );

      Get.offAllNamed(
        Routes.DASHBOARD,
      );

    }
    on FirebaseAuthException catch (e) {

      String message =
          "Terjadi kesalahan";

      if (e.code == 'user-not-found') {
        message =
            "Email tidak ditemukan";
      }

      else if (e.code ==
          'wrong-password') {

        message =
            "Password salah";
      }

      else if (e.code ==
          'invalid-email') {

        message =
            "Format email tidak valid";
      }

      else if (e.code ==
          'invalid-credential') {

        message =
            "Email atau password salah";
      }

      CustomSnackbar.error(
        title: "Login Gagal",
        message: message,
      );
    }

    catch (e) {

      CustomSnackbar.error(
        title: "Error",
        message: e.toString(),
      );
    }

    finally {

      isLoading.value = false;
    }
  }

  @override
  void onClose() {

    emailController.dispose();
    passwordController.dispose();

    super.onClose();
  }
}