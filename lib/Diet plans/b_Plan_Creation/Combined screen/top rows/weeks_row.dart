import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';

Widget weeksRow000PlanCreationCombinedScreen() {
  return SizedBox(
    width: Get.width,
    height: 35,
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 10, 2),
            child: Obx(() {
              List<DocumentReference<Map<String, dynamic>>> ld = [];
              return FirestoreListView<Map<String, dynamic>>(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                query: FirebaseFirestore.instance
                    .doc(pcc.currentPlanDRpath.value)
                    .collection(wmfos.weeks)
                    .orderBy(wmfos.weekCreationTime, descending: false),
                itemBuilder: (context, doc) {
                  ld.add(doc.reference);

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2, 1, 0),
                    child: InkWell(
                      child: Obx(() => Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1)),
                              border: Border.all(color: Colors.black26),
                              color: pcc.currentWeekDR.value == doc.reference
                                  ? Colors.deepPurple.shade200
                                  : Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                              child: Center(
                                  child: Text(
                                      pcc.weekName(ld.indexOf(doc.reference)),
                                      textScaleFactor: 1.0)),
                            ),
                          )),
                      onTap: () async {
                        pcc.currentWeekDR.value = doc.reference;
                        await pcc.getCurrentTimingDR();
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ],
    ),
  );
}
