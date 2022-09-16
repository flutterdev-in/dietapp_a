import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/dartUtilities/day_time_managers.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:dietapp_a/y_Active%20diet/functions/activate_planned_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

ActivatePlanMenuItems activatePlanMenuItems = ActivatePlanMenuItems();

class ActivatePlanMenuItems {
  void activateWeekPlan(BuildContext context) {
    List<DateTime> listMondays = getWeekMondays();
    DateTime selectedDate = listMondays[0];

    for (var i in listMondays) {
      if (i.weekday == 1) {
        selectedDate = i;
        break;
      }
    }

    alertDialogW(context,
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: Text("Select starting date"),
            ),
            SizedBox(
              height: 150,
              child: CupertinoPicker(
                itemExtent: 60,
                diameterRatio: 100,
                scrollController: FixedExtentScrollController(
                    initialItem: listMondays.indexOf(selectedDate)),
                children: listMondays.map((e) {
                  return Center(
                      child: Text(DateFormat("dd MMM yyyy (EEE)").format(e)));
                }).toList(),
                onSelectedItemChanged: (index) {
                  selectedDate = listMondays[index];
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 5),
              child: ElevatedButton(
                  child: const Text("Activate"),
                  onPressed: () async {
                    await activatePlannedData.singlePlan(
                        startDate: selectedDate,
                        plannedPlanDR: pcc.currentPlanDR.value);
                  }),
            )
          ],
        ));
  }

  void activateThisWeek(BuildContext context) {
    List<DateTime> listMondays = getWeekMondays();
    DateTime selectedDate = listMondays[0];

    for (var i in listMondays) {
      if (i.weekday == 1) {
        selectedDate = i;
        break;
      }
    }

    alertDialogW(context,
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: Text("Select starting date"),
            ),
            SizedBox(
              height: 150,
              child: CupertinoPicker(
                itemExtent: 60,
                diameterRatio: 100,
                scrollController: FixedExtentScrollController(
                    initialItem: listMondays.indexOf(selectedDate)),
                children: listMondays.map((e) {
                  return Center(
                      child: Text(DateFormat("dd MMM yyyy (EEE)").format(e)));
                }).toList(),
                onSelectedItemChanged: (index) {
                  selectedDate = listMondays[index];
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 5),
              child: ElevatedButton(
                  child: const Text("Activate"),
                  onPressed: () async {
                    await activatePlannedData.singleWeek(
                        startDate: selectedDate,
                        plannedWeekDR: pcc.currentWeekDR.value);
                  }),
            )
          ],
        ));
  }

  void activateDayPlan(BuildContext context) async {
    var today = DateTime.now();

    var selectedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: today.add(const Duration(days: 60)),
      helpText: "Select starting date",
      confirmText: "Activate",
    );
    if (selectedDate != null) {
      await activatePlannedData.singlePlan(
          startDate: selectedDate, plannedPlanDR: pcc.currentPlanDR.value);
    }
  }

  void activateThisDay(BuildContext context) async {
    var today = DateTime.now();

    var selectedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: today.add(const Duration(days: 60)),
      helpText: "Select date",
      confirmText: "Activate",
    );
    if (selectedDate != null) {
      await activatePlannedData.singleDay(
          plannedDayDataMap: null,
          plannedDayDR: pcc.currentDayDR.value,
          date: selectedDate);
    }
  }

  void activateThisTiming(BuildContext context) async {
    var today = DateTime.now();

    var selectedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: today.add(const Duration(days: 60)),
      helpText: "Select date",
      confirmText: "Activate",
    );
    if (selectedDate != null) {
      await activatePlannedData.singleTiming(
          plannedTimingDataMap: null,
          plannedTimingDR: pcc.currentTimingDR.value,
          date: selectedDate);
    }
  }
}
