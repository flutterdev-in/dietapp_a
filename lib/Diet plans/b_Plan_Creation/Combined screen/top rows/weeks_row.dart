import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';

class WeeksRowForPlan extends StatelessWidget {
  const WeeksRowForPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 37,
      width: MediaQuery.of(context).size.width,
      child: Align(
        alignment: Alignment.topLeft,
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: pcc.currentPlanDR.value.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.exists) {
                DietPlanBasicInfoModel dpbim =
                    DietPlanBasicInfoModel.fromMap(snapshot.data!.data()!);
                List<WeekModel> lwm = dpbim.weekModels ?? [];

                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: lwm.length,
                    itemBuilder: (context, index) {
                      WeekModel wm = lwm[index];
                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 2, 1, 0),
                            child: InkWell(
                              child: Obx(() => Container(
                                    height: 37,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(1)),
                                      border: Border.all(color: Colors.black26),
                                      color: pcc.currentWeekIndex.value ==
                                              wm.weekIndex
                                          ? Colors.deepPurple.shade200
                                          : Colors.white,
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                      child: Center(
                                          child: Text("Week ${wm.weekIndex}",
                                              textScaleFactor: 1.0)),
                                    ),
                                  )),
                              onTap: () async {
                                pcc.currentWeekIndex.value = wm.weekIndex;
                                pcc.currentDayDR.value =
                                    await pcc.getDayDRfromWeekIndex(
                                            planDR: pcc.currentPlanDR.value,
                                            weekIndex:
                                                pcc.currentWeekIndex.value) ??
                                        pcc.currentDayDR.value;
                                pcc.currentTimingDR.value = await pcc
                                    .getTimingDRfromDay(pcc.currentDayDR.value);
                              },
                            ),
                          ),
                        ],
                      );
                    });
              } else {
                return const GFLoader();
              }
            }),
      ),
    );
  }
}
