import 'package:dietapp_a/y_Active%20diet/controllers/days_controller.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthCalander extends StatelessWidget {
  const MonthCalander({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cf = CalendarFormat.week.obs;
    return Obx(() => TableCalendar<ActiveDayModel>(
          focusedDay: dc.dt.value,
          firstDay: dc.dateDiffer(dc.dt.value, false, ymd: "y", differ: 1),
          lastDay: dc.dateDiffer(dc.dt.value, true, ymd: "y", differ: 1),
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarFormat: cf.value,
          headerStyle: const HeaderStyle(),
          onPageChanged: (focusedDay) {},
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
            CalendarFormat.week: 'Week'
          },
          onFormatChanged: (format) {
            cf.value = format;
          },
        ));
  }
}
