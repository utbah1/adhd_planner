import 'package:adhd_planner/app/shared/widgets2/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../routes/app_pages.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key});

  Future<void> signInWithGoogle() async {
    try {

      final GoogleSignInAccount? googleUser =
          await GoogleSignIn().signIn();

      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      // Notifikasi berhasil
      CustomSnackbar.success(
        title: "Berhasil",
        message: "Berhasil masuk dengan Google",
      );
      Get.toNamed(Routes.DASHBOARD);

    } catch (e) {
      print("Error login Google: $e");

      CustomSnackbar.error(
        title: "Gagal",
        message: "Terjadi kesalahan",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: signInWithGoogle,
      borderRadius: BorderRadius.circular(18),

      child: Container(
        height: 60,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE5E5EA),
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset(
              'assets/images/google_icon.png',
              width: 24,
            ),

            const SizedBox(width: 14),

            const Text(
              "Lanjutkan dengan Google",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}