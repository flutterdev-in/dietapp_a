import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';
import 'package:get/get.dart';

PlanCreationController pcc = Get.put(PlanCreationController());

class PlanCreationController {
  Rx<String> currentPlanName = "".obs;
  Rx<String> currentPlanDRpath = "".obs;
  Rx<int> currentWeekIndex = 0.obs;
  Rx<int> currentDayIndex = 0.obs;
  Rx<int> currentTimingIndex = 0.obs;
  Rx<String> curreTimingDRpath = "".obs;

  final currentWeekDR = userDR.obs;
  final currentTimingDR = userDR.obs;
  final Rx<int> currentFoodChoiceIndex = 0.obs;
  final Rx<int> currentFoodOptionIndex = 0.obs;
  final Rx<int> currentFoodIndex = 0.obs;
  final Rx<int> activeChoiceIndex = 0.obs;

  void init() {
    currentWeekIndex.value = 0;
    currentDayIndex.value = 0;
    currentTimingIndex.value = 0;
    curreTimingDRpath.value = "";
    pcc.currentWeekDR.value = userDR;
    currentTimingDR.value = userDR;
    zeroIndexs();
  }

  void zeroIndexs() {
    currentFoodChoiceIndex.value = 0;
    currentFoodOptionIndex.value = 0;
    currentFoodIndex.value = 0;
    activeChoiceIndex.value = 0;
  }

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
        .orderBy(wmfos.weekIndex, descending: false);
  }

  Query<Map<String, dynamic>> daysCRq() {
    return FirebaseFirestore.instance
        .doc(currentPlanDRpath.value)
        .collection(wmfos.weeks)
        .doc(currentWeekIndex.value.toString())
        .collection(daymfos.days)
        .orderBy(daymfos.dayIndex, descending: false);
  }

  Query<Map<String, dynamic>> timingsCRq() {
    return FirebaseFirestore.instance
        .doc(currentPlanDRpath.value)
        .collection(wmfos.weeks)
        .doc(currentWeekIndex.value.toString())
        .collection(daymfos.days)
        .doc(currentDayIndex.value.toString())
        .collection(dtmos.timings)
        .orderBy(dtmos.timingString, descending: false);
  }

  // Query<Map<String, dynamic>> foodsCRq() {
  //   return FirebaseFirestore.instance
  //       .doc(currentPlanDRpath.value)
  //       .collection(wmfos.weeks)
  //       .doc(currentWeekIndex.value.toString())
  //       .collection(daymfos.days)
  //       .doc(currentDayIndex.value.toString())
  //       .collection(dtmos.timings)
  //       .doc(currentTimingDocID.value)
  //       .collection("foods");
  // }

  Future<void> addFoods(FoodsCollectionModel fcm) async {
    pcc.currentTimingDR.value =
        FirebaseFirestore.instance.doc(pcc.curreTimingDRpath.value);
    pcc.currentFoodIndex.value++;
    await pcc.currentTimingDR.value.collection("foods").add(
        FoodsModelForPlanCreation(
                choiceIndex: pcc.currentFoodChoiceIndex.value,
                optionIndex: pcc.currentFoodOptionIndex.value,
                foodIndex: pcc.currentFoodIndex.value,
                foodName: fcm.fieldName,
                notes: fcm.notes,
                imgURL: fcm.imgURL,
                refURL: fcm.webURL)
            .toMap());
  }
}
