import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/top%20rows/days_row.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/top%20rows/weeks_row.dart';
import 'package:dietapp_a/Diet%20plans/c_diet_view/a_timings_view_pc.dart';
import 'package:flutter/material.dart';

class DietPlanViewW extends StatelessWidget {
  const DietPlanViewW({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        weeksRow000PlanCreationCombinedScreen(),
        daysRow000PlanCreationCombinedScreen(),
         Expanded(
          child: TimingsViewPC(),
        ),
      ],
    );
  }
}
