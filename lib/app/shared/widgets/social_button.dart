import 'package:adhd_planner/app/shared/widgets2/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../controller/user_controller.dart';
import '../../data/models/user_model.dart';
import '../../routes/app_pages.dart';
import '../../data/services/auth_service.dart';

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

      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("User tidak ditemukan");
      }

      final idToken = await user.getIdToken();

      if (idToken == null) {
        throw Exception("Gagal mendapatkan ID Token");
      }

      final loginResponse = await AuthService.googleLogin(idToken);

      final userController = Get.find<UserController>();
      userController.setUser(
        UserModel(
          uid: loginResponse.uid,
          fullname: loginResponse.fullname,
          email: loginResponse.email,
          photoUrl: loginResponse.photoUrl,
          streak: loginResponse.streak,
          productivityScore: loginResponse.productivityScore,
          focusTime: 0,
          tasksDone: 0,
        ),
      );

      CustomSnackbar.success(
        title: "Berhasil",
        message: "Berhasil masuk menggunakan Google",
      );

      await Future.delayed(const Duration(milliseconds: 300));

      Get.offAllNamed(Routes.DASHBOARD);

    } 
    catch (e, stackTrace) {
      debugPrint("===== GOOGLE LOGIN ERROR =====");
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());

      CustomSnackbar.error(
        title: "Google Login",
        message: e.toString(),
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