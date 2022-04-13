import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';

class TimingsRow000PlanCreationCombinedScreen extends StatelessWidget {
  const TimingsRow000PlanCreationCombinedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 37,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Obx(() {
                if (pcc.currentWeekDR.value == userDR) {
                  return SizedBox();
                } else {
                  return FirestoreListView<Map<String, dynamic>>(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    query: pcc.currentWeekDR.value
                        .collection(daymfos.days)
                        .doc(pcc.currentDayIndex.value.toString())
                        .collection(dtmos.timings)
                        .orderBy(dtmos.timingString, descending: false),
                    itemBuilder: (context, doc) {
                      Map<String, dynamic> timingMap = doc.data();
                      if (timingMap[dtmos.timingString] != null ||
                          timingMap[dtmos.timingName] != null) {
                        DefaultTimingModel dtm =
                            DefaultTimingModel.fromMap(timingMap);
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 2, 1, 0),
                          child: InkWell(
                            child: LimitedBox(
                              maxWidth: 65,
                              child: Obx(() => Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(1)),
                                      border: Border.all(color: Colors.black26),
                                      color: (pcc.currentTimingDR.value ==
                                              doc.reference)
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
                                                maxLines: 1,
                                                textScaleFactor: 0.9),
                                          ),
                                          Text(
                                              dtmos.displayTiming(
                                                  dtm.timingString),
                                              textScaleFactor: 0.9),
                                        ],
                                      )),
                                    ),
                                  )),
                            ),
                            onTap: () async {
                              pcc.currentTimingDR.value = doc.reference;
                            },
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}