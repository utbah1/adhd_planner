import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../core/constants/app_colors.dart';

class CustomTextField extends StatefulWidget {

  final String hint;
  final IconData icon;
  final bool obscure;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.obscure = false,
  });

  @override
  State<CustomTextField> createState() =>
      _CustomTextFieldState();
}

class _CustomTextFieldState
    extends State<CustomTextField> {

  late bool isObscure;

  @override
  void initState() {
    super.initState();

    isObscure = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 68,

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(22),

        border: Border.all(
          color: AppColors.border,
        ),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(.03),

            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: TextField(

        controller: widget.controller,

        obscureText: isObscure,

        style: const TextStyle(
          fontSize: 17,
          color: Color(0xFF2B2238),
          fontWeight: FontWeight.w500,
        ),

        decoration: InputDecoration(

          border: InputBorder.none,

          contentPadding:
              const EdgeInsets.symmetric(
            vertical: 20,
          ),

          hintText: widget.hint,

          hintStyle: const TextStyle(
            color: Color(0xFF9D97A8),
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),

          /// PREFIX ICON
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
              left: 18,
              right: 14,
            ),

            child: Icon(
              widget.icon,
              color: AppColors.textGrey,
              size: 24,
            ),
          ),

          prefixIconConstraints:
              const BoxConstraints(
            minWidth: 60,
          ),

          /// SUFFIX ICON PASSWORD
          suffixIcon: widget.obscure
              ? GestureDetector(

                  onTap: () {

                    setState(() {
                      isObscure =
                          !isObscure;
                    });
                  },

                  child: Padding(
                    padding:
                        const EdgeInsets.only(
                      right: 18,
                    ),

                    child: Icon(
                      isObscure
                          ? Iconsax.eye
                          : Iconsax.eye_slash,

                      color:
                          AppColors.textGrey,

                      size: 24,
                    ),
                  ),
                )
              : null,

          suffixIconConstraints:
              const BoxConstraints(
            minWidth: 60,
          ),
        ),
      ),
    );
  }
}