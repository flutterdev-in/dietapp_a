import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';

Widget timingsRow000PlanCreationCombinedScreen() {
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
                  query: pcc.timingsCRq(),
                  itemBuilder: (context, doc) {
                    Map<String, dynamic> timingMap = doc.data();
                    if (pcc.curreTimingDRpath.value.isEmpty) {
                      
                      pcc.curreTimingDRpath.value = doc.reference.path;
                    }

                    DefaultTimingModel dtm =
                        DefaultTimingModel.fromMap(timingMap);
                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: InkWell(
                        child: LimitedBox(
                          maxWidth: 75,
                          child: Obx(() => Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1)),
                                  border: Border.all(color: Colors.black26),
                                  color: pcc.curreTimingDRpath.value ==
                                          doc.reference.path
                                      ? Colors.deepPurple.shade200
                                      : Colors.white,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                  child: Center(
                                      child: Column(
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(dtm.timingName,
                                            maxLines: 1, textScaleFactor: 0.9),
                                      ),
                                      Text(
                                          "${dtm.hour}.${dtm.timingString.substring(4)}${dtm.timingString.substring(0, 2)}",
                                          textScaleFactor: 0.8),
                                    ],
                                  )),
                                ),
                              )),
                        ),
                        onTap: () {
                          pcc.curreTimingDRpath.value = doc.reference.path;
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
