import 'package:dietapp_a/y_Active%20diet/controllers/active_plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

import '../y_Active diet/models/active_day_model.dart';

class MonthCalander extends StatelessWidget {
  final Future<void> Function() onCurrentCalanderPressed;
  final Future<void> Function(DateTime, DateTime) onDaySelected;
  final DateTime currentDay;
  const MonthCalander(
      {Key? key,
      required this.currentDay,
      required this.onDaySelected,
      required this.onCurrentCalanderPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cf = CalendarFormat.week.obs;

    final today = DateTime.now();

    return Obx(() => TableCalendar<ActiveDayModel>(
        focusedDay: currentDay,
        firstDay: apc.dateDiffer(today, false, ymd: "y", differ: 1),
        lastDay: apc.dateDiffer(today, true, ymd: "y", differ: 1),
        startingDayOfWeek: StartingDayOfWeek.monday,
        currentDay: currentDay,
        formatAnimationCurve: Curves.slowMiddle,
        pageJumpingEnabled: true,
        calendarFormat: cf.value,
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
          CalendarFormat.week: 'Week'
        },
        rowHeight: 35.0,
        onFormatChanged: (format) {
          cf.value = format;
        },
        headerStyle: const HeaderStyle(
          headerPadding: EdgeInsets.symmetric(vertical: 0.0),
        ),
        calendarStyle: const CalendarStyle(
            // isTodayHighlighted: true,
            // cellMargin: EdgeInsets.all(0.0),
            selectedTextStyle: TextStyle(
                color: Color.fromARGB(255, 137, 31, 31), fontSize: 16.0),
            todayDecoration: BoxDecoration(
                color: Color.fromARGB(210, 21, 54, 30), shape: BoxShape.circle),
            selectedDecoration: BoxDecoration(
                color: Color.fromARGB(119, 1, 20, 2), shape: BoxShape.circle)),
        onDaySelected: (selectedDate, focusedDate) async {
          onDaySelected(selectedDate, focusedDate); //
        },
        calendarBuilders: CalendarBuilders(headerTitleBuilder: ((context, day) {
          String dayString = DateFormat("MMM yyyy").format(day);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dayString),
              IconButton(
                icon: const Icon(MdiIcons.calendar),
                onPressed: () async {
                  onCurrentCalanderPressed();
                },
              ),
            ],
          );
        }))));
  }
}
