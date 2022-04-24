import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/Menu%20buttons/menu_button_pc.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/info%20view/timing_info_view_pc.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/list%20view/timing_foods_listview.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/top%20rows/days_row_non_week.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/top%20rows/timings_row.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/top%20rows/weeks_row.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/Diet%20plans/c_diet_view/diet_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'bottom bar/food_add_bottom_buttons.dart';
import 'top rows/days_row_for_week.dart';

class PlanCreationCombinedScreen extends StatelessWidget {
  final bool isWeekWisePlan;

  const PlanCreationCombinedScreen({
    Key? key,
    required this.isWeekWisePlan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: pcc.currentPlanDR.value.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.exists) {
                DietPlanBasicInfoModel dpm =
                    DietPlanBasicInfoModel.fromMap(snapshot.data!.data()!);
                return Text(dpm.planName);
              } else {
                return const GFLoader();
              }
            }),
        actions: [
          IconButton(
              onPressed: () {
                pcc.isPlanView.value = !pcc.isPlanView.value;
                // Get.to(() => DietPlanViewScreen());
              },
              icon: Obx(() => Icon(pcc.isPlanView.value
                  ? MdiIcons.eyeRemoveOutline
                  : MdiIcons.eyeOutline))),
          MenuItemsPC(isWeekWisePlan: isWeekWisePlan),
        ],
      ),
      body: Obx(() => pcc.isPlanView.value
          ? DietPlanViewW(
              isWeekWisePlan: isWeekWisePlan,
            )
          : Column(
              children: [
                if (isWeekWisePlan) const WeeksRowForPlan(),
                isWeekWisePlan
                    ? const DaysRowForWeek()
                    : const DaysRowNonWeek(),
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
            )),
    );
  }
}
