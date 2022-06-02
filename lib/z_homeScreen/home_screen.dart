import 'dart:developer';

import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/dartUtilities/day_string_from_date.dart';
import 'package:dietapp_a/x_customWidgets/month_calander.dart';
import 'package:dietapp_a/y_Active%20diet/controllers/active_plan_controller.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'c_Timings view/_timing_view_home_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isCalendarEnabled = false.obs;
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
            onTap: () {
              isCalendarEnabled.value = !isCalendarEnabled.value;
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                child: Obx(() => isCalendarEnabled.value
                    ? monthCalander()
                    : const SizedBox()),
              ),
              const Expanded(child: TimingViewHomeScreen()),
            ],
          ),
          Obx(() => isLoading.value
              ? const SpinKitRotatingCircle(
                  color: Color.fromARGB(255, 191, 25, 210),
                  size: 50.0,
                )
              : const SizedBox()),
        ],
      ),
    );
  }

  Widget monthCalander() {
    return MonthCalander(
        currentDay: apc.dt.value,
        onDaySelected: (selectedDate, focusedDate) async {
          log("dfgfdgg");
          apc.dt.value = focusedDate;

          apc.currentActiveDayDR.value = admos.activeDayDR(focusedDate);
          await atmos.checkAndSetDefaultTimings(focusedDate);
        },
        onCurrentCalanderPressed: () async {
          apc.dt.value = DateTime.now().add(const Duration(days: 1));
          apc.dt.value = DateTime.now();
          apc.currentActiveDayDR.value = admos.activeDayDR(DateTime.now());
        });
  }
}
