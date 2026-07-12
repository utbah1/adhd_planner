import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/storage/onboarding_storage.dart';
import '../../../../routes/app_pages.dart';
import '../models/onboarding_item.dart';


class OnboardingController extends GetxController {
  final PageController pageController =
      PageController();

  final currentPage = 0.obs;

  final pages = const [

    OnboardingItem(
      image: "assets/images/onboarding.jpeg",
      title: "Plan Better,\nFocus Smarter",
      description:
          "Organize your daily tasks, stay focused with AI assistance, and build productive habits effortlessly.",
    ),

    OnboardingItem(
      image: "assets/images/onboarding2.jpeg",
      title: "Everything You Need\nin One App",
      description:
          "Smart Tasks, Focus Mode, AI Assistant, Voice Notes, OCR Scanner, and Productivity Analytics.",
    ),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  Future<void> nextPage() async {
    if (currentPage.value ==
        pages.length - 1) {

      await OnboardingStorage.complete();

      Get.offAllNamed(
        Routes.LOGIN,
      );

      return;
    }

    pageController.nextPage(
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeInOut,
    );
  }

  Future<void> skip() async {
    await OnboardingStorage.complete();

    Get.offAllNamed(
      Routes.LOGIN,
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}