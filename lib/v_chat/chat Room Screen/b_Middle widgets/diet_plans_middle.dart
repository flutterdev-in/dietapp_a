import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/top%20rows/days_row_for_week.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/top%20rows/days_row_non_week.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/top%20rows/weeks_row.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/Diet%20plans/c_diet_view/a_timings_view_pc.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/_common_top_widget_middle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DietPlansMiddle extends StatelessWidget {
  final List<DietPlanBasicInfoModel> listModels;
  final String? text;
  const DietPlansMiddle({
    Key? key,
    required this.listModels,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonTopWidgetMiddle(
      text: text,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: listModels.length,
          itemBuilder: (context, index) {
            DietPlanBasicInfoModel model = listModels[index];
            return InkWell(
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(MdiIcons.clipboardTextOutline,
                        size: 30, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      model.planName,
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              onTap: () async {
                if (model.docRef != null) {
                  await pcc.getPlanRxValues(
                      model.docRef!, model.isWeekWisePlan);
                  pcc.isCombinedCreationScreen.value = false;
                  Get.to(() => DietPlanViewFromChat(model: model));
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class DietPlanViewFromChat extends StatelessWidget {
  final DietPlanBasicInfoModel model;
  const DietPlanViewFromChat({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.planName),
      ),
      body: Column(
        children: [
          if (model.isWeekWisePlan) const WeeksRowForPlan(),
          model.isWeekWisePlan
              ? const DaysRowForWeek()
              : const DaysRowNonWeek(),
          const Expanded(
            child: TimingsViewPC(editingIconRequired: false),
          ),
        ],
      ),
    );
  }
}
