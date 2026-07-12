import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/date_formatter.dart';
import '../controllers/calendar_controller.dart';

class TodayHeader extends StatelessWidget {

  const TodayHeader({super.key});

  @override
  Widget build(BuildContext context) {

    final CalendarController controller = Get.find();

    return Obx(
      () => Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [

          Text(
            controller.isSelectedToday
                ? "  Agenda Hari Ini"
                : "  Agenda ${DateFormatter.shortDate(
                    controller.selectedDate.value,
                  )}",

            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
