import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> addTimingPCalertW(
    BuildContext context, bool isForActivePlan) async {
  List<DefaultTimingModel> ldtm = [];
  List<String> listTimingsInFire = [];
  if (isForActivePlan) {
    await dtmos.getDefaultTimings().then((value) {
      ldtm = value;
    });
  } else {
    await pcc.currentPlanDR.value.get().then((docSnap) async {
      if (docSnap.exists && docSnap.data() != null) {
        DietPlanBasicInfoModel dpbim =
            DietPlanBasicInfoModel.fromMap(docSnap.data()!);
        ldtm = dpbim.planDefaulTimings;
      }
    });
  }
  await pcc.currentDayDR.value.collection(dtmos.timings).get().then((value) {
    listTimingsInFire = value.docs.map((e) {
      Map<String, dynamic> map = e.data();
      return map[dtmos.timingString].toString();
    }).toList();
  });

  List<String> listBt = ldtm.map((dtm) {
    if (listTimingsInFire.contains(dtm.timingString)) {
      return "00";
    } else {
      return dtm.timingString;
    }
  }).toList();

  listBt = listBt.toSet().toList();
  listBt.remove("00");

  if (ldtm.isNotEmpty) {
    List<int> listHours = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

    Rx<bool> isAM = true.obs;
    Rx<int> hour = 6.obs;
    Rx<int> mins = 30.obs;
    Rx<String> timingName = "".obs;

    alertDialogW(
      context,
      body: Column(children: [
        if (listBt.isNotEmpty) const Text("Select timing"),
        if (listBt.isNotEmpty)
          Column(
            children: [
              Column(
                children: ldtm.map((e) {
                  Map<String, dynamic> dm = e.toMap();
                  DefaultTimingModel dtm = DefaultTimingModel.fromMap(dm);
                  if (!listTimingsInFire.contains(dtm.timingString)) {
                    return InkWell(
                      child: Container(
                        color: Colors.black12,
                        padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            Expanded(child: Text(dtm.timingName), flex: 2),
                            Expanded(
                                child:
                                    Text(dtmos.displayTiming(dtm.timingString)),
                                flex: 1)
                          ],
                        ),
                      ),
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        Get.back();

                        if (!listTimingsInFire.contains(dtm.timingString)) {
                          if (isForActivePlan) {
                            await pcc.currentDayDR.value
                                .get()
                                .then((dayDS) async {
                              if (!dayDS.exists || dayDS.data() == null) {
                                await pcc.currentDayDR.value.set(
                                  ActiveDayModel(
                                          dayDate: admos.dateFromDayDR(
                                              pcc.currentDayDR.value),
                                          isPlanned: true,
                                          dayName: null)
                                      .toMap(),
                                  SetOptions(merge: true),
                                );
                              }
                            });
                          }
                          await pcc.currentDayDR.value
                              .collection(dtmos.timings)
                              .add(isForActivePlan
                                  ? ActiveTimingModel(
                                          timingName: dtm.timingName,
                                          timingString: dtm.timingString,
                                          isPlanned: true)
                                      .toMap()
                                  : DefaultTimingModel(
                                          timingName: dtm.timingName,
                                          timingString: dtm.timingString)
                                      .toMap())
                              .then((docRef) async {
                            pcc.currentTimingDR.value = docRef;
                          });
                        }
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                }).toList(),
              ),
              const Text("------- or Add timing --------",
                  textScaleFactor: 0.9),
            ],
          ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
              child: LimitedBox(
                maxHeight: 80,
                child: TextField(
                  autofocus: true,
                  maxLines: null,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: "Timing name",
                  ),
                  onChanged: (value) async {
                    timingName.value = value;
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: CupertinoPicker(
                    magnification: 0.9,
                    itemExtent: 40,
                    diameterRatio: 10,
                    scrollController:
                        FixedExtentScrollController(initialItem: 5),
                    onSelectedItemChanged: (v) {
                      hour.value = listHours[v];
                    },
                    children: listHours
                        .map((e) => Center(
                                child: Text(
                              e.toString(),
                              textScaleFactor: 1,
                            )))
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 70,
                  child: CupertinoPicker(
                    magnification: 0.9,
                    itemExtent: 40,
                    diameterRatio: 10,
                    scrollController:
                        FixedExtentScrollController(initialItem: 2),
                    onSelectedItemChanged: (v) {
                      mins.value = [0, 15, 30, 45][v];
                    },
                    children: ["00", "15", "30", "45"]
                        .map((e) => Center(
                                child: Text(
                              e.toString(),
                              textScaleFactor: 1,
                            )))
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 70,
                  child: CupertinoPicker(
                    magnification: 0.9,
                    itemExtent: 40,
                    diameterRatio: 10,
                    scrollController:
                        FixedExtentScrollController(initialItem: 0),
                    onSelectedItemChanged: (v) {
                      isAM.value = v == 0 ? true : false;
                    },
                    children: ["AM", "PM"]
                        .map((e) => Center(
                                child: Text(
                              e.toString(),
                              textScaleFactor: 1,
                            )))
                        .toList(),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      String ts = dtmos.timingStringF(
                          hour.value, mins.value, isAM.value);
                      FocusScope.of(context).unfocus();
                      Get.back();

                      if (!listTimingsInFire.contains(ts)) {
                        if (isForActivePlan) {
                          await pcc.currentDayDR.value
                              .get()
                              .then((dayDS) async {
                            if (!dayDS.exists || dayDS.data() == null) {
                              await pcc.currentDayDR.value.set(
                                ActiveDayModel(
                                        dayDate: admos.dateFromDayDR(
                                            pcc.currentDayDR.value),
                                        isPlanned: true,
                                        dayName: null)
                                    .toMap(),
                                SetOptions(merge: true),
                              );
                            }
                          });
                        }

                        await pcc.currentDayDR.value
                            .collection(dtmos.timings)
                            .add(isForActivePlan
                                ? ActiveTimingModel(
                                        timingName: timingName.value,
                                        timingString: ts,
                                        isPlanned: true)
                                    .toMap()
                                : DefaultTimingModel(
                                        timingName: timingName.value,
                                        timingString: ts)
                                    .toMap())
                            .then((value) async {
                          if (!isForActivePlan) {
                            ldtm.add(DefaultTimingModel(
                                timingName: timingName.value,
                                timingString: ts));
                            await FirebaseFirestore.instance
                                .doc(pcc.currentPlanDRpath.value)
                                .update({
                              dietpbims.planDefaultTimings:
                                  ldtm.map((e) => e.toMap()).toList()
                            });
                          }

                          pcc.currentTimingDR.value = value;
                        });
                      }
                    },
                    child: const Text("Add")),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ]),
    );
  }
}
