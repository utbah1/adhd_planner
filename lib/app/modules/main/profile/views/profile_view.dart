import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import '../../../../data/services/auth_service.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/widgets2/custom_navbar.dart';
import '../../../../shared/widgets2/custom_topbar.dart';

import '../controllers/profile_controller.dart';
import '../widgets/account_section.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/profile_header.dart';
import '../widgets/settings_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/setting_item.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int currentIndex = 3;

  String _formatFocusTime(int minutes) {
    final h = minutes ~/ 60;
    final m = minutes % 60;
    if (h == 0) return "${m}m";
    return "${h}h ${m}m";
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF6F4FA),
      appBar: CustomTopbar(
        icon: Iconsax.profile_circle,
      ),
      bottomNavigationBar: CustomNavbar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.refreshProfile,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 7, bottom: 24),
              child: Obx(() {
                final user = controller.userController.user.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// AVATAR
                    const ProfileAvatar(),

                    const SizedBox(height: 7),

                    /// HEADER
                    const ProfileHeader(),

                    const SizedBox(height: 20),

                    /// STATS - Real data dari server
                    SizedBox(
                      height: 164,
                      child: Row(
                      children: [
                        Expanded(
                        child: ProfileStatCard(
                          icon: Iconsax.timer_1,
                          value: user != null
                            ? _formatFocusTime(user.focusTime)
                            : "—",
                          title: "Focus Time",
                        ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                        child: ProfileStatCard(
                          icon: Iconsax.tick_circle,
                          value: user != null
                            ? "${user.tasksDone}"
                            : "—",
                          title: "Tasks Done",
                        ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                        child: ProfileStatCard(
                          icon: Iconsax.flash_1,
                          value: user != null
                            ? "${user.streak}"
                            : "—",
                          title: "Day Streak",
                        ),
                        ),
                      ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// ACCOUNT
                    const AccountSection(),

                    const SizedBox(height: 10),

                    /// ACCOUNT CARD
                    SettingsCard(
                      items: [
                        SettingsItemData(
                          icon: Iconsax.user,
                          title: "Personal Info",
                          onTap: () {
                            controller.initPersonalInfoControllers();
                            Get.toNamed(Routes.PERSONAL_INFO);
                          },
                        ),
                        SettingsItemData(
                          icon: Iconsax.shield,
                          title: "Security",
                          onTap: () {
                            controller.clearSecurityControllers();
                            Get.toNamed(Routes.SECURITY);
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// OTHER CARD
                    SettingsCard(
                      items: [
                        SettingsItemData(
                          icon: Iconsax.message_question,
                          title: "Help Center",
                        ),
                        SettingsItemData(
                          icon: Iconsax.security_safe,
                          title: "Privacy Policy",
                        ),
                        SettingsItemData(
                          icon: Iconsax.logout,
                          title: "Logout",
                          danger: true,
                          onTap: () {
                            Get.dialog(
                              AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                title: const Text(
                                  "Logout",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: const Text(
                                  "Apakah kamu yakin ingin keluar dari akun?",
                                  style: TextStyle(height: 1.5),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: const Text(
                                      "Batal",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    onPressed: () async {
                                      Get.back();
                                      await AuthService.logout();
                                      Get.offAllNamed(Routes.LOGIN);
                                    },
                                    child: const Text(
                                      "Logout",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 50),

                    const Text(
                      "v1.0.2 (Build 102)",
                      style: TextStyle(
                        color: Color(0xFFB0A8BA),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
