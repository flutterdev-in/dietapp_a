import 'package:dietapp_a/y_Active%20diet/chat/active_timing_view.dart';
import 'package:dietapp_a/y_Active%20diet/controllers/active_plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/active_day_model.dart';

class MonthCalander extends StatelessWidget {
  const MonthCalander({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cf = CalendarFormat.week.obs;

    final today = DateTime.now();

    return Obx(() => TableCalendar<ActiveDayModel>(
          focusedDay: apc.dt.value,
          firstDay: apc.dateDiffer(today, false, ymd: "y", differ: 1),
          lastDay: apc.dateDiffer(today, true, ymd: "y", differ: 1),
          startingDayOfWeek: StartingDayOfWeek.monday,
          currentDay: apc.dt.value,
          calendarFormat: cf.value,
          onPageChanged: (focusedDay) {},
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
            CalendarFormat.week: 'Week'
          },
          onFormatChanged: (format) {
            cf.value = format;
          },
          calendarStyle: const CalendarStyle(
              // isTodayHighlighted: true,
              selectedTextStyle: TextStyle(
                  color: Color.fromARGB(255, 137, 31, 31), fontSize: 16.0),
              todayDecoration: BoxDecoration(
                  color: Color.fromARGB(210, 21, 54, 30),
                  shape: BoxShape.circle),
              selectedDecoration: BoxDecoration(
                  color: Color.fromARGB(119, 1, 20, 2),
                  shape: BoxShape.circle)),
          onDaySelected: (selectedDate, focusedDate) async {
            apc.dt.value = focusedDate;
            apc.cuurentActiveDayDR.value = admos.activeDayDR(focusedDate);
            await apc
                .getCurrentActiveTimingModels(apc.cuurentActiveDayDR.value);
          },
        ));
  }
}
