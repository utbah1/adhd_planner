import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';

class CameraButton extends StatelessWidget {

  final CameraController? controller;

  const CameraButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    return Center(

      child: GestureDetector(

        onTap: () async {

          if (controller == null) return;

          final image =
              await controller!
                  .takePicture();

          ScaffoldMessenger.of(context)
              .showSnackBar(

            SnackBar(
              content: Text(
                'Foto berhasil disimpan: ${image.path}',
              ),
            ),
          );
        },

        child: Container(
          width: 90,
          height: 90,

          decoration: BoxDecoration(

            gradient:
                const LinearGradient(
              colors: [
                AppColors.primary,
                Color(0xFFA855F7),
              ],
            ),

            shape: BoxShape.circle,

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

          child: const Icon(
            Iconsax.camera,
            color: Colors.white,
            size: 38,
          ),
        ),
      ),
    );
  }
}