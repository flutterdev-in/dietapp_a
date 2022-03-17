import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/constsnts/const_strings_pc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

PlanCreationController pcc = Get.put(PlanCreationController());

class PlanCreationController extends GetxController {
  //
  Rx<String> planName = "".obs;
  Rx<String> planNotes = "".obs;
  Rx<String> planURL = "".obs;

  //
  Rx<bool> isEditFromPreview = false.obs;
  Rx<String> editScreenModel = "".obs;

  @override
  void onInit() async {
    await Hive.openBox(cspc.boxPlanCreate);
    super.onInit();
  }
}
