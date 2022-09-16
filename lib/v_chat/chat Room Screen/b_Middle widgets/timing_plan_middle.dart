import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/info%20view/timing_info_view_pc.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/list%20view/timing_foods_listview.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/_common_top_widget_middle.dart';
import 'package:dietapp_a/y_Models/timing_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TimingPlanMiddle extends StatelessWidget {
  final List<TimingModel> listModels;
  final String? text;
  const TimingPlanMiddle({
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
            TimingModel model = listModels[index];
            return InkWell(
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(MdiIcons.calendarClock, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Timing plan\n(${model.timingName})",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              onTap: () {
                if (model.docRef != null) {
                  pcc.currentTimingDR.value = model.docRef!;
                  Get.to(() => TimingViewFromChat(dtm: model));
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class TimingViewFromChat extends StatelessWidget {
  final TimingModel dtm;
  const TimingViewFromChat({Key? key, required this.dtm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(dtm.timingName)),
      body: ListView(
        shrinkWrap: true,
        children: [
          if (dtm.rumm != null || dtm.notes != null)
            const TimingInfoViewPC(editingIconRequired: false),
          const FoodsListViewforPC(editIconRequired: false),
        ],
      ),
    );
  }
}
