import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/Menu%20buttons/add_timing_pc.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MenuItemsPC extends StatelessWidget {
  final bool isWeekWisePlan;
  const MenuItemsPC({Key? key, required this.isWeekWisePlan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PopupMenuButton(
        padding: const EdgeInsets.all(10.0),
        color: Colors.white,
        child: const Icon(MdiIcons.dotsVertical, color: Colors.white),
        itemBuilder: (context) {
          return [
            if (!pcc.isPlanView.value)
              PopupMenuItem(
                child: TextButton(
                  onPressed: () async {
                    Get.back();
                    await deleteThisTiming();
                  },
                  child: const Text("Delete this timing"),
                ),
              ),
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {
                  Get.back();
                  await addTimingPCalertW(context);
                },
                child: const Text("Add timing               "),
              ),
            ),
            if (isWeekWisePlan)
              PopupMenuItem(
                child: TextButton(
                  onPressed: () async {
                    await addWeek();
                  },
                  child: const Text("Add Week               "),
                ),
              ),
            if (isWeekWisePlan)
              PopupMenuItem(
                child: TextButton(
                  onPressed: () async {
                    await deleteWeek();
                  },
                  child: const Text("Delete this Week           "),
                ),
              ),
            if (isWeekWisePlan)
              PopupMenuItem(
                child: TextButton(
                  onPressed: () async {
                    await clearDay();
                  },
                  child: const Text("Clear this Day           "),
                ),
              ),
            if (isWeekWisePlan == false)
              PopupMenuItem(
                child: TextButton(
                  onPressed: () async {
                    await addDay();
                  },
                  child: const Text("Add Day           "),
                ),
              ),
            if (isWeekWisePlan == false)
              PopupMenuItem(
                child: TextButton(
                  onPressed: () async {
                    await deleteDay();
                  },
                  child: const Text("Delete this Day           "),
                ),
              ),
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {
                  await deletePlan();
                },
                child: const Text("Delete this diet plan      "),
              ),
            ),
          ];
        },
      ),
    );
  }

  Future<void> deleteThisTiming() async {
    await pcc.currentTimingDR.value
        .collection(fmfpcfos.foods)
        .get()
        .then((qs) async {
      if (qs.docs.isNotEmpty) {
        for (var dr in qs.docs.toList()) {
          await dr.reference.delete();
        }
      }
    });
    await pcc.currentTimingDR.value.delete();
  }

  Future<void> addWeek() async {
    await pcc.currentPlanDR.value.get().then((qs) async {
      if (qs.data() != null) {
        DietPlanBasicInfoModel dpbim =
            DietPlanBasicInfoModel.fromMap(qs.data()!);
        int weekIndexMax = 0;
        if (dpbim.weekModels?.isNotEmpty ?? false) {
          for (var wm in dpbim.weekModels!) {
            if (weekIndexMax < wm.weekIndex) {
              weekIndexMax = wm.weekIndex;
            }
          }
        }

        pcc.currentWeekIndex.value = weekIndexMax + 1;

        List<WeekModel>? weekModels = dpbim.weekModels;
        weekModels?.add(WeekModel(weekIndex: pcc.currentWeekIndex.value));
        await pcc.currentPlanDR.value.update({
          "$unIndexed.${dietpbims.weekModels}": FieldValue.arrayUnion([
            WeekModel(weekIndex: pcc.currentWeekIndex.value).toMap(),
          ]),
        });

        pcc.currentTimingDR.value = userDR;
        pcc.currentDayDR.value = userDR;
        Get.back();
        for (int dayIndex in daymfos.listDaysIndex) {
          pcc.currentPlanDR.value
              .collection(daymfos.days)
              .add(DayModel(
                dayCreatedTime: null,
                weekIndex: pcc.currentWeekIndex.value,
                dayIndex: dayIndex,
              ).toMap())
              .then(
            (dayDR) async {
              if (pcc.currentDayDR.value == userDR) {
                pcc.currentDayDR.value = dayDR;
              }
              for (DefaultTimingModel dfm in dpbim.defaultTimings0) {
                dayDR.collection(dtmos.timings).add(dfm.toMap()).then((tDR) {
                  if (pcc.currentTimingDR.value == userDR) {
                    pcc.currentTimingDR.value = tDR;
                  }
                });
              }
            },
          );
        }
      }
    });
  }

  Future<void> deleteWeek() async {
    await pcc.currentPlanDR.value
        .collection(daymfos.days)
        .where(wmfos.weekIndex, isEqualTo: pcc.currentWeekIndex.value)
        .get()
        .then((qs) async {
      if (qs.docs.isNotEmpty) {
        for (var dayQds in qs.docs) {
          await dayQds.reference
              .collection(dtmos.timings)
              .get()
              .then((qs) async {
            if (qs.docs.isNotEmpty) {
              for (var timingQds in qs.docs) {
                await timingQds.reference
                    .collection(fmfpcfos.foods)
                    .get()
                    .then((qs) async {
                  if (qs.docs.isNotEmpty) {
                    for (var dr in qs.docs) {
                      await dr.reference.delete();
                    }
                  }
                });
                await timingQds.reference.delete();
              }
            }
          });
          dayQds.reference.delete();
        }
      }
    });

    await pcc.currentPlanDR.value.get().then((qs) async {
      if (qs.data() != null) {
        DietPlanBasicInfoModel dpbim =
            DietPlanBasicInfoModel.fromMap(qs.data()!);
        List<WeekModel> listWeekModels = dpbim.weekModels!;
        int index = 0;
        int? weekIndex;
        for (var weekModel in dpbim.weekModels!) {
          if (weekModel.weekIndex == pcc.currentWeekIndex.value) {
            weekIndex = index;
            break;
          }
          index++;
        }
        if (weekIndex != null) {
          listWeekModels.removeAt(weekIndex);
          await pcc.currentPlanDR.value.update({
            "$unIndexed.${dietpbims.weekModels}":
                listWeekModels.map((e) => e.toMap()).toList(),
          });
        }
        if (listWeekModels.isNotEmpty) {
          pcc.currentWeekIndex.value = listWeekModels.first.weekIndex;
        } else {
          pcc.currentWeekIndex.value = 0;
        }
      }
    });

    pcc.currentDayDR.value = await pcc.getDayDRfromWeekIndex(
            planDR: pcc.currentPlanDR.value,
            weekIndex: pcc.currentWeekIndex.value) ??
        userDR;

    pcc.currentTimingDR.value =
        await pcc.getTimingDRfromDay(pcc.currentDayDR.value);

    Get.back();
  }

  Future<void> addDay() async {
    await pcc.currentPlanDR.value
        .collection(daymfos.days)
        .add(DayModel(
                dayCreatedTime: Timestamp.fromDate(DateTime.now()),
                dayIndex: null,
                weekIndex: null)
            .toMap())
        .then((dayDR) async {
      Get.back();

      pcc.currentDayDR.value = dayDR;
      pcc.currentPlanDR.value.get().then((planDS) async {
        if (planDS.data() != null) {
          DietPlanBasicInfoModel dpbim =
              DietPlanBasicInfoModel.fromMap(planDS.data()!);
          pcc.currentTimingDR.value = userDR;
          for (var tm in dpbim.defaultTimings0) {
            pcc.currentDayDR.value
                .collection(dtmos.timings)
                .add(tm.toMap())
                .then((tDR) {
              if (pcc.currentTimingDR.value == userDR) {
                pcc.currentTimingDR.value = tDR;
              }
            });
          }
        }
      });
    });
  }

  Future<void> deleteDay() async {
    await pcc.currentDayDR.value
        .collection(dtmos.timings)
        .get()
        .then((qs) async {
      var listTdr = qs.docs;
      for (var tdr in listTdr) {
        await tdr.reference.collection(fmfpcfos.foods).get().then((qsf) async {
          for (var fdr in qsf.docs) {
            await fdr.reference.delete();
          }
        });
        await tdr.reference.delete();
      }
    });

    var dr = pcc.currentDayDR.value;
    await dr.delete().then((value) => pcc.listDaysDR.value.remove(dr));

    Get.back();

    await pcc.getPlanRxValues(pcc.currentPlanDR.value, isWeekWisePlan);
  }

  Future<void> clearDay() async {
    Get.back();
    await pcc.currentDayDR.value
        .collection(dtmos.timings)
        .get()
        .then((qs0) async {
      QuerySnapshot<Map<String, dynamic>> qs = qs0;
      for (QueryDocumentSnapshot<Map<String, dynamic>> dr in qs.docs) {
        await dr.reference.collection(fmfpcfos.foods).get().then((qsf) async {
          QuerySnapshot<Map<String, dynamic>> qsf0 = qsf;
          for (QueryDocumentSnapshot<Map<String, dynamic>> drf in qsf0.docs) {
            await drf.reference.delete();
          }
        });
        await dr.reference.delete();
      }
    });
  }

  Future<void> deletePlan() async {
    await pcc.currentPlanDR.value
        .collection(daymfos.days)
        .get()
        .then((qs) async {
      if (qs.docs.isNotEmpty) {
        for (var dayQds in qs.docs) {
          await dayQds.reference
              .collection(dtmos.timings)
              .get()
              .then((qs) async {
            if (qs.docs.isNotEmpty) {
              for (var timingQds in qs.docs) {
                await timingQds.reference
                    .collection(fmfpcfos.foods)
                    .get()
                    .then((qs) async {
                  if (qs.docs.isNotEmpty) {
                    for (var dr in qs.docs) {
                      await dr.reference.delete();
                    }
                  }
                });
                await timingQds.reference.delete();
              }
            }
          });
          dayQds.reference.delete();
        }
      }
      Get.back();
    });
    pcc.currentPlanDR.value.delete();
    pcc.currentPlanDR.value = userDR;
    Get.back();
  }
}
