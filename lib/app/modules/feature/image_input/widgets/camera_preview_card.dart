import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'scanner_overlay.dart';

class CameraPreviewCard
    extends StatelessWidget {

  final CameraController controller;

  const CameraPreviewCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    return AspectRatio(
      aspectRatio: 3 / 4,

      child: Stack(
        children: [

          /// CAMERA
          Container(
            width: double.infinity,

            clipBehavior: Clip.hardEdge,

            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(30),
            ),

            child: CameraPreview(controller),
          ),

          /// OVERLAY
          const ScannerOverlay(),
        ],
      ),
    );
  }
}