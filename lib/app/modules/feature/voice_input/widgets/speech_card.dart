import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class SpeechCard extends StatelessWidget {

  const SpeechCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(34),

        boxShadow: [
          BoxShadow(
            color: AppColors.primary
                .withOpacity(.06),

            blurRadius: 16,
            offset: const Offset(0, 10),
          )
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          /// TEXT
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 18,
                height: 1.8,
                color: Color(0xFF2B2238),
              ),

              children: [

                TextSpan(
                  text:
                      '"Remind me to schedule a follow-up call with the design team tomorrow at ',
                ),

                TextSpan(
                  text: '10 AM',

                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                TextSpan(
                  text:
                      ' regarding the new focus mode widgets..."',
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          /// STATUS
          Row(
            children: [

              Container(
                width: 10,
                height: 10,

                decoration:
                    const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 10),

              const Text(
                "LISTENING",

                style: TextStyle(
                  color: AppColors.primary,
                  letterSpacing: 2,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
