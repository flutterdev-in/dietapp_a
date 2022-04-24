import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';

class WeeksRowForPlan extends StatelessWidget {
  const WeeksRowForPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mw = MediaQuery.of(context).size.width;
    pcc.listWeeksDR.value.clear();
    return SizedBox(
      width: mw,
      height: 37,
      child: Obx(() {
        return FirestoreListView<Map<String, dynamic>>(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          query: pcc.currentPlanDR.value
              .collection(wmfos.weeks)
              .orderBy(wmfos.weekCreatedTime, descending: false),
          itemBuilder: (context, doc) {
            WeekModel wm = WeekModel.fromMap(doc.data());
            if (!pcc.listWeeksDR.value.contains(doc.reference)) {
              pcc.listWeeksDR.value.add(doc.reference);
            }

            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 2, 1, 0),
              child: InkWell(
                child: Obx(() => Container(
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(1)),
                        border: Border.all(color: Colors.black26),
                        color: pcc.currentWeekDR.value == doc.reference
                            ? Colors.deepPurple.shade200
                            : Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                        child: Center(
                            child: Obx(() => Text(
                                wm.weekName ??
                                    "Week ${pcc.listWeeksDR.value.indexOf(doc.reference) + 1}",
                                textScaleFactor: 1.0))),
                      ),
                    )),
                onTap: () async {
                  pcc.currentWeekDR.value = doc.reference;
                  pcc.currentDayDR.value =
                      await pcc.getDayDRfromWeek(doc.reference);
                  pcc.currentTimingDR.value =
                      await pcc.getTimingDRfromDay(pcc.currentDayDR.value);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
