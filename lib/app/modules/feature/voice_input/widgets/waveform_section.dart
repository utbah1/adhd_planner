import 'package:flutter/material.dart';

import 'voice_wave.dart';

class WaveformSection
    extends StatelessWidget {

  const WaveformSection({super.key});

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center,

      crossAxisAlignment:
          CrossAxisAlignment.end,

      children: const [

        VoiceWave(height: 50),

        VoiceWave(height: 90),

        VoiceWave(
          height: 140,
          active: true,
        ),

        VoiceWave(height: 70),

        VoiceWave(
          height: 120,
          active: true,
        ),

        VoiceWave(height: 40),

        SizedBox(width: 24),

        VoiceWave(
          height: 80,
          active: true,
        ),

        VoiceWave(height: 50),
      ],
    );
  }
}