import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';
import 'package:get/get.dart';

PlanCreationController pcc = Get.put(PlanCreationController());

class PlanCreationController {
  Rx<String> currentPlanName = "".obs;
  Rx<String> currentPlanDRpath = "".obs;

  Rx<int> currentDayIndex = 0.obs;

  final currentWeekDR = userDR.obs;
  final currentTimingDR = userDR.obs;
  final Rx<bool> isCombinedCreationScreen = false.obs;
  final currentTimingFoodDRsList =
      RxList<DocumentReference<Map<String, dynamic>>>([]).obs;

  final Rx<bool> isPlanView = false.obs;

////
  String weekName(int weekIndex) {
    weekIndex++;
    if (weekIndex == 1) {
      return "1st Week";
    } else if (weekIndex.toString().split("").last == "2") {
      return "${weekIndex}nd Week";
    } else if (weekIndex.toString().split("").last == "3") {
      return "${weekIndex}rd Week";
    } else {
      return "${weekIndex}th Week";
    }
  }

  Query<Map<String, dynamic>> weeksCRq() {
    return FirebaseFirestore.instance
        .doc(currentPlanDRpath.value)
        .collection(wmfos.weeks)
        .orderBy(wmfos.weekCreationTime, descending: false);
  }

  Future<void> getCurrentTimingDR() async {
    await pcc.currentWeekDR.value
        .collection(daymfos.days)
        .doc(currentDayIndex.value.toString())
        .collection(dtmos.timings)
        .orderBy(dtmos.timingString, descending: false)
        .limit(1)
        .get()
        .then((snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        pcc.currentTimingDR.value = snapshot.docs.first.reference;
      }
    });
  }

  Future<void> addFoods(FoodsCollectionModel fcm) async {
    await pcc.currentTimingDR.value.collection(fmfpcfos.foods).add(
        FoodsModelForPlanCreation(
                foodAddedTime: Timestamp.fromDate(DateTime.now()),
                foodName: fcm.fieldName,
                notes: fcm.notes,
                rumm: fcm.rumm)
            .toMap());
  }

  Future<List<DefaultTimingModel>> getDefaultTimings(
      {required bool isWantGross}) async {
    List<DefaultTimingModel> listTimingsInFire = [];
    await FirebaseFirestore.instance
        .doc(currentPlanDRpath.value)
        .get()
        .then((docSnap) async {
      if (docSnap.exists && docSnap.data() != null) {
        DietPlanBasicInfoModel dpbim =
            DietPlanBasicInfoModel.fromMap(docSnap.data()!);
        if (isWantGross) {
          listTimingsInFire = dpbim.defaultTimings;
        } else {
          listTimingsInFire = dpbim.defaultTimings0;
        }
      }
    });
    return listTimingsInFire;
  }

  Future<void> getPlanRxValues(
      DocumentReference planDocRef,
      DietPlanBasicInfoModel dpbim) async {
    await planDocRef
        .collection(wmfos.weeks)
        .orderBy(wmfos.weekCreationTime, descending: false)
        .limit(1)
        .get()
        .then((snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        pcc.currentWeekDR.value = snapshot.docs.first.reference;
        pcc.currentDayIndex.value = 0;
        await pcc.getCurrentTimingDR();
      }
    });
    pcc.currentPlanName.value = dpbim.planName;
    pcc.currentPlanDRpath.value = planDocRef.path;
  }
}
