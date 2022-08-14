import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/Menu%20buttons/activate_plan_menu_items.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/top%20rows/days_row_for_week.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:dietapp_a/Diet%20plans/c_diet_view/a_timings_view_pc.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/_common_top_widget_middle.dart';
import 'package:dietapp_a/x_customWidgets/lootie_animations.dart';
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
                      child: Icon(MdiIcons.calendarWeekBegin,
                          color: Colors.white, size: 30),
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
                  var weekDR = listModels[index].docRef;
                  if (weekDR != null) {
                    pcc.currentWeekDR.value = weekDR;
                    pcc.currentDayDR.value =
                        await pcc.getDayDRfromWeek(pcc.currentWeekDR.value);

                    Get.to(() => WeekPlanViewFromChat(
                        weekIndex: index, weekModel: listModels[index]));
                  }
                });
          },
        ),
      ),
    );
  }
}

class WeekPlanViewFromChat extends StatelessWidget {
  final WeekModel weekModel;
  final int weekIndex;
  const WeekPlanViewFromChat(
      {Key? key, required this.weekIndex, required this.weekModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? weekName;
    if (weekModel.weekName != null) {
      weekName = weekModel.weekName;
    } else if (weekIndex > 0) {
      weekName = (weekIndex + 1).toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(weekName == null ? "Week plan" : "Week plan ($weekName)"),
        actions: [
          menuItems(),
          // TextButton(
          //     onPressed: () {

          //     },
          // child: const Text(
          //   "Activate",
          //   style: TextStyle(color: Colors.white),
          // )),
        ],
      ),
      body: Obx(() => Stack(
            children: [
              Column(
                children: const [
                  DaysRowForWeek(),
                  Expanded(
                    child: TimingsViewPC(editingIconRequired: false),
                  ),
                ],
              ),
              if (isLoading.value) loot.linerDotsLoading(),
            ],
          )),
    );
  }

  Widget menuItems() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PopupMenuButton(
        padding: const EdgeInsets.all(10.0),
        color: Colors.white,
        child: const Center(
          child: Text(
            "Activate",
            style: TextStyle(color: Colors.white),
          ),
        ),
        // const Icon(MdiIcons.dotsVertical, color: Colors.white),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {
                  Get.back();
                  activatePlanMenuItems.activateThisWeek(context);
                },
                child: const Text("Activate This Week      "),
              ),
            ),
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {
                  Get.back();
                  activatePlanMenuItems.activateThisDay(context);
                },
                child: const Text("Activate This Day      "),
              ),
            ),
          ];
        },
      ),
    );
  }
}
