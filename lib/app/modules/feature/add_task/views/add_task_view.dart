import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../routes/app_pages.dart';

import '../../../../shared/widgets2/custom_topbar_feature.dart';

import '../widgets/input_card.dart';
import '../widgets/pro_tip_card.dart';
import '../widgets/title_section.dart';

class AddTaskView extends StatefulWidget {

  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() =>
      _AddTaskViewState();
}

class _AddTaskViewState
    extends State<AddTaskView> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFFF6F4FA),

      appBar: const CustomTopbarFeature(
        title: "Tambah Tugas",
        rightIcon: Iconsax.magic_star,
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                /// TITLE
                const TitleSection(),

                const SizedBox(height: 40),

                /// VOICE INPUT
                GestureDetector(

                  onTap: () {
                    Get.toNamed(
                      Routes.VOICE_INPUT,
                    );
                  },

                  child: const InputCard(
                    icon: Iconsax.microphone,
                    title: "Voice Input",

                    subtitle:
                        "Speak naturally, let\nus organize the\ndetails for you.",

                    active: true,
                  ),
                ),

                const SizedBox(height: 24),

                /// SCANNER
                GestureDetector(

                  onTap: () {
                    Get.toNamed(
                      Routes.IMAGE_INPUT,
                    );
                  },

                  child: const InputCard(
                    icon: Iconsax.scan_barcode,
                    title: "Scanner",

                    subtitle:
                        "Extract text from\nphotos or paper\ndocuments instantly.",
                  ),
                ),

                const SizedBox(height: 24),

                /// MANUAL
                const InputCard(
                  icon: Iconsax.edit_2,
                  title: "Manual\nTyping",

                  subtitle:
                      "Write down your\ntasks with full\nformatting control.",
                ),

                const SizedBox(height: 30),

                /// PRO TIP
                const ProTipCard(),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}