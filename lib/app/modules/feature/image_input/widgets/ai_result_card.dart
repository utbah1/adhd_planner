import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';

class AiResultCard extends StatelessWidget {

  const AiResultCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(28),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(.04),

            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          /// HEADER
          Row(
            children: [

              Container(
                width: 44,
                height: 44,

                decoration: BoxDecoration(
                  color: AppColors.primary
                      .withOpacity(.12),

                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Iconsax.document_text,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(width: 14),

              const Expanded(
                child: Text(
                  "Hasil Pemindai AI",

                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          /// RESULT
          const Text(
            '"Meeting desain UI jam 10 pagi besok,\nrevisi dashboard analytics dan\npersiapkan presentasi."',


            style: TextStyle(
              fontSize: 18,
              height: 1.7,
              color: Color(0xFF4B4257),
            ),
          ),
        ],
      ),
    );
  }
}