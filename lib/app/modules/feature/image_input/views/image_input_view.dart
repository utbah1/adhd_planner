import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../shared/widgets2/custom_topbar_feature.dart';

import '../widgets/camera_button.dart';
import '../widgets/camera_loading.dart';
import '../widgets/camera_preview_card.dart';
import '../widgets/ai_result_card.dart';
import '../widgets/bottom_actions.dart';

class ImageInputView extends StatefulWidget {

  const ImageInputView({super.key});

  @override
  State<ImageInputView> createState() =>
      _ImageInputViewState();
}

class _ImageInputViewState
    extends State<ImageInputView> {

  CameraController? controller;

  bool isCameraReady = false;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {

    final cameras =
        await availableCameras();

    controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await controller!.initialize();

    if (!mounted) return;

    setState(() {
      isCameraReady = true;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFFF6F4FA),

      appBar: const CustomTopbarFeature(
        title: "Pemindai Tugas AI",
        rightIcon: Iconsax.cpu,
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                /// CAMERA
                isCameraReady
                    ? CameraPreviewCard(
                        controller:
                            controller!,
                      )
                    : const CameraLoading(),

                const SizedBox(height: 40),

                /// BUTTON
                CameraButton(
                  controller: controller,
                ),

                const SizedBox(height: 40),

                const AiResultCard(),

                const SizedBox(height: 34),

                const BottomActions(),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}