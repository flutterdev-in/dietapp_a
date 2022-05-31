import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/v_chat/diet%20Room%20Screen/_diet_room_controller.dart';
import 'package:dietapp_a/v_chat/diet%20Room%20Screen/a_diet_view_member_manager.dart';
import 'package:dietapp_a/x_customWidgets/month_calander.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DietViewChat extends StatelessWidget {

  const DietViewChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        monthCalander(),
        DietViewMemberManager(),
      ],
    );
  }

  Widget monthCalander() {
    return Obx(() => MonthCalander(
        currentDay: drc.calendarDate.value,
        onDaySelected: (selectedDate, focusedDate) async {
          drc.calendarDate.value = focusedDate;
          drc.currentDayDR.value = admos.activeDayDR(focusedDate);
        },
        onCurrentCalanderPressed: () async {
          drc.calendarDate.value = dateNow.add(const Duration(days: 1));
          drc.calendarDate.value = dateNow;
          drc.currentDayDR.value = admos.activeDayDR(dateNow);
        }));
  }
}
