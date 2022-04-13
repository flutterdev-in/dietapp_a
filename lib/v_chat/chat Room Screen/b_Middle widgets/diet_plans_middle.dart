import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';

import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/_common_top_widget_middle.dart';
import 'package:flutter/material.dart';
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
          physics: ClampingScrollPhysics(),
          itemCount: listModels.length,
          itemBuilder: (context, index) {
            DietPlanBasicInfoModel model = listModels[index];
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(MdiIcons.calendarWeekBegin, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Week plan (${index + 1})",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
