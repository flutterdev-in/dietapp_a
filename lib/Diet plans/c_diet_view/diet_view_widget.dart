import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/top%20rows/days_row_for_active_plan.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/top%20rows/days_row_for_week.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/top%20rows/days_row_non_week.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/top%20rows/weeks_row.dart';
import 'package:flutter/material.dart';

import 'a_timings_view_pc.dart';

class DietPlanViewW extends StatelessWidget {
  final bool isWeekWisePlan;
  final bool isForActivePlan;
  final bool isForSingleDayActive;
  const DietPlanViewW({
    Key? key,
    required this.isForActivePlan,
    required this.isForSingleDayActive,
    required this.isWeekWisePlan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isForSingleDayActive
            ? DaysRowForActivePlan(isForSingleDayActive).singleDayW()
            : isForActivePlan
                ? DaysRowForActivePlan(isForSingleDayActive)
                : isWeekWisePlan
                    ? Column(
                        children: const [
                          WeeksRowForPlan(),
                          DaysRowForWeek(),
                        ],
                      )
                    : const DaysRowNonWeek(),
        const Expanded(
          child: TimingsViewPC(),
        ),
      ],
    );
  }
}
