import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/_plan_creation_combined_screen.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/x_Browser/_browser_main_screen.dart';
import 'package:dietapp_a/x_Browser/controllers/browser_controllers.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PlanCreationScreen extends StatelessWidget {
  PlanCreationScreen({Key? key}) : super(key: key);
  final Rx<bool> isWeekPlan = true.obs;
  final Rx<String> planName = "Diet plan".obs;
  final Rx<String> notes = "".obs;
  final listDefaultTimingModels = listDefaultTimingModels0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Plan")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
            onPressed: () async {
              if (planName.value.isNotEmpty) {
                await continueButton();
              }
            },
            child: const Text("Create"))
    ,
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
                  decoration: const InputDecoration(
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
            const SizedBox(height: 5),
            planType(),
            const Divider(thickness: 3),
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
            const Text("  Ref URL"),
            IconButton(
                onPressed: () {
                  bc.isBrowserForRefURL.value = true;
                  Get.to(const AddFoodScreen());
                },
                icon: const Icon(MdiIcons.webPlus)),
          ],
        ));
      } else {
        return GFListTile(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
          avatar: Obx(
              () => bc.currentRefUrlMetadataModel.value == rummfos.constModel
                  ? const SizedBox()
                  : GFAvatar(
                      shape: GFAvatarShape.standard,
                      size: GFSize.MEDIUM,
                      maxRadius: 20,
                      backgroundImage: NetworkImage(
                          bc.currentRefUrlMetadataModel.value.img ?? ""),
                    )),
          title: Text(
            bc.currentURL.value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          icon: IconButton(
              onPressed: () {
                bc.isBrowserForRefURL.value = true;
                Get.to(const AddFoodScreen());
              },
              icon: const Icon(MdiIcons.webSync)),
        );
      }
    });
  }

  Widget planType() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text("Plan model"),
            ),
            GFButton(
              onPressed: () {
                if (isWeekPlan.value == false) {
                  isWeekPlan.value = true;
                }
              },
              child: const Text("Week wise"),
              type: isWeekPlan.value
                  ? GFButtonType.outline2x
                  : GFButtonType.transparent,
            ),
            GFButton(
              onPressed: () {
                if (isWeekPlan.value == true) {
                  isWeekPlan.value = false;
                }
              },
              child: const Text("Day wise"),
              type: !isWeekPlan.value
                  ? GFButtonType.outline2x
                  : GFButtonType.transparent,
            ),
          ],
        ));
  }

  Widget timingsW(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("  Default timings"),
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
                physics: const ScrollPhysics(),
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
                              listDefaultTimingModels.remove(dftm);
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
              decoration: const InputDecoration(
                labelText: "Timing name",
              ),
              onChanged: (value) {
                timingName.value = value;
              },
            ),
          ),
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
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
        const SizedBox(height: 30),
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
              child: const Text("Add")),
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
                isWeekWisePlan: isWeekPlan.value,
                notes: notes.value,
                planCreationTime: timestampNow,
                rumm: await rummfos.rummModel(refURL),
                defaultTimings: listDefaultTimingModels.value,
                defaultTimings0: listDefaultTimingModels.value)
            .toMap())
        .then((planDocRef) async {
      pcc.currentPlanDR.value = planDocRef;
      pcc.currentTimingDR.value = userDR;
      pcc.currentDayDR.value = userDR;
      Get.back();
      Get.to(PlanCreationCombinedScreen(
        isWeekWisePlan: isWeekPlan.value,
      ));

      if (isWeekPlan.value) {
        pcc.currentWeekDR.value = userDR;
        await planDocRef
            .collection(wmfos.weeks)
            .add(WeekModel(weekCreatedTime: Timestamp.fromDate(DateTime.now()))
                .toMap())
            .then((weekDR) async {
          pcc.currentWeekDR.value = weekDR;
          for (int dayIndex in daymfos.listDaysIndex) {
            weekDR
                .collection(daymfos.days)
                .add(DayModel(
                  dayCreatedTime: null,
                  dayIndex: dayIndex,
                ).toMap())
                .then(
              (dayDR) async {
                if (pcc.currentDayDR.value == userDR) {
                  pcc.currentDayDR.value = dayDR;
                }
                for (DefaultTimingModel dfm in listDefaultTimingModels.value) {
                  dayDR.collection(dtmos.timings).add(dfm.toMap()).then((tDR) {
                    if (pcc.currentTimingDR.value == userDR) {
                      pcc.currentTimingDR.value = tDR;
                    }
                  });
                }
              },
            );
          }
        });
      } else {
        planDocRef
            .collection(daymfos.days)
            .add(DayModel(
              dayCreatedTime: timestampNow,
              dayIndex: null,
            ).toMap())
            .then(
          (dayDocRef) async {
            pcc.currentDayDR.value = dayDocRef;
            for (DefaultTimingModel dfm in listDefaultTimingModels.value) {
              dayDocRef.collection(dtmos.timings).add(dfm.toMap()).then((tDR) {
                if (pcc.currentTimingDR.value == userDR) {
                  pcc.currentTimingDR.value = tDR;
                }
              });
            }
          },
        );
      }
    });
  }
}
