import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/Menu%20buttons/activate_plan_menu_items.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/Menu%20buttons/add_timing_pc.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/y_Models/day_model.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:dietapp_a/y_Models/timing_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MenuItemsPC extends StatelessWidget {
  final bool isWeekWisePlan;
  final bool isForActivePlan;
  const MenuItemsPC(
      {Key? key, required this.isForActivePlan, required this.isWeekWisePlan})
      : super(key: key);

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
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {
                  Get.back();
                  await addTimingPCalertW(context, isForActivePlan);
                },
                child: const Text("Add timing               "),
              ),
            ),
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
            if (isWeekWisePlan && !isForActivePlan)
              PopupMenuItem(
                child: TextButton(
                  onPressed: () async {
                    await addWeek();
                  },
                  child: const Text("Add Week               "),
                ),
              ),
            if (isWeekWisePlan && !isForActivePlan)
              PopupMenuItem(
                child: TextButton(
                  onPressed: () async {
                    await deleteWeek();
                  },
                  child: const Text("Delete this Week           "),
                ),
              ),
            if (!isWeekWisePlan && !isForActivePlan)
              PopupMenuItem(
                child: TextButton(
                  onPressed: () async {
                    await addDay();
                  },
                  child: const Text("Add Day           "),
                ),
              ),
            PopupMenuItem(
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: pcc.currentDayDR.value.snapshots(),
                  builder: (context, snapshot) {
                    String? notes;
                    if (snapshot.hasData && snapshot.data!.data() != null) {
                      if (pcc.currentDayDR.value.parent.id ==
                          admos.activeDaysPlan) {
                        var dm = DayModel.fromMap(snapshot.data!.data()!);
                        notes = dm.notes;
                      } else {
                        var dm = DayModel.fromMap(snapshot.data!.data()!);
                        notes = dm.notes;
                      }
                    }
                    return TextButton(
                      onPressed: () async {
                        dayNotes(context, notes);
                      },
                      child: Text(
                          "${notes != null ? 'Edit day notes' : 'Add day notes'}        "),
                    );
                  }),
            ),
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {
                  await clearDay();
                },
                child: const Text("Clear this Day           "),
              ),
            ),
            if (!isWeekWisePlan && !isForActivePlan)
              PopupMenuItem(
                child: TextButton(
                  onPressed: () async {
                    await deleteDay();
                  },
                  child: const Text("Delete this Day           "),
                ),
              ),
            if (!isForActivePlan)
              PopupMenuItem(
                child: TextButton(
                  onPressed: () async {
                    await deletePlan();
                  },
                  child: const Text("Delete this diet plan      "),
                ),
              ),
            if (!isForActivePlan)
              PopupMenuItem(
                child: TextButton(
                  onPressed: () async {
                    Get.back();
                    if (isWeekWisePlan) {
                      activatePlanMenuItems.activateWeekPlan(context);
                    } else {
                      activatePlanMenuItems.activateDayPlan(context);
                    }
                  },
                  child: const Text("Activate Plan      "),
                ),
              ),
            if (isWeekWisePlan && !isForActivePlan)
              PopupMenuItem(
                child: TextButton(
                  onPressed: () async {
                    Get.back();
                    activatePlanMenuItems.activateThisWeek(context);
                  },
                  child: const Text("Activate This Week      "),
                ),
              ),
            if (!isForActivePlan)
              PopupMenuItem(
                child: TextButton(
                  onPressed: () async {
                    Get.back();
                    activatePlanMenuItems.activateThisDay(context);
                  },
                  child: const Text("Activate This Day      "),
                ),
              ),
            if (!isForActivePlan)
              PopupMenuItem(
                child: TextButton(
                  onPressed: () async {
                    Get.back();
                    activatePlanMenuItems.activateThisTiming(context);
                  },
                  child: const Text("Activate This Timing      "),
                ),
              ),
          ];
        },
      ),
    );
  }

  Future<void> deleteThisTiming() async {
    if (pcc.currentTimingDR.value != userDR) {
      await pcc.currentTimingDR.value
          .collection(fmos.foods)
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
  }

  Future<void> addWeek() async {
    await pcc.currentPlanDR.value
        .collection(wmfos.weeks)
        .add(WeekModel(weekCreatedTime: Timestamp.fromDate(DateTime.now()))
            .toMap())
        .then((weekDR) {
      pcc.currentWeekDR.value = weekDR;
      pcc.currentTimingDR.value = userDR;
      pcc.currentDayDR.value = userDR;
      Get.back();
      pcc.currentPlanDR.value.get().then((pDS) async {
        if (pDS.data() != null) {
          DietPlanBasicInfoModel dpbim =
              DietPlanBasicInfoModel.fromMap(pDS.data()!);
          for (int dayIndex in daymfos.listDaysIndex) {
            weekDR
                .collection(daymfos.days)
                .add(DayModel(
                        dayDate: null,
                        dayCreatedTime: null,
                        dayIndex: dayIndex,
                        dayName: null,
                        notes: null,
                        rumm: null,
                        docRef: null)
                    .toMap())
                .then(
              (dayDR) async {
                if (pcc.currentDayDR.value == userDR) {
                  pcc.currentDayDR.value = dayDR;
                }
                for (TimingModel dfm in dpbim.planDefaulTimings) {
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
    });
  }

  Future<void> deleteWeek() async {
    await pcc.currentWeekDR.value
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
                    .collection(fmos.foods)
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

    await pcc.currentWeekDR.value.delete();
    pcc.listWeeksDR.value.remove(pcc.currentWeekDR.value);
    pcc.currentWeekDR.value =
        await pcc.getWeekDRfromPlan(pcc.currentPlanDR.value);
    pcc.currentDayDR.value =
        await pcc.getDayDRfromWeek((pcc.currentWeekDR.value));
    pcc.currentTimingDR.value =
        await pcc.getTimingDRfromDay(pcc.currentDayDR.value);

    Get.back();
  }

  Future<void> addDay() async {
    await pcc.currentPlanDR.value
        .collection(daymfos.days)
        .add(DayModel(
                dayDate: null,
                dayCreatedTime: DateTime.now(),
                dayIndex: null,
                dayName: null,
                notes: null,
                rumm: null,
                docRef: null)
            .toMap())
        .then((dayDR) async {
      Get.back();

      pcc.currentDayDR.value = dayDR;
      pcc.currentPlanDR.value.get().then((planDS) async {
        if (planDS.data() != null) {
          DietPlanBasicInfoModel dpbim =
              DietPlanBasicInfoModel.fromMap(planDS.data()!);
          pcc.currentTimingDR.value = userDR;
          for (var tm in dpbim.planDefaulTimings) {
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

  void dayNotes(BuildContext context, String? notes) {
    Get.back();
    textFieldAlertW(context, text: notes, onPressedConfirm: (value) async {
      if (value != null && value.isNotEmpty) {
        await pcc.currentDayDR.value.update({
          "$unIndexed.$notes0": value,
        });
        Navigator.of(context, rootNavigator: true).pop();
        // Get.back();
      }
    });
  }

  Future<void> deleteDay() async {
    await pcc.currentDayDR.value
        .collection(dtmos.timings)
        .get()
        .then((qs) async {
      var listTdr = qs.docs;
      for (var tdr in listTdr) {
        await tdr.reference.collection(fmos.foods).get().then((qsf) async {
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
        await dr.reference.collection(fmos.foods).get().then((qsf) async {
          QuerySnapshot<Map<String, dynamic>> qsf0 = qsf;
          for (QueryDocumentSnapshot<Map<String, dynamic>> drf in qsf0.docs) {
            await drf.reference.delete();
          }
        });
        await dr.reference.delete();
      }
    });

    if (isForActivePlan) {
      await pcc.currentDayDR.value.delete();
    }
  }

  Future<void> deletePlan() async {
    Future<void> deleteFromDays(
        DocumentReference<Map<String, dynamic>> parentDR) async {
      await parentDR.collection(daymfos.days).get().then((qs) async {
        if (qs.docs.isNotEmpty) {
          for (var dayQds in qs.docs) {
            await dayQds.reference
                .collection(dtmos.timings)
                .get()
                .then((qs) async {
              if (qs.docs.isNotEmpty) {
                for (var timingQds in qs.docs) {
                  await timingQds.reference
                      .collection(fmos.foods)
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
    }

    if (isWeekWisePlan) {
      pcc.currentPlanDR.value.collection(wmfos.weeks).get().then((wQS) async {
        if (wQS.docs.isNotEmpty) {
          for (var weekQds in wQS.docs) {
            await deleteFromDays(weekQds.reference);
            await weekQds.reference.delete();
          }
        }
      });
    } else {
      await deleteFromDays(pcc.currentPlanDR.value);
    }

    pcc.currentPlanDR.value.delete();
    pcc.currentPlanDR.value = userDR;
    Get.back();
  }
}
