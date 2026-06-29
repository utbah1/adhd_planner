import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import '../../../../data/services/auth_service.dart';
import '../../../../data/services/session_service.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/widgets2/custom_navbar.dart';
import '../../../../shared/widgets2/custom_topbar.dart';

import '../widgets/account_section.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/profile_header.dart';
import '../widgets/settings_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/setting_item.dart';

class ProfileView extends StatefulWidget {

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() =>
      _ProfileViewState();
}

class _ProfileViewState
    extends State<ProfileView> {

  int currentIndex = 3;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      extendBody: true,

      backgroundColor: const Color(0xFFF6F4FA),

      appBar: CustomTopbar(
        title: "Good morning, Alex",
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

        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center,

              children: [
              
                /// AVATAR
                const ProfileAvatar(),

                const SizedBox(height: 30),

                /// HEADER
                const ProfileHeader(),

                const SizedBox(height: 40),

                /// STATS
                Row(
                  children: [

                    const Expanded(
                      child: ProfileStatCard(
                        icon: Iconsax.timer_1,
                        value: "78h",
                        title: "Focus Time",
                      ),
                    ),

                    const SizedBox(width: 18),

                    const Expanded(
                      child: ProfileStatCard(
                        icon: Iconsax.tick_circle,
                        value: "124",
                        title: "Tasks Done",
                      ),
                    ),

                    const SizedBox(width: 18),

                    const Expanded(
                      child: ProfileStatCard(
                        icon: Iconsax.flash_1,
                        value: "12",
                        title: "Day Streak",
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                /// ACCOUNT
                const AccountSection(),

                const SizedBox(height: 20),

                /// ACCOUNT CARD
                SettingsCard(
                  items: [

                    SettingsItemData(
                      icon: Iconsax.user,
                      title: "Personal Info",
                    ),

                    SettingsItemData(
                      icon: Iconsax.shield,
                      title: "Security",
                    ),
                  ],
                ),

                const SizedBox(height: 30),

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
                              borderRadius:
                                  BorderRadius.circular(24),
                            ),

                            title: const Text(
                              "Logout",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            content: const Text(
                              "Apakah kamu yakin ingin keluar dari akun?",
                              style: TextStyle(
                                height: 1.5,
                              ),
                            ),

                            actions: [

                              /// CANCEL
                              TextButton(

                                onPressed: () {
                                  Get.back();
                                },

                                child: const Text(
                                  "Batal",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),

                              /// LOGOUT
                              ElevatedButton(

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,

                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(14),
                                  ),
                                ),

                                onPressed: () async {

                                  Get.back();

                                  await AuthService.logout();

                                  Get.offAllNamed(
                                    Routes.LOGIN,
                                  );

                                },

                                child: const Text(
                                  "Logout",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
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
                  "v2.4.0 (Build 892)",
                  style: TextStyle(
                    color: Color(0xFFB0A8BA),
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