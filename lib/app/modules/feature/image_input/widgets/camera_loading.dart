import 'package:flutter/material.dart';

class CameraLoading extends StatelessWidget {

  const CameraLoading({super.key});

  @override
  Widget build(BuildContext context) {

    return AspectRatio(
      aspectRatio: 3 / 4,

      child: Container(
        width: double.infinity,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(30),
        ),

        child: const Center(
          child:
              CircularProgressIndicator(),
        ),
      ),
    );
  }
}