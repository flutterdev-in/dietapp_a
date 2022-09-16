import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/y_Active%20diet/controllers/active_days_.dart';
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
  final Future<void> Function(DateTime, DateTime)? onDayLongPressed;
  final DateTime currentDay;
  final int startDays;
  final int endDays;
  final String personUID;
  const MonthCalander({
    Key? key,
    required this.currentDay,
    required this.onDaySelected,
    required this.onCurrentCalanderPressed,
    required this.personUID,
    this.onDayLongPressed,
    this.startDays = 60,
    this.endDays = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cf = CalendarFormat.week.obs;

    final today = DateTime.now();

    return Obx(() {
      mapDateADM.value;
      return TableCalendar(
          focusedDay: currentDay,
          firstDay: apc.dateDiffer(today, false, ymd: "d", differ: startDays),
          lastDay: apc.dateDiffer(today, true, ymd: "d", differ: endDays),
          startingDayOfWeek: StartingDayOfWeek.monday,
          currentDay: currentDay,
          formatAnimationCurve: Curves.slowMiddle,
          pageJumpingEnabled: true,
          calendarFormat: cf.value,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
            CalendarFormat.week: 'Week'
          },
          rowHeight: 40.0,
          onFormatChanged: (format) {
            cf.value = format;
          },
          headerStyle: const HeaderStyle(
            headerPadding: EdgeInsets.symmetric(vertical: 0.0),
          ),
          calendarStyle: const CalendarStyle(
              selectedTextStyle: TextStyle(
                  color: Color.fromARGB(255, 137, 31, 31), fontSize: 16.0),
              todayDecoration: BoxDecoration(
                  color: Color.fromARGB(210, 21, 54, 30),
                  shape: BoxShape.circle),
              selectedDecoration: BoxDecoration(
                  color: Color.fromARGB(119, 1, 20, 2),
                  shape: BoxShape.circle)),
          onDaySelected: (selectedDate, focusedDate) async {
            onDaySelected(selectedDate, focusedDate); //
          },
          onDayLongPressed: (selectedDate, focusedDate) async {
            onDaySelected(selectedDate, focusedDate);
            if (onDayLongPressed != null) {
              onDayLongPressed!(selectedDate, focusedDate);
            }
          },
          calendarBuilders: CalendarBuilders(
              //
              markerBuilder: (context, day, events) {
            return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: admos.activeDayDR(day, personUID).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.data() != null) {
                    return const Text(".", textScaleFactor: 3);
                  }
                  return const SizedBox();
                });
          }, headerTitleBuilder: ((context, day) {
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
          })));
    });
  }
}
