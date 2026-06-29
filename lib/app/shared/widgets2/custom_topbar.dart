import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class CustomTopbar extends StatelessWidget
    implements PreferredSizeWidget {

  final String title;
  final IconData icon;

  const CustomTopbar({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Size get preferredSize =>
      const Size.fromHeight(82);

  @override
  Widget build(BuildContext context) {

    return ClipRRect(

      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(28),
        bottomRight: Radius.circular(28),
      ),

      child: BackdropFilter(

        filter: ImageFilter.blur(
          sigmaX: 12,
          sigmaY: 12,
        ),

        child: AppBar(

          automaticallyImplyLeading: false,

          elevation: 0,
          scrolledUnderElevation: 0,

          toolbarHeight: 82,

          backgroundColor:
              Colors.white.withOpacity(.18),

          surfaceTintColor: Colors.transparent,

          titleSpacing: 0,

          title: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
            ),

            child: Row(
              children: [

                /// ICON BOX
                Container(
                  width: 50,
                  height: 50,

                  decoration: BoxDecoration(

                    color:
                        Colors.white.withOpacity(.35),

                    borderRadius:
                        BorderRadius.circular(18),

                    border: Border.all(
                      color: Colors.white
                          .withOpacity(.25),
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary
                            .withOpacity(.08),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),

                  child: Icon(
                    icon,
                    color: AppColors.primary,
                    size: 23,
                  ),
                ),

                const SizedBox(width: 16),

                /// TITLE
                Expanded(
                  child: Text(
                    title,

                    overflow:
                        TextOverflow.ellipsis,

                    maxLines: 1,

                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,

                      shadows: [
                        Shadow(
                          color: Colors.white
                              .withOpacity(.4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}