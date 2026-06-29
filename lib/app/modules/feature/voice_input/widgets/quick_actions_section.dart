import 'package:flutter/material.dart';

import 'quick_action_chip.dart';

class QuickActionsSection
    extends StatelessWidget {

  const QuickActionsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return const Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,

      children: [

        QuickActionChip(
          text: "Set Reminder",
        ),

        QuickActionChip(
          text: "Add to List",
        ),

        QuickActionChip(
          text: "New Event",
        ),
      ],
    );
  }
}