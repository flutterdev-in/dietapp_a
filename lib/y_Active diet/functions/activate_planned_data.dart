import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/y_Models/day_model.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:dietapp_a/y_Models/timing_model.dart';

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
      }
    });
  }

  //

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

//
  Future<void> singleWeek({
    required DateTime startDate,
    required DocumentReference<Map<String, dynamic>> plannedWeekDR,
  }) async {
    var weekQuery = plannedWeekDR
        .collection(daymfos.days)
        .orderBy(daymfos.dayIndex, descending: false);
    //
    if (startDate.weekday != DateTime.monday) {
      weekQuery = plannedWeekDR
          .collection(daymfos.days)
          .where(daymfos.dayIndex, isGreaterThanOrEqualTo: startDate.weekday)
          .orderBy(daymfos.dayIndex, descending: false);
    }

    await weekQuery.get().then((dqs) async {
      await multiDay(
          startDate: startDate,
          listPlannedDayQDS: dqs.docs,
          listPlannedDayDRs: dqs.docs.map((e) => e.reference).toList());
    });
  }

  //
  Future<int> multiWeek({
    required DateTime startDate,
    required List<DocumentReference<Map<String, dynamic>>> listPlannedWeekDRs,
  }) async {
    int daysToMonday = 7 - startDate.weekday + 1;
    var nextMonday = startDate.add(Duration(days: daysToMonday));

    await singleWeek(
        startDate: startDate, plannedWeekDR: listPlannedWeekDRs[0]);

    for (var plannedWeekDR in listPlannedWeekDRs.sublist(1)) {
      int index = listPlannedWeekDRs.indexOf(plannedWeekDR);
      await singleWeek(
        startDate: nextMonday.add(Duration(days: 7 * index)),
        plannedWeekDR: plannedWeekDR,
      );
    }
    return daysToMonday + (listPlannedWeekDRs.length - 1) * 7;
  }

//
  Future<void> singleDay({
    required Map<String, dynamic>? plannedDayDataMap,
    required DocumentReference<Map<String, dynamic>> plannedDayDR,
    required DateTime date,
  }) async {
    Future<void> proceed(Map<String, dynamic> map) async {
      var pdm = DayModel.fromMap(map);
      pdm.dayDate = date;

      await admos
          .activeDayDR(date, userUID)
          .set(pdm.toMap(), SetOptions(merge: true))
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
      var dtm = TimingModel.fromMap(map);

      var atmDR = admos
          .activeDayDR(date, userUID)
          .collection(tmos.timings)
          .doc(dtm.timingString);
      await atmDR.set(dtm.toMap(), SetOptions(merge: true)).then((value) async {
        await plannedTimingDR
            .collection(fmos.foods)
            .orderBy(fmos.foodAddedTime, descending: false)
            .get()
            .then((fqs) async {
          if (fqs.docs.isNotEmpty) {
            await multiFood(
                activeTimingDR: atmDR,
                listPlannedFoodDataMap: fqs.docs.map((e) => e.data()).toList());
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
    required Map<String, dynamic> plannedFoodDataMap,
  }) async {
    var afm = FoodModel.fromMap(plannedFoodDataMap);
    afm.isCamFood = false;
    await activeTimingDR.collection(fmos.foods).add(afm.toMap());
  }

  //
  Future<void> multiFood({
    required DocumentReference<Map<String, dynamic>> activeTimingDR,
    required List<Map<String, dynamic>> listPlannedFoodDataMap,
  }) async {
    for (var plannedFoodDataMap in listPlannedFoodDataMap) {
      await singleFood(
          activeTimingDR: activeTimingDR,
          plannedFoodDataMap: plannedFoodDataMap);
    }
  }
}
