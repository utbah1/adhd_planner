import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets2/custom_topbar_feature.dart';

import '../controllers/focus_mode_controller.dart';

import '../widgets/action_buttons.dart';
import '../widgets/focus_timer_circle.dart';
import '../widgets/motivation_card.dart';
import '../widgets/session_label.dart';

class FocusModeView
    extends GetView<FocusModeController> {

  const FocusModeView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFFF6F4FA),

      appBar: const CustomTopbarFeature(
        title: "Deep Focus Session",
        rightIcon: Iconsax.flash_1,
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              children: [

                const SizedBox(height: 10),

                /// LABEL
                const SessionLabel(),

                const SizedBox(height: 20),

                /// TIMER
                FocusTimerCircle(
                  controller: controller,
                ),

                const SizedBox(height: 30),

                /// MOTIVATION
                const MotivationCard(),

                const SizedBox(height: 30),

                /// ACTIONS
                ActionButtons(
                  controller: controller,
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}