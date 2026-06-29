import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets2/custom_navbar.dart';
import '../../../../shared/widgets2/custom_topbar.dart';

import '../widgets/analytics_chart_card.dart';
import '../widgets/efficiency_item.dart';
import '../widgets/focus_stats_card.dart';
import '../widgets/motivation_card.dart';
import '../widgets/page_header.dart';
import '../widgets/weekly_target_card.dart';

class AnalyticsView extends StatefulWidget {

  const AnalyticsView({super.key});

  @override
  State<AnalyticsView> createState() =>
      _AnalyticsViewState();
}

class _AnalyticsViewState
    extends State<AnalyticsView> {

  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      extendBody: true,

      backgroundColor: const Color(0xFFF6F4FA),

      appBar: CustomTopbar(
        title: "Good morning, Alex",
        icon: Iconsax.chart_2,
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
            padding: const EdgeInsets.all(15),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                const PageHeader(),

                const SizedBox(height: 40),

                const AnalyticsChartCard(),

                const SizedBox(height: 24),

                Row(
                  children: [

                    const Expanded(
                      child: FocusStatsCard(),
                    ),

                    const SizedBox(width: 20),

                    const Expanded(
                      child: WeeklyTargetCard(),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    const Text(
                      "Efisiensi Harian",
                      style: TextStyle(
                        fontSize: 30,
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

                const EfficiencyItem(
                  title: "Deep Work",
                  subtitle: "3 Sesi • Selesai",
                  value: "+45 m",
                  icon: Iconsax.activity,
                  active: true,
                ),

                const SizedBox(height: 18),

                const EfficiencyItem(
                  title: "Ritual Pagi",
                  subtitle: "1 Sesi • Selesai",
                  value: "15 m",
                  icon: Iconsax.sun_1,
                ),

                const SizedBox(height: 35),

                const MotivationCard(),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}