import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constants/app_colors.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/onboarding_page.dart';

class OnboardingView
    extends GetView<OnboardingController> {

  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: SafeArea(

        child: Column(

          children: [

            Align(

              alignment: Alignment.centerRight,

              child: TextButton(

                onPressed: controller.skip,

                child: const Text(
                  "Skip",
                  style: TextStyle(color: Colors.white),
                ),

              ),

            ),

            Expanded(

              child: PageView.builder(

                controller:
                    controller.pageController,

                itemCount:
                    controller.pages.length,

                onPageChanged:
                    controller.onPageChanged,

                itemBuilder: (_, index) {

                  final item =
                      controller.pages[index];

                  return OnboardingPage(
                    image: item.image,
                    title: item.title,
                    description:
                        item.description,
                  );

                },

              ),

            ),

            Obx(
              () => AnimatedSmoothIndicator(

                activeIndex:
                    controller.currentPage.value,

                count:
                    controller.pages.length,

                effect: ExpandingDotsEffect(

                  activeDotColor:
                      AppColors.primary,

                  dotColor:
                      AppColors.border,

                  dotHeight: 8,

                  dotWidth: 8,

                  expansionFactor: 3,

                ),

              ),
            ),

            const SizedBox(height: 40),

            Padding(

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 24,
              ),

              child: SizedBox(

                width: double.infinity,

                height: 58,

                child: ElevatedButton(

                  onPressed:
                      controller.nextPage,

                  style:
                      ElevatedButton.styleFrom(

                    backgroundColor:
                        AppColors.primary,

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),

                    ),

                  ),

                    child: Obx(
                    () => Text(
                      controller.currentPage.value == 1
                        ? "Get Started"
                        : "Next",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),

                ),

              ),

            ),

            const SizedBox(height: 30),

          ],

        ),

      ),

    );

  }
}