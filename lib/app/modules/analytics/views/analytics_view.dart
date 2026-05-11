import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets2/custom_navbar.dart';

class AnalyticsView extends StatefulWidget {

  const AnalyticsView({super.key});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {

  int currentIndex = 2;

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
              crossAxisAlignment: CrossAxisAlignment.start,

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
                              color: AppColors.primary
                                  .withOpacity(.2),
                            ),
                          ),

                          child: const Icon(
                            Iconsax.chart_2,
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

                /// TITLE
                const Text(
                  "Analitik Produktivitas",
                  style: TextStyle(
                    fontSize: 42,
                    height: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  "Lacak Kemajuan dan optimalkan ritme kerja\nAnda.",
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.7,
                    color: Color(0xFF5B5563),
                  ),
                ),

                const SizedBox(height: 40),

                /// MAIN CARD
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,

                        children: [

                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: const [

                              Text(
                                "Efisiensi Anda",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              SizedBox(height: 8),

                              Text(
                                "87%",
                                style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),

                          Container(
                            width: 50,
                            height: 50,

                            decoration: BoxDecoration(
                              color: const Color(0xFFF1E8FF),
                              borderRadius:
                                  BorderRadius.circular(16),
                            ),

                            child: const Icon(
                              Iconsax.flash_1,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 35),

                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.end,

                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,

                        children: [

                          bar(40),
                          bar(60),
                          bar(30),
                          bar(85),
                          bar(55),
                          bar(45),
                          activeBar(100),
                          bar(75),
                          bar(52),
                          bar(68),
                        ],
                      ),

                      const SizedBox(height: 20),

                      const Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,

                        children: [

                          Text("08:00"),

                          Text("12:00"),

                          Text("16:00"),

                          Text("20:00"),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                /// SMALL CARDS
                Row(
                  children: [

                    Expanded(
                      child: statsCard(),
                    ),

                    const SizedBox(width: 20),

                    Expanded(
                      child: weeklyCard(),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                /// DAILY EFFICIENCY
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    const Text(
                      "Efisiensi Harian",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "Lihat Semua",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                efficiencyItem(
                  title: "Deep Work",
                  subtitle: "3 Sesi • Selesai",
                  value: "+45 m",
                  icon: Iconsax.activity,
                  active: true,
                ),

                const SizedBox(height: 18),

                efficiencyItem(
                  title: "Ritual Pagi",
                  subtitle: "1 Sesi • Selesai",
                  value: "15 m",
                  icon: Iconsax.sun_1,
                ),

                const SizedBox(height: 35),

                /// MOTIVATION CARD
                Container(
                  width: double.infinity,
                  height: 220,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),

                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/onboard.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),

                  child: Container(
                    padding: const EdgeInsets.all(24),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),

                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,

                        colors: [
                          AppColors.primary.withOpacity(.8),
                          Colors.transparent,
                        ],
                      ),
                    ),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      mainAxisAlignment: MainAxisAlignment.end,

                      children: const [

                        Text(
                          "Terus Fokus, Alex",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 8),

                        Text(
                          "Anda 12% lebih produktif hari ini daripada minggu lalu.",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
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

  Widget bar(double height) {
    return Container(
      width: 22,
      height: height,

      decoration: BoxDecoration(
        color: const Color(0xFFE5D8FA),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget activeBar(double height) {
    return Container(
      width: 22,
      height: height,

      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),

        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(.25),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
    );
  }

  Widget statsCard() {
    return Container(
      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const Icon(
            Iconsax.scan,
            color: AppColors.primary,
          ),

          const SizedBox(height: 18),

          const Text(
            "Statistik Fokus",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "5.2j",
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "+12% vs Kemarin",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget weeklyCard() {
    return Container(
      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const Icon(
            Iconsax.activity,
            color: AppColors.primary,
          ),

          const SizedBox(height: 18),

          const Text(
            "Target\nMingguan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "24/30",
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Container(
            height: 8,

            decoration: BoxDecoration(
              color: const Color(0xFFE5E5EA),
              borderRadius: BorderRadius.circular(10),
            ),

            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: .75,

              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget efficiencyItem({
    required String title,
    required String subtitle,
    required String value,
    required IconData icon,
    bool active = false,
  }) {

    return Container(
      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),

        border: active
            ? Border.all(
                color: AppColors.primary,
                width: 2,
              )
            : null,
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [

          Row(
            children: [

              Container(
                width: 60,
                height: 60,

                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xFFF1E8FF)
                      : const Color(0xFFE8EEF9),

                  borderRadius:
                      BorderRadius.circular(18),
                ),

                child: Icon(
                  icon,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(width: 18),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF8A8395),
                    ),
                  ),
                ],
              ),
            ],
          ),

          Text(
            value,
            style: TextStyle(
              color: active
                  ? AppColors.primary
                  : const Color(0xFF5B5563),

              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}