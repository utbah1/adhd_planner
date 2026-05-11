import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {

  const SocialButton({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 60,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE5E5EA),
        ),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Image.asset(
            'assets/images/google_icon.png',
            width: 24,
          ),

          const SizedBox(width: 14),

          const Text(
            "Lanjutkan dengan Google",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}