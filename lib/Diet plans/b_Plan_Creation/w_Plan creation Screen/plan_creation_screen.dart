import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/_plan_creation_combined_screen.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/constsnts/const_objects_pc.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/add_food_sreen.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/browser_controllers.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:dietapp_a/x_customWidgets/colors.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PlanCreationScreen extends StatelessWidget {
  PlanCreationScreen({Key? key}) : super(key: key);
  final Rx<String> planName = "".obs;
  final Rx<String> notes = "".obs;
  final listDefaultTimingModels = RxList<DefaultTimingModel>([
    DefaultTimingModel(
        timingName: "Breakfast", timingString: dtmos.timingStringF(8, 0, true)),
    DefaultTimingModel(
        timingName: "Morning snacks",
        timingString: dtmos.timingStringF(10, 30, true)),
    DefaultTimingModel(
        timingName: "Lunch", timingString: dtmos.timingStringF(1, 30, false)),
    DefaultTimingModel(
        timingName: "Evening snacks",
        timingString: dtmos.timingStringF(5, 30, false)),
    DefaultTimingModel(
        timingName: "Dinner", timingString: dtmos.timingStringF(9, 00, false)),
  ]).obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Plan")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(() {
        bool isEmpty = planName.value.isEmpty;
        return ElevatedButton(
            onPressed: () async {
              if (planName.value.isNotEmpty) {
                await continueButton();
              }
            },
            child: Text("Create"));
      }),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: ListView(
          shrinkWrap: true,
          children: [
            Card(
              child: LimitedBox(
                maxHeight: 80,
                child: TextField(
                  maxLines: null,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(7),
                    labelText: "Plan Name*",
                  ),
                  onChanged: (value) {
                    planName.value = value;
                  },
                ),
              ),
            ),
            Card(
              child: LimitedBox(
                maxHeight: 150,
                child: TextField(
                  maxLines: null,
                  autofocus: false,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(7),
                    labelText: "Notes",
                  ),
                  onChanged: (value) {
                    notes.value = value;
                  },
                ),
              ),
            ),
            refURL(),
            SizedBox(height: 5),
            timingsW(context),
          ],
        ),
      ),
    );
  }

  Widget refURL() {
    return Obx(() {
      if (bc.currentURL.value == "https://m.youtube.com/") {
        return Card(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("  Ref URL"),
            IconButton(
                onPressed: () {
                  bc.isBrowserForRefURL.value = true;
                  Get.to(AddFoodScreen());
                },
                icon: Icon(MdiIcons.webPlus)),
          ],
        ));
      } else {
        return GFListTile(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
          avatar: Obx(() => bc.currentRefURLimageURL.value.isEmpty
              ? SizedBox()
              : GFAvatar(
                  shape: GFAvatarShape.standard,
                  size: GFSize.MEDIUM,
                  maxRadius: 20,
                  backgroundImage: NetworkImage(bc.currentRefURLimageURL.value),
                )),
          title: Text(
            bc.currentURL.value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          icon: IconButton(
              onPressed: () {
                bc.isBrowserForRefURL.value = true;
                Get.to(AddFoodScreen());
              },
              icon: Icon(MdiIcons.webSync)),
        );
      }
    });
  }

  Widget timingsW(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("  Default timings"),
              IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    alertDialogueW(context, body: alertBodyW(context));
                  },
                  icon: const Icon(MdiIcons.plus)),
            ],
          ),
          Obx(
            () {
              List<DefaultTimingModel> listDTMsorted =
                  dtmos.foodTimingsListSort(listDefaultTimingModels.value);
              return ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: listDTMsorted.length,
                itemBuilder: (context, index) {
                  DefaultTimingModel dftm = listDTMsorted[index];

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Text(
                                    dftm.timingName,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                    child: Align(
                                      child: Text(dtmos
                                          .displayTiming(dftm.timingString)),
                                      alignment: Alignment.centerRight,
                                    ),
                                    flex: 4),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            splashColor: primaryColor,
                            child: const SizedBox(
                                child: Icon(MdiIcons.close, size: 17),
                                width: 20),
                            onTap: () async {
                              await Future.delayed(
                                  const Duration(milliseconds: 200));
                              listDefaultTimingModels.value.remove(dftm);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget alertBodyW(BuildContext context) {
    List<int> listHours = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

    Rx<bool> isAM = true.obs;
    Rx<int> hour = 6.obs;
    Rx<int> mins = 30.obs;
    Rx<String> timingName = "".obs;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
          child: LimitedBox(
            maxHeight: 80,
            child: TextField(
              autofocus: true,
              maxLines: null,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: "Timing name",
              ),
              onChanged: (value) {
                timingName.value = value;
              },
            ),
          ),
        ),
        SizedBox(height: 30),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(MdiIcons.clockTimeEightOutline, size: 30),
            ),
            SizedBox(
              height: 60,
              width: 70,
              child: CupertinoPicker(
                magnification: 0.9,
                itemExtent: 40,
                diameterRatio: 10,
                scrollController: FixedExtentScrollController(initialItem: 5),
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
                scrollController: FixedExtentScrollController(initialItem: 2),
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
                scrollController: FixedExtentScrollController(initialItem: 0),
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
          ],
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () async {
                FocusScope.of(context).unfocus();
                Get.back();
                if (timingName.value.isNotEmpty) {
                  DefaultTimingModel dtm = DefaultTimingModel(
                    timingName: timingName.value.trim(),
                    timingString:
                        dtmos.timingStringF(hour.value, mins.value, isAM.value),
                  );
                  String s = dtm.timingString;
                  List<String> ls = listDefaultTimingModels.value
                      .map((m) => m.timingString)
                      .toList();
                  if (!ls.contains(s)) {
                    await Future.delayed(const Duration(milliseconds: 600));
                    listDefaultTimingModels.value.add(dtm);
                  }
                }
              },
              child: Text("Add")),
        )
      ],
    );
  }

  Future<void> continueButton() async {
    String dietPlans = "dietPlansBeta";
    String? refURL;
    if (bc.currentURL.value != "https://m.youtube.com/") {
      refURL = bc.currentURL.value;
    }
    await userDR
        .collection(dietPlans)
        .add(DietPlanBasicInfoModel(
                planName: planName.value,
                notes: notes.value,
                planCreationTime: Timestamp.fromDate(DateTime.now()),
                refURL: refURL,
                defaultTimings: listDefaultTimingModels.value
                    .map((tm) => tm.toMap())
                    .toList())
            .toMap())
        .then((planDocRef) async {
      pcc.currentPlanDRpath.value = planDocRef.path;
      for (int weekIndex in [0, 1, 2, 3]) {
        await planDocRef.collection(wmfos.weeks).doc(weekIndex.toString()).set(
            WeekModel(weekIndex: weekIndex, notes: null, refURL: null).toMap());
      }
      pcc.currentPlanName.value = planName.value;
      Get.back();
      Get.to(PlanCreationCombinedScreen());
      for (int weekIndex in [0, 1, 2, 3]) {
        for (int dayIndex in [0, 1, 2, 3, 4, 5, 6]) {
          planDocRef
              .collection(wmfos.weeks)
              .doc(weekIndex.toString())
              .collection(daymfos.days)
              .doc(dayIndex.toString())
              .set(DayModel(dayIndex: dayIndex, notes: null, refURL: null)
                  .toMap())
              .then((value) async {
            for (DefaultTimingModel dfm in listDefaultTimingModels.value) {
              planDocRef
                  .collection(wmfos.weeks)
                  .doc(weekIndex.toString())
                  .collection(daymfos.days)
                  .doc(dayIndex.toString())
                  .collection(dtmos.timings)
                  .add(dfm.toMap())
                  .then((docRef) {
                if (pcc.currentTimingDR.value == userDR) {
                  pcc.currentTimingDR.value = docRef;
                }
              });
            }
          });
        }
      }
      ;
    });

    // await Future.delayed(Duration)
  }
}
