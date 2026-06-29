import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

import 'corner_widget.dart';

class ScannerOverlay
    extends StatelessWidget {

  const ScannerOverlay({super.key});

  @override
  Widget build(BuildContext context) {

    return Positioned.fill(

      child: Padding(
        padding: const EdgeInsets.all(40),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

          children: [

            /// TOP
            const Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

              children: [

                CornerWidget(),

                CornerWidget(
                  reverse: true,
                ),
              ],
            ),

            /// LABEL
            Container(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 26,
                vertical: 14,
              ),

              decoration: BoxDecoration(
                color: AppColors.primary
                    .withOpacity(.25),

                borderRadius:
                    BorderRadius.circular(30),
              ),

              child: const Text(
                "Ekstraksi Teks Pintar...",

                style: TextStyle(
                  color: Colors.white,
                  fontWeight:
                      FontWeight.bold,

                  letterSpacing: 1,
                ),
              ),
            ),

            /// BOTTOM
            const Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

              children: [

                CornerWidget(
                  bottom: true,
                ),

                CornerWidget(
                  reverse: true,
                  bottom: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}