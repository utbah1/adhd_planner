import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../data/services/session_service.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

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

                Image.asset(
                  'assets/images/onboard.png',
                  height: MediaQuery.of(context).size.height * 0.32,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 40),

                Text(
                  "Focus on what\nmatters.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading,
                ),

                const SizedBox(height: 20),

                Text(
                  "Quiet the noise and find your flow state\nwith a workspace designed for your\nbrain.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.subtitle,
                ),

                const SizedBox(height: 35),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      width: 35,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    const SizedBox(width: 6),

                    circle(),

                    const SizedBox(width: 6),

                    circle(),
                  ],
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),

                CustomButton(
                  text: "Get Started →",
                  onTap: () async {

                    await SessionService.finishOnboarding();

                    Get.offAllNamed(
                      Routes.REGISTER,
                    );

                  },
                ),

                const SizedBox(height: 25),

                GestureDetector(
                  onTap: () async {

                    await SessionService.finishOnboarding();
                    
                    Get.offAllNamed(
                      Routes.LOGIN,
                    );
                  },
                  child: const Text(
                    "Already have an account? Sign In",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget circle() {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: Color(0xFFDADADA),
        shape: BoxShape.circle,
      ),
    );
  }
}