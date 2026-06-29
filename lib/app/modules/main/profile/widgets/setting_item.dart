import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SettingsItemData {

  final IconData icon;
  final String title;
  final bool danger;
  final VoidCallback? onTap;

  SettingsItemData({
    required this.icon,
    required this.title,
    this.danger = false,
    this.onTap,
  });
}

class SettingItem extends StatelessWidget {

  final SettingsItemData data;

  const SettingItem({
    super.key,
    required this.data,
  });

@override
Widget build(BuildContext context) {

  return ListTile(

    onTap: data.onTap,

    contentPadding:
        const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 8,
    ),

    leading: Icon(
      data.icon,

      color: data.danger
          ? Colors.red
          : const Color(0xFF5B5563),
    ),

    title: Text(
      data.title,

      style: TextStyle(
        fontSize: 20,

        color: data.danger
            ? Colors.red
            : const Color(0xFF2B2238),
      ),
    ),

    trailing: Icon(
      Iconsax.arrow_right_3,

      color: data.danger
          ? Colors.red
          : const Color(0xFF8A8395),
    ),
  );
  }
}