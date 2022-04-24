import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:dietapp_a/Diet%20plans/c_diet_view/a_timings_view_pc.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/_common_top_widget_middle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class WeekPlanMiddle extends StatelessWidget {
  final List<WeekModel> listModels;
  final String? text;
  const WeekPlanMiddle({
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
            return InkWell(
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child:
                          Icon(MdiIcons.calendarWeekBegin, color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Week plan (${index + 1})",
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                onTap: () async {
                  Get.to(() => WeekPlanViewFromChat(weekIndex: index));
                });
          },
        ),
      ),
    );
  }
}

class WeekPlanViewFromChat extends StatelessWidget {
  final int weekIndex;
  const WeekPlanViewFromChat({Key? key, required this.weekIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Week plan (${weekIndex + 1})",
      )),
      body: Column(
        children: const [
          Expanded(
            child: TimingsViewPC(editingIconRequired: false),
          ),
        ],
      ),
    );
  }
}
