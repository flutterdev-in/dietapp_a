import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/Menu%20buttons/menu_button_pc.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/info%20view/timing_info_view_pc.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/top%20rows/days_row.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/list%20view/timing_foods_listview.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/top%20rows/timings_row.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/top%20rows/weeks_row.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/bottom%20bar/food_add_bottom_buttons.dart';
import 'package:dietapp_a/Diet%20plans/c_diet_view/diet_view_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PlanCreationCombinedScreen extends StatelessWidget {
  const PlanCreationCombinedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pcc.currentPlanName.value),
        actions: [
          IconButton(
              onPressed: () {
                pcc.isPlanView.value = !pcc.isPlanView.value;
                // Get.to(() => DietPlanViewScreen());
              },
              icon: Obx(() => Icon(pcc.isPlanView.value
                  ? MdiIcons.eyeRemoveOutline
                  : MdiIcons.eyeOutline))),
          MenuItemsPC(),
        ],
      ),
      body: Obx(() => pcc.isPlanView.value
          ? DietPlanViewW()
          : Column(
              children: [
                weeksRow000PlanCreationCombinedScreen(),
                daysRow000PlanCreationCombinedScreen(),
                TimingsRow000PlanCreationCombinedScreen(),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      TimingInfoViewPC(),
                      FoodsListViewforPC(),
                    ],
                  ),
                ),
                FoodAddButtons(),
              ],
            )),
    );
  }
}
