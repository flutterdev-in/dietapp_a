import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/constsnts/const_objects_pc.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

PlanCreationController pcc = Get.put(PlanCreationController());

class PlanCreationController extends GetxController {
  //
  Rx<String> planName = "".obs;
  Rx<String> planNotes = "".obs;
  Rx<String> planURL = "".obs;

  //
  Rx<String> currentPlanDocRefPath = "".obs;
  Rx<String> currentDayDRpath = "".obs;
  Rx<String> editScreenModel = "".obs;
  Rx<int> lastDayIndex = 0.obs;

  @override
  void onInit() async {
    pcc.lastDayIndex.value = 0;

    super.onInit();
  }

  
}
