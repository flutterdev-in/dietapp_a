import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:get/get.dart';

PlanCreationController pcc = Get.put(PlanCreationController());

class PlanCreationController {
  Rx<String> currentPlanName = "".obs;
  Rx<String> currentPlanDRpath = "".obs;
  final currentPlanDR = userDR.obs;
  // Rx<int> currentWeekIndex = 1.obs;
  // Rx<int> currentDayIndex = 0.obs;
  final currentDayDR = userDR.obs;
  final currentWeekDR = userDR.obs;
  final currentTimingDR = userDR.obs;
  final Rx<bool> isCombinedCreationScreen = false.obs;
  final listDaysDR = RxList<DocumentReference<Map<String, dynamic>>>([]).obs;
  final listWeeksDR = RxList<DocumentReference<Map<String, dynamic>>>([]).obs;
  // final weeksModelList = RxList<WeekModel>([]);
  final currentTimingFoodDRsList =
      RxList<DocumentReference<Map<String, dynamic>>>([]).obs;

  final Rx<bool> isPlanView = false.obs;

////

  Future<DocumentReference<Map<String, dynamic>>> getWeekDRfromPlan(
      DocumentReference<Map<String, dynamic>> planDR) async {
    return await planDR
        .collection(wmfos.weeks)
        .orderBy(wmfos.weekCreatedTime, descending: false)
        .limit(1)
        .get()
        .then((snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.reference;
      } else {
        return userDR;
      }
    });
  }

  Future<DocumentReference<Map<String, dynamic>>> getDayDRfromWeek(
      DocumentReference<Map<String, dynamic>> weekDR) async {
    return await weekDR
        .collection(daymfos.days)
        .orderBy(daymfos.dayIndex, descending: false)
        .limit(1)
        .get()
        .then((snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.reference;
      } else {
        return userDR;
      }
    });
  }

  Future<DocumentReference<Map<String, dynamic>>> getTimingDRfromDay(
      DocumentReference<Map<String, dynamic>> dayDR) async {
    return await dayDR
        .collection(dtmos.timings)
        .orderBy(dtmos.timingString, descending: false)
        .limit(1)
        .get()
        .then((snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.reference;
      } else {
        return userDR;
      }
    });
  }

  // Future<void> addFoods(FoodModel fcm) async {
  //   if (pcc.currentDayDR.value.parent.id == admos.activeDaysPlan) {
  //     await pcc.currentTimingDR.value.collection(fmos.foods).add(fcm.toMap());
  //   } else {
  //     await pcc.currentTimingDR.value
  //         .collection(fmos.foods)
  //         .add(fcm.toMap());
  //   }
  // }

  // Future<List<DefaultTimingModel>> getDefaultTimings(
  //     {required bool isWantGross}) async {
  //   List<DefaultTimingModel> listTimingsInFire = [];
  //   await FirebaseFirestore.instance
  //       .doc(currentPlanDRpath.value)
  //       .get()
  //       .then((docSnap) async {
  //     if (docSnap.exists && docSnap.data() != null) {
  //       DietPlanBasicInfoModel dpbim =
  //           DietPlanBasicInfoModel.fromMap(docSnap.data()!);
  //       if (isWantGross) {
  //         listTimingsInFire = dpbim.planDefaulTimings;
  //       } else {
  //         listTimingsInFire = dpbim.defaultTimings0;
  //       }
  //     }
  //   });
  //   return listTimingsInFire;
  // }

  Future<void> getPlanRxValues(
      DocumentReference<Map<String, dynamic>> planDocRef,
      bool isWeekWisePlan) async {
    if (isWeekWisePlan) {
      await planDocRef
          .collection(wmfos.weeks)
          .orderBy(wmfos.weekCreatedTime, descending: false)
          .limit(1)
          .get()
          .then((weeksSnap) async {
        if (weeksSnap.docs.isNotEmpty) {
          pcc.currentWeekDR.value = weeksSnap.docs.first.reference;
          pcc.currentWeekDR.value
              .collection(daymfos.days)
              .orderBy(daymfos.dayIndex, descending: false)
              .limit(1)
              .get()
              .then((daySnap) async {
            if (daySnap.docs.isNotEmpty) {
              pcc.currentDayDR.value = daySnap.docs.first.reference;
              pcc.currentTimingDR.value =
                  await pcc.getTimingDRfromDay(pcc.currentDayDR.value);
            }
          });
        }
      });
    } else {
      planDocRef
          .collection(daymfos.days)
          .orderBy(daymfos.dayCreatedTime, descending: false)
          .limit(1)
          .get()
          .then((daySnap) async {
        if (daySnap.docs.isNotEmpty) {
          pcc.currentPlanDR.value = planDocRef;
          pcc.currentDayDR.value = daySnap.docs.first.reference;
          pcc.currentTimingDR.value =
              await pcc.getTimingDRfromDay(pcc.currentDayDR.value);
        }
      });
    }
  }
}
