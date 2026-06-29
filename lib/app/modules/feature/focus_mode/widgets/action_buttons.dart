import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';

import '../controllers/focus_mode_controller.dart';

class ActionButtons extends StatelessWidget {

  final FocusModeController controller;

  const ActionButtons({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [

        /// PLAY / PAUSE
        Expanded(
          child: GestureDetector(

            onTap: () {

              if (controller.isRunning.value) {
                controller.pauseTimer();
              }
              else {
                controller.startTimer();
              }
            },

            child: Obx(
              () => Container(
                height: 80,

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(40),

                  border: Border.all(
                    color:
                        const Color(0xFFD9D1E5),
                  ),
                ),

                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    Icon(
                      controller.isRunning.value
                          ? Iconsax.pause
                          : Iconsax.play,

                      color:
                          const Color(0xFF5B5563),
                    ),

                    const SizedBox(width: 12),

                    Text(
                      controller.isRunning.value
                          ? "Pause"
                          : "Play",

                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight:
                            FontWeight.w600,

                        color:
                            Color(0xFF5B5563),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 14),

        /// END
        Expanded(
          child: GestureDetector(

            onTap: () {
              controller.stopTimer();
            },

            child: Container(
              height: 80,

              decoration: BoxDecoration(

                gradient:
                    const LinearGradient(
                  colors: [
                    AppColors.primary,
                    Color(0xFFA855F7),
                  ],
                ),

                borderRadius:
                    BorderRadius.circular(40),

                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary
                        .withOpacity(.3),

                    blurRadius: 18,
                    offset:
                        const Offset(0, 10),
                  )
                ],
              ),

              child: const Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  Icon(
                    Iconsax.stop,
                    color: Colors.white,
                  ),

                  SizedBox(width: 12),

                  Text(
                    "End",

                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.w600,

                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}