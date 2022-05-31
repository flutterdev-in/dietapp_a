import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/a_Diet%20widgets/active_timing_view.dart';
import 'package:dietapp_a/x_customWidgets/month_calander.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DietViewChat extends StatelessWidget {
  const DietViewChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calendarDate = dateNow.obs;
    return Column(
      children: [
        Obx(() => MonthCalander(
            currentDay: calendarDate.value,
            onDaySelected: (selectedDate, focusedDate) async {
              calendarDate.value = focusedDate;
            },
            onCurrentCalanderPressed: () async {
              calendarDate.value = dateNow.add(const Duration(days: 1));

              calendarDate.value = dateNow;
            })),
        const ActiveTimingsView(),
      ],
    );
  }
}
