import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/dartUtilities/day_string_from_date.dart';
import 'package:dietapp_a/y_Active%20diet/chat/month_calander.dart';
import 'package:dietapp_a/y_Active%20diet/controllers/active_plan_controller.dart';
import 'package:dietapp_a/z_homeScreen/timing_view_home_screen.dart';
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
                    ? const MonthCalander()
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
}
