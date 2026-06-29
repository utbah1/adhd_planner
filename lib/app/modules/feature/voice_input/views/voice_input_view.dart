import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../shared/widgets2/custom_topbar_feature.dart';

import '../widgets/bottom_actions.dart';
import '../widgets/mic_button.dart';
///import '../widgets/quick_actions_section.dart';
import '../widgets/speech_card.dart';
import '../widgets/waveform_section.dart';

class VoiceInputView extends StatefulWidget {

  const VoiceInputView({super.key});

  @override
  State<VoiceInputView> createState() =>
      _VoiceInputViewState();
}

class _VoiceInputViewState
    extends State<VoiceInputView> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFFF6F4FA),

      appBar: const CustomTopbarFeature(
        title: "Pengenal Suara AI",
        rightIcon: Iconsax.command,
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              children: [

                /// WAVEFORM
                const WaveformSection(),

                const SizedBox(height: 30),

                /// SPEECH
                const SpeechCard(),

                const SizedBox(height: 30),

                /// MIC
                const MicButton(),

                const SizedBox(height: 30),

                /// QUICK ACTIONS
                ///const QuickActionsSection(),

                ///const SizedBox(height: 60),

                /// LABEL
                const Text(
                  "TAP TO STOP RECORDING",

                  style: TextStyle(
                    letterSpacing: 2,
                    color: Color(0xFF5B5563),
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 30),

                /// ACTIONS
                const BottomActions(),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}