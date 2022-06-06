import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/Diet%20plans/c_diet_view/diet_view_widget.dart';
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

  const PlanCreationCombinedScreen({
    Key? key,
    this.isForActivePlan = false,
    required this.isWeekWisePlan,
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
                      pcc.isPlanView.value ? "Edit" : "View",
                      style: const TextStyle(color: Colors.white),
                    ))),
            MenuItemsPC(
                isForActivePlan: isForActivePlan,
                isWeekWisePlan: isWeekWisePlan),
          ],
        ),
        body: Obx(
          () => pcc.isPlanView.value
              ? DietPlanViewW(isWeekWisePlan: isWeekWisePlan)
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
                const DaysRowForActivePlan(),
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
              children: const [
                DaysRowForActivePlan(),
                Text("Diet not planned for this day"),
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
