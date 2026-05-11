import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets2/custom_navbar.dart';

class ProfileView extends StatefulWidget {

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  int currentIndex = 3;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF6F4FA),

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
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [

                /// TOP BAR
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    Row(
                      children: [

                        Container(
                          width: 50,
                          height: 50,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(18),

                            border: Border.all(
                              color:
                                  AppColors.primary.withOpacity(.2),
                            ),
                          ),

                          child: const Icon(
                            Iconsax.profile_circle,
                            color: AppColors.primary,
                          ),
                        ),

                        const SizedBox(width: 16),

                        const Text(
                          "Good morning, Alex",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                /// PROFILE IMAGE
                Stack(
                  clipBehavior: Clip.none,

                  children: [

                    Container(
                      width: 150,
                      height: 150,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        border: Border.all(
                          color: AppColors.primary,
                          width: 5,
                        ),

                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/Hilman.png',
                          ),
                          fit: BoxFit.cover,
                        ),

                        boxShadow: [
                          BoxShadow(
                            color:
                                AppColors.primary.withOpacity(.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                const Text(
                  "Hilmann Bin Fathurrahman",
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Mindful Productivity Enthusiast",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF6A6274),
                  ),
                ),

                const SizedBox(height: 40),

                /// STATS
                Row(
                  children: [

                    Expanded(
                      child: statCard(
                        icon: Iconsax.timer_1,
                        value: "78h",
                        title: "Focus Time",
                      ),
                    ),

                    const SizedBox(width: 18),

                    Expanded(
                      child: statCard(
                        icon: Iconsax.tick_circle,
                        value: "124",
                        title: "Tasks Done",
                      ),
                    ),

                    const SizedBox(width: 18),

                    Expanded(
                      child: statCard(
                        icon: Iconsax.flash_1,
                        value: "12",
                        title: "Day Streak",
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                /// ACCOUNT TITLE
                const Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    "Account",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6A6274),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// ACCOUNT CARD
                settingsCard(
                  items: [

                    settingItem(
                      icon: Iconsax.user,
                      title: "Personal Info",
                    ),

                    settingItem(
                      icon: Iconsax.shield,
                      title: "Security",
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                /// OTHER CARD
                settingsCard(
                  items: [

                    settingItem(
                      icon: Iconsax.message_question,
                      title: "Help Center",
                    ),

                    settingItem(
                      icon: Iconsax.security_safe,
                      title: "Privacy Policy",
                    ),

                    settingItem(
                      icon: Iconsax.logout,
                      title: "Logout",
                      danger: true,
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

                const SizedBox(height: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget statCard({
    required IconData icon,
    required String value,
    required String title,
  }) {

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 24,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),

      child: Column(
        children: [

          Icon(
            icon,
            color: AppColors.primary,
            size: 28,
          ),

          const SizedBox(height: 18),

          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF6A6274),
            ),
          ),
        ],
      ),
    );
  }

  Widget settingsCard({
    required List<Widget> items,
  }) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),

      child: Column(
        children: items,
      ),
    );
  }

  Widget settingItem({
    required IconData icon,
    required String title,
    bool danger = false,
  }) {

    return ListTile(

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 8,
      ),

      leading: Icon(
        icon,
        color: danger
            ? Colors.red
            : const Color(0xFF5B5563),
      ),

      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: danger
              ? Colors.red
              : const Color(0xFF2B2238),
        ),
      ),

      trailing: Icon(
        Iconsax.arrow_right_3,
        color: danger
            ? Colors.red
            : const Color(0xFF8A8395),
      ),
    );
  }
}