import 'package:flutter/material.dart';

import 'setting_item.dart';

class SettingsCard extends StatelessWidget {

  final List<SettingsItemData> items;

  const SettingsCard({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),

      child: Column(
        children: items
            .map(
              (item) => SettingItem(
                data: item,
              ),
            )
            .toList(),
      ),
    );
  }
}