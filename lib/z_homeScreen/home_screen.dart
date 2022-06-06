import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/dartUtilities/day_string_from_date.dart';
import 'package:dietapp_a/x_customWidgets/month_calander.dart';
import 'package:dietapp_a/y_Active%20diet/controllers/active_plan_controller.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'c_Timings view/_timing_view_home_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isCalendarEnabled = false.obs;
    return Obx(() => StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: apc.currentActiveDayDR.value.snapshots(),
        builder: (context, snapshot) {
          bool isDayExists = false;

          if (snapshot.hasData && snapshot.data!.data() != null) {
            isDayExists = true;
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text("DietApp"),
              actions: [
                InkWell(
                  child: Row(
                    children: [
                      Obx(() => Text(dayStringFromDate(apc.dt.value))),
                      const Icon(MdiIcons.chevronDown),
                    ],
                  ),
                  onTap: () async {
                    isCalendarEnabled.value = !isCalendarEnabled.value;
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                Obx(() => isCalendarEnabled.value
                    ? monthCalander()
                    : const SizedBox()),
                Expanded(child: TimingViewHomeScreen(isDayExists: isDayExists)),
              ],
            ),
            floatingActionButton: floatingButton(isDayExists),
          );
        }));
  }

  Widget monthCalander() {
    return MonthCalander(
        currentDay: apc.dt.value,
        onDaySelected: (selectedDate, focusedDate) async {
          apc.dt.value = focusedDate;

          apc.currentActiveDayDR.value =
              admos.activeDayDR(focusedDate, userUID);
          // await atmos.checkAndSetDefaultTimings(focusedDate);
        },
        personUID: userUID,
        onCurrentCalanderPressed: () async {
          apc.dt.value = DateTime.now().add(const Duration(days: 1));
          apc.dt.value = DateTime.now();
          apc.currentActiveDayDR.value =
              admos.activeDayDR(DateTime.now(), userUID);
        });
  }

  FloatingActionButton? floatingButton(bool isDayExists) {
    var todayString = admos.dayStringFromDate(DateTime.now());
    var today = DateTime.parse(todayString);

    var selectedDate = DateTime.parse(apc.currentActiveDayDR.value.id);

    var isBefore = selectedDate.isBefore(today);
    var difference = selectedDate.difference(today);

    bool isEdit = false;
    if (todayString == apc.currentActiveDayDR.value.id || !isBefore) {
      isEdit = true;
    } else if (isBefore && difference.inDays < 7) {
      isEdit = true;
    }

    if (isDayExists && isEdit == true) {
      return FloatingActionButton(
          backgroundColor: secondaryColor,
          mini: true,
          child: const Icon(MdiIcons.clipboardEditOutline),
          onPressed: () {});
    } else {
      return null;
    }
  }
}
