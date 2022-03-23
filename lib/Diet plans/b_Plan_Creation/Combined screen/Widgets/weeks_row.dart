import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';

Widget weeksRow000PlanCreationCombinedScreen() {
  return SizedBox(
    width: Get.width,
    height: 40,
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(1.2, 0, 10, 0),
            child: Obx(() => FirestoreListView<Map<String, dynamic>>(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  query: FirebaseFirestore.instance
                      .doc(pcc.currentPlanDRpath.value)
                      .collection(wmfos.weeks)
                      .orderBy(wmfos.weekIndex, descending: false),
                  itemBuilder: (context, doc) {
                    Map<String, dynamic> weekMap = doc.data();
                    WeekModel wm = WeekModel.fromMap(weekMap);
                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: InkWell(
                        child: Obx(() => Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(1)),
                                border: Border.all(color: Colors.black26),
                                color:
                                    pcc.currentWeekIndex.value == wm.weekIndex
                                        ? Colors.deepPurple.shade200
                                        : Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                child: Center(
                                    child: Text(pcc.weekName(wm.weekIndex))),
                              ),
                            )),
                        onTap: () {
                          pcc.currentWeekIndex.value = wm.weekIndex;
                        },
                      ),
                    );
                  },
                )),
          ),
        ),
      ],
    ),
  );
}
