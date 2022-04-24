import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/c_diet_view/a_timings_view_pc.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/_common_top_widget_middle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DayPlanMiddle extends StatelessWidget {
  final List<DayModel> listDays;
  final String? text;
  const DayPlanMiddle({
    Key? key,
    required this.listDays,
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
          itemCount: listDays.length,
          itemBuilder: (context, index) {
            DayModel dm = listDays[index];
            String? dayName;
            if (dm.dayIndex != null) {
              dayName = daymfos.ls[dm.dayIndex ?? 0];
            } else if (dm.dayName != null) {
              dayName = dm.dayName!;
            } else if (listDays.length != 1) {
              dayName = (index + 1).toString();
            }

            return InkWell(
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(MdiIcons.calendarToday, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      dayName == null ? "Day plan" : "Day plan ($dayName)",
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              onTap: () async {
                if (dm.docRef != null) {
                  await dm.docRef!
                      .collection(dtmos.timings)
                      .orderBy(dtmos.timingString, descending: false)
                      .limit(1)
                      .get()
                      .then((snapshot) async {
                    if (snapshot.docs.isNotEmpty) {
                      pcc.currentTimingDR.value = snapshot.docs.first.reference;
                      Get.to(() => DayViewFromChat(
                            dm: dm,
                            dayName: dayName,
                          ));
                    }
                  });
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class DayViewFromChat extends StatelessWidget {
  final DayModel dm;
  final String? dayName;
  const DayViewFromChat({Key? key, required this.dm, required this.dayName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        dayName == null ? "Day plan" : "Day plan ($dayName)",
      )),
      body: const TimingsViewPC(
        editingIconRequired: false,
      ),
    );
  }
}
