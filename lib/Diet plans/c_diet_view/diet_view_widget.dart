import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/top%20rows/days_row_for_week.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/top%20rows/weeks_row.dart';
import 'package:flutter/material.dart';

import 'a_timings_view_pc.dart';

class DietPlanViewW extends StatelessWidget {
  final bool isWeekWisePlan;
  const DietPlanViewW({
    Key? key,
    required this.isWeekWisePlan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isWeekWisePlan
            ? Column(
                children: const [
                  WeeksRowForPlan(),
                  DaysRowForWeek(),
                ],
              )
            : const SizedBox(),
        const Expanded(
          child: TimingsViewPC(),
        ),
      ],
    );
  }
}
