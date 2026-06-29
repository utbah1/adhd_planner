import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/login_controller.dart';

import '../../../../routes/app_pages.dart';

import '../../../../shared/widgets/auth_header.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_textfield.dart';
import '../../../../shared/widgets/social_button.dart';

class LoginView extends StatefulWidget {

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState
    extends State<LoginView> {

  final controller =
      Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(

        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(

              children: [

                const AuthHeader(
                  title: "Daily Planner",
                ),

                Container(
                  padding: const EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F8FB),
                    borderRadius: BorderRadius.circular(36),
                  ),

                  child: Column(

                    children: [

                    const Text(
                      "Selamat Datang Kembali",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                      const SizedBox(height: 10),

                      const Text(
                        "Lanjutkan perjalanan fokus Anda",
                      ),

                      const SizedBox(height: 35),

                      const SocialButton(),

                      const SizedBox(height: 30),

                      const Row(
                        children: [

                          Expanded(child: Divider()),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text("atau email"),
                          ),

                          Expanded(child: Divider()),
                        ],
                      ),

                      const SizedBox(height: 30),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Alamat Email",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      CustomTextField(
                        controller: controller.emailController,
                        hint: "alex@startup.com",
                        icon: Iconsax.sms,
                      ),

                      const SizedBox(height: 20),

                      const Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,

                        children: [

                          Text(
                            "Kata Sandi",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          Text(
                            "Lupa?",
                            style: TextStyle(
                              color: Color(0xFF8B3DFF),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Obx(
                        () => CustomTextField(
                          controller:
                              controller.passwordController,

                          hint: "••••••••",

                          icon: Iconsax.lock,

                          obscure:
                              controller.hidePassword.value,

                          suffixIcon: IconButton(
                            onPressed:
                                controller.togglePassword,

                            icon: Icon(
                              controller.hidePassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      Obx(
                        () => CustomButton(
                          text: "Masuk",

                          loading: controller.loading.value,

                          onTap: controller.login,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.REGISTER);
                  },

                  child: const Text.rich(
                    TextSpan(
                      text: "Belum punya akun? ",
                      children: [

                        TextSpan(
                          text: "Daftar Akun Baru",

                          style: TextStyle(
                            color: Color(0xFF8B3DFF),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}