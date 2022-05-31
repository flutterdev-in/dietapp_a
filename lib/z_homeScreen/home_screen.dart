import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/dartUtilities/day_string_from_date.dart';
import 'package:dietapp_a/x_customWidgets/month_calander.dart';
import 'package:dietapp_a/y_Active%20diet/controllers/active_plan_controller.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/z_homeScreen/c_Timings%20view/_timing_view_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
              const TimingViewHomeScreen(),
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
          apc.dt.value = focusedDate;

          apc.cuurentActiveDayDR.value = admos.activeDayDR(focusedDate);
          //   // await apc.getCurrentActiveTimingModels(apc.cuurentActiveDayDR.value);
        },
        onCurrentCalanderPressed: () async {
          apc.dt.value = dateNow.add(const Duration(days: 1));
          apc.dt.value = dateNow;
          apc.cuurentActiveDayDR.value = admos.activeDayDR(dateNow);
          //   // await apc.getCurrentActiveTimingModels(
          //   //     apc.cuurentActiveDayDR.value);
        });
  }
}
