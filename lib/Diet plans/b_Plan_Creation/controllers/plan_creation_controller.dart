import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:get/get.dart';

PlanCreationController pcc = Get.put(PlanCreationController());

class PlanCreationController {
  Rx<String> currentPlanName = "".obs;
  Rx<String> currentPlanDRpath = "".obs;
  Rx<int> currentWeekIndex = 0.obs;
  Rx<int> currentDayIndex = 0.obs;
  Rx<int> currentTimingIndex = 0.obs;
  Rx<String> curreTimingDRpath = "".obs;











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
    return  FirebaseFirestore.instance
        .doc(currentPlanDRpath.value)
        .collection(wmfos.weeks)
        .doc(currentWeekIndex.value.toString())
        .collection(daymfos.days)
        .doc(currentDayIndex.value.toString())
        .collection(dtmos.timings)
        .orderBy(dtmos.timingString, descending: false);
  }
}
