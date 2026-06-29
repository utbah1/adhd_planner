import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/register_controller.dart';

import '../../../../routes/app_pages.dart';

import '../../../../shared/widgets/auth_header.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_textfield.dart';
import '../../../../shared/widgets/social_button.dart';

class RegisterView extends GetView<RegisterController> {

  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(

        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(

              children: [

                const SizedBox(height: 20),

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
                        "Selamat Datang",
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
                          "Nama Lengkap",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      CustomTextField(
                        hint: "Alex Abdurrahman",
                        icon: Iconsax.user,
                        controller: controller.fullnameController,
                      ),

                      const SizedBox(height: 20),

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
                        hint: "alex@startup.com",
                        icon: Iconsax.sms,
                        controller: controller.emailController,
                      ),

                      const SizedBox(height: 20),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Kata Sandi",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Obx(
                        () => CustomTextField(
                          hint: "••••••••",
                          icon: Iconsax.lock,
                          controller: controller.passwordController,
                          obscure: controller.hidePassword.value,
                          suffixIcon: IconButton(
                            onPressed: controller.togglePassword,
                            icon: Icon(
                              controller.hidePassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Ulangi Kata Sandi",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      
                      Obx(
                        () => CustomTextField(
                          hint: "••••••••",
                          icon: Iconsax.lock,
                          controller: controller.confirmPasswordController,
                          obscure: controller.hidePassword.value,
                          suffixIcon: IconButton(
                            onPressed: controller.togglePassword,
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
                          text: controller.loading.value
                              ? "Loading..."
                              : "Daftar",
                          onTap: controller.register,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.LOGIN);
                  },

                  child: const Text.rich(
                    TextSpan(
                      text: "Sudah punya akun? ",
                      children: [

                        TextSpan(
                          text: "Masuk Akun",

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