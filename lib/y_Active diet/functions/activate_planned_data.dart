import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:dietapp_a/y_Active%20diet/functions/active_model_from_planned_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_food_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_plan_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';

ActivatePlannedData activatePlannedData = ActivatePlannedData();

class ActivatePlannedData {
  //
  Future<void> singlePlan({
    required DateTime startDate,
    required DocumentReference<Map<String, dynamic>> plannedPlanDR,
  }) async {
    await plannedPlanDR.get().then((planDS) async {
      if (planDS.data() != null) {
        int daysNos = 0;
        var plannedDP = DietPlanBasicInfoModel.fromMap(planDS.data()!);
        if (plannedDP.isWeekWisePlan) {
          await plannedPlanDR
              .collection(wmfos.weeks)
              .orderBy(wmfos.weekCreatedTime, descending: false)
              .get()
              .then((wQS) async {
            if (wQS.docs.isNotEmpty) {
              daysNos = await multiWeek(
                startDate: startDate,
                listPlannedWeekQDS: wQS.docs,
                listPlannedWeekDRs: wQS.docs.map((e) => e.reference).toList(),
              );
            }
          });
        } else {
          await plannedPlanDR
              .collection(daymfos.days)
              .orderBy(daymfos.dayCreatedTime, descending: false)
              .get()
              .then((dQS) async {
            if (dQS.docs.isNotEmpty) {
              daysNos = await multiDay(
                startDate: startDate,
                listPlannedDayQDS: dQS.docs,
                listPlannedDayDRs: dQS.docs.map((e) => e.reference).toList(),
              );
            }
          });
        }
        await userDR.collection(apmos.activeDietPlansInfo).add(amfpm
            .planModel(
                dpm: DietPlanBasicInfoModel.fromMap(planDS.data()!),
                startDate: startDate,
                endTime: startDate.add(Duration(days: daysNos)))
            .toMap());
      }
    });
  }

  //
  Future<int> multiWeek({
    required DateTime startDate,
    required List<QueryDocumentSnapshot<Map<String, dynamic>>>?
        listPlannedWeekQDS,
    required List<DocumentReference<Map<String, dynamic>>> listPlannedWeekDRs,
  }) async {
    for (var plannedWeekDR in listPlannedWeekDRs) {
      int index = listPlannedWeekDRs.indexOf(plannedWeekDR);
      await singleWeek(
        startDate: startDate.add(Duration(days: 7 * index)),
        plannedWeekDR: plannedWeekDR,
      );
    }
    return (listPlannedWeekQDS?.length ?? listPlannedWeekDRs.length) * 7;
  }

  //
  Future<int> multiDay({
    required DateTime startDate,
    required List<QueryDocumentSnapshot<Map<String, dynamic>>>?
        listPlannedDayQDS,
    required List<DocumentReference<Map<String, dynamic>>> listPlannedDayDRs,
  }) async {
    if (listPlannedDayQDS != null) {
      for (var plannedDayQDS in listPlannedDayQDS) {
        await singleDay(
          plannedDayDataMap: plannedDayQDS.data(),
          plannedDayDR: plannedDayQDS.reference,
          date: startDate
              .add(Duration(days: listPlannedDayQDS.indexOf(plannedDayQDS))),
        );
      }
    } else {
      for (var plannedDayDR in listPlannedDayDRs) {
        await singleDay(
          plannedDayDataMap: null,
          plannedDayDR: plannedDayDR,
          date: startDate
              .add(Duration(days: listPlannedDayDRs.indexOf(plannedDayDR))),
        );
      }
    }
    return listPlannedDayQDS?.length ?? listPlannedDayDRs.length;
  }

//
  Future<void> multiTiming({
    required List<QueryDocumentSnapshot<Map<String, dynamic>>>?
        listPlannedTimingQDS,
    required List<DocumentReference<Map<String, dynamic>>> listPlannedTimingDR,
    required DateTime date,
  }) async {
    if (listPlannedTimingQDS != null) {
      for (var plannedTimingQDS in listPlannedTimingQDS) {
        await singleTiming(
            plannedTimingDataMap: plannedTimingQDS.data(),
            plannedTimingDR: plannedTimingQDS.reference,
            date: date);
      }
    } else {
      for (var plannedTimingDR in listPlannedTimingDR) {
        await singleTiming(
            plannedTimingDataMap: null,
            plannedTimingDR: plannedTimingDR,
            date: date);
      }
    }
  }

//
  Future<void> multiFood({
    required DocumentReference<Map<String, dynamic>> activeTimingDR,
    required List<FoodsModelForPlanCreation> listPlannedFMs,
  }) async {
    for (var plannedFM in listPlannedFMs) {
      await singleFood(activeTimingDR: activeTimingDR, plannedFM: plannedFM);
    }
  }

//
  Future<void> singleWeek({
    required DateTime startDate,
    required DocumentReference<Map<String, dynamic>> plannedWeekDR,
  }) async {
    await plannedWeekDR
        .collection(daymfos.days)
        .orderBy(daymfos.dayIndex, descending: false)
        .get()
        .then((dqs) async {
      for (var dQDS in dqs.docs) {
        await singleDay(
          plannedDayDataMap: dQDS.data(),
          plannedDayDR: dQDS.reference,
          date: startDate.add(Duration(days: dqs.docs.indexOf(dQDS))),
        );
      }
    });
  }

//
  Future<void> singleDay({
    required Map<String, dynamic>? plannedDayDataMap,
    required DocumentReference<Map<String, dynamic>> plannedDayDR,
    required DateTime date,
  }) async {
    Future<void> proceed(Map<String, dynamic> map) async {
      var pdm = DayModel.fromMap(map);
      var adm = amfpm.dayModel(
        pdm: pdm,
        date: date,
      );

      await admos
          .activeDayDR(date)
          .set(adm.toMap(), SetOptions(merge: true))
          .then((value) async {
        await plannedDayDR.collection(dtmos.timings).get().then((tqs) async {
          if (tqs.docs.isNotEmpty) {
            for (var tqds in tqs.docs) {
              await singleTiming(
                  plannedTimingDataMap: tqds.data(),
                  plannedTimingDR: tqds.reference,
                  date: date);
            }
          }
        });
      });
    }

    if (plannedDayDataMap == null) {
      await plannedDayDR.get().then((dds) async {
        if (dds.exists && dds.data() != null) {
          await proceed(dds.data()!);
        }
      });
    } else {
      await proceed(plannedDayDataMap);
    
    }
  }

//

//

  Future<void> singleTiming({
    required Map<String, dynamic>? plannedTimingDataMap,
    required DocumentReference<Map<String, dynamic>> plannedTimingDR,
    required DateTime date,
  }) async {
    Future<void> proceed(Map<String, dynamic> map) async {
      var dtm = DefaultTimingModel.fromMap(map);
      var atm = amfpm.timingModel(dtm: dtm, date: date);
      var atmDR = admos
          .activeDayDR(date)
          .collection(atmos.timings)
          .doc(atm.timingString);
      await atmDR.set(atm.toMap(), SetOptions(merge: true)).then((value) async {
        await plannedTimingDR
            .collection(fmfpcfos.foods)
            .get()
            .then((fqs) async {
          if (fqs.docs.isNotEmpty) {
            for (var fqd in fqs.docs) {
              var pfm = FoodsModelForPlanCreation.fromMap(fqd.data());
              await singleFood(activeTimingDR: atmDR, plannedFM: pfm);
            }
          }
        });
      });
    }

    if (plannedTimingDataMap == null) {
      await plannedTimingDR.get().then((tds) async {
        if (tds.exists && tds.data() != null) {
          await proceed(tds.data()!);
        }
      });
    } else {
      await proceed(plannedTimingDataMap);
    }
  }

//
  Future<void> singleFood({
    required DocumentReference<Map<String, dynamic>> activeTimingDR,
    required FoodsModelForPlanCreation plannedFM,
  }) async {
    var afm = amfpm.foodModel(plannedFM);
    await activeTimingDR.collection(afmos.foods).add(afm.toMap());
  }
}
