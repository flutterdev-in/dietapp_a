import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/Widgets/days_row.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/Widgets/timing_foods_listview.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/Widgets/timings_row.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/Widgets/weeks_row.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/Widgets/food_add_bottom_buttons.dart';
import 'package:flutter/material.dart';

class PlanCreationCombinedScreen extends StatelessWidget {
  const PlanCreationCombinedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pcc.currentPlanName.value),
      ),
      body: Column(
        children: [
          weeksRow000PlanCreationCombinedScreen(),
          daysRow000PlanCreationCombinedScreen(),
          TimingsRow000PlanCreationCombinedScreen(),
          TimingFoodsListView(),
          // Container(height: 0.5, width: double.maxFinite, color: Colors.black38)

          FoodAddButtons(),
        ],
      ),
    );
  }
}
