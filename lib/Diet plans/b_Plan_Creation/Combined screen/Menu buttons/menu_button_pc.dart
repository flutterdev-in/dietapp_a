import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/Menu%20buttons/add_timing_pc.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MenuItemsPC extends StatelessWidget {
  const MenuItemsPC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PopupMenuButton(
        padding: const EdgeInsets.all(10.0),
        color: Colors.white,
        child: Icon(MdiIcons.dotsVertical, color: Colors.white),
        itemBuilder: (context) {
          return [
            if (!pcc.isPlanView.value)
              PopupMenuItem(
                child: TextButton(
                  onPressed: () async {
                    Get.back();
                    await deleteThisTiming();
                    await pcc.getCurrentTimingDR();
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
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {
                  await addWeek();
                },
                child: const Text("Add Week               "),
              ),
            ),
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {
                  await deleteWeek();
                },
                child: const Text("Delete this Week           "),
              ),
            ),
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {
                  await clearDay();
                },
                child: const Text("Clear this Day           "),
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
    await FirebaseFirestore.instance
        .doc(pcc.currentPlanDRpath.value)
        .collection(wmfos.weeks)
        .add(WeekModel(
                weekCreationTime: Timestamp.fromDate(DateTime.now()),
                notes: null,
                refURL: null)
            .toMap())
        .then((weekDR) async {
      pcc.currentWeekDR.value = weekDR;
      pcc.currentDayIndex.value = 0;
      Get.back();
      DocumentReference dr = userDR;
      for (int dayIndex in [0, 1, 2, 3, 4, 5, 6]) {
        weekDR
            .collection(daymfos.days)
            .doc(dayIndex.toString())
            .set(
                DayModel(dayIndex: dayIndex, notes: null, refURL: null).toMap())
            .then(
          (value) async {
            List<DefaultTimingModel> listTimingsInFire =
                await pcc.getDefaultTimings(isWantGross: false);
            for (DefaultTimingModel dfm in listTimingsInFire) {
              weekDR
                  .collection(daymfos.days)
                  .doc(dayIndex.toString())
                  .collection(dtmos.timings)
                  .add(dfm.toMap())
                  .then((tDR) {
                if (dr == userDR) {
                  dr = tDR;
                }
              });
            }
          },
        );
      }
      if (dr != userDR) {
        pcc.currentTimingDR.value = dr;
      }
    });
  }

  Future<void> deleteWeek() async {
    for (int dayIndex in [0, 1, 2, 3, 4, 5, 6]) {
      await pcc.currentWeekDR.value
          .collection(daymfos.days)
          .doc(dayIndex.toString())
          .collection(dtmos.timings)
          .get()
          .then((qs) async {
        QuerySnapshot<Map<String, dynamic>> qs0 = qs;
        for (QueryDocumentSnapshot<Map<String, dynamic>> dr in qs0.docs) {
          await dr.reference.delete();
        }
      });

      await pcc.currentWeekDR.value
          .collection(daymfos.days)
          .doc(dayIndex.toString())
          .delete();
    }
    Get.back();
    await pcc.currentWeekDR.value.delete();
  }

  Future<void> clearDay() async {
    Get.back();
    await pcc.currentWeekDR.value
        .collection(daymfos.days)
        .doc(pcc.currentDayIndex.value.toString())
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
    Get.back();

    await FirebaseFirestore.instance
        .doc(pcc.currentPlanDRpath.value)
        .collection(wmfos.weeks)
        .get()
        .then((qsW0) async {
      QuerySnapshot<Map<String, dynamic>> qsW = qsW0;
      for (QueryDocumentSnapshot<Map<String, dynamic>> wr in qsW.docs) {
        for (int dayIndex in [0, 1, 2, 3, 4, 5, 6]) {
          await wr.reference
              .collection(daymfos.days)
              .doc(dayIndex.toString())
              .collection(dtmos.timings)
              .get()
              .then((qs0) async {
            QuerySnapshot<Map<String, dynamic>> qs = qs0;
            for (QueryDocumentSnapshot<Map<String, dynamic>> dr in qs.docs) {
              await dr.reference
                  .collection(fmfpcfos.foods)
                  .get()
                  .then((qsf) async {
                QuerySnapshot<Map<String, dynamic>> qsf0 = qsf;
                for (QueryDocumentSnapshot<Map<String, dynamic>> drf
                    in qsf0.docs) {
                  await drf.reference.delete();
                }
              });
            }
          });

          await wr.reference
              .collection(daymfos.days)
              .doc(dayIndex.toString())
              .delete();
        }
        await wr.reference.delete();
      }
    });
    Get.back();
    await FirebaseFirestore.instance.doc(pcc.currentPlanDRpath.value).delete();
  }
}
