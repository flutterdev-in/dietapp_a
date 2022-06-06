import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/Diet%20plans/c_diet_view/diet_view_widget.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import 'Menu buttons/menu_button_pc.dart';
import 'bottom bar/food_add_bottom_buttons.dart';
import 'info view/timing_info_view_pc.dart';
import 'list view/timing_foods_listview.dart';
import 'top rows/days_row_for_active_plan.dart';
import 'top rows/days_row_for_week.dart';
import 'top rows/days_row_non_week.dart';
import 'top rows/timings_row.dart';
import 'top rows/weeks_row.dart';

class PlanCreationCombinedScreen extends StatelessWidget {
  final bool isWeekWisePlan;
  final bool isForActivePlan;
  final bool isForSingleDayActive;

  const PlanCreationCombinedScreen({
    Key? key,
    required this.isForActivePlan,
    required this.isWeekWisePlan,
    this.isForSingleDayActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    pcc.isPlanView.value = false;
    return Scaffold(
        appBar: AppBar(
          title: isForActivePlan
              ? const Text("My plan")
              : StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: pcc.currentPlanDR.value.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.exists) {
                      DietPlanBasicInfoModel dpm =
                          DietPlanBasicInfoModel.fromMap(
                              snapshot.data!.data()!);
                      return Text(dpm.planName);
                    } else {
                      return const GFLoader();
                    }
                  }),
          actions: [
            TextButton(
                onPressed: () {
                  pcc.isPlanView.value = !pcc.isPlanView.value;
                  // Get.to(() => DietPlanViewScreen());
                },
                child: Obx(() => Text(
                      pcc.isPlanView.value ? "Edit\nmode" : "View\nmode",
                      style: const TextStyle(color: Colors.white),
                    ))),
            MenuItemsPC(
                isForActivePlan: isForActivePlan,
                isWeekWisePlan: isWeekWisePlan),
          ],
        ),
        body: Obx(
          () => pcc.isPlanView.value
              ? DietPlanViewW(
                  isForActivePlan: isForActivePlan,
                  isForSingleDayActive: isForSingleDayActive,
                  isWeekWisePlan: isWeekWisePlan)
              : isForActivePlan
                  ? forActive()
                  : forNonActive(),
        ));
  }

  Widget forActive() {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: pcc.currentDayDR.value.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.exists) {
            return Column(
              children: [
                DaysRowForActivePlan(isForSingleDayActive),
                const TimingsRow000PlanCreationCombinedScreen(),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: const [
                      TimingInfoViewPC(),
                      FoodsListViewforPC(),
                    ],
                  ),
                ),
                const FoodAddButtons(),
              ],
            );
          } else {
            return Column(
              children: [
                DaysRowForActivePlan(isForSingleDayActive),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Diet not planned for this day"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GFButton(
                          onPressed: () async {
                            await atmos
                                .activateDefaultTimings(pcc.currentDayDR.value);
                            pcc.currentTimingDR.value = await pcc
                                .getTimingDRfromDay(pcc.currentDayDR.value);
                          },
                          child: const Text("Plan now")),
                    ),
                  ],
                ),
              ],
            );
          }
        });
  }

  Widget forNonActive() {
    return Column(
      children: [
        if (isWeekWisePlan) const WeeksRowForPlan(),
        isWeekWisePlan ? const DaysRowForWeek() : const DaysRowNonWeek(),
        const TimingsRow000PlanCreationCombinedScreen(),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: const [
              TimingInfoViewPC(),
              FoodsListViewforPC(),
            ],
          ),
        ),
        const FoodAddButtons(),
      ],
    );
  }
}
