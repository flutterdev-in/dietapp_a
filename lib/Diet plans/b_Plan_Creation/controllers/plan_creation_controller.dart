import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/constsnts/const_objects_pc.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
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
  Rx<String> currentTimingDRpath = "".obs;
  Rx<String> editScreenModel = "".obs;
  Rx<int> lastDayIndex = 0.obs;
  final pickedFoodCollectionModels = RxList<FoodsCollectionModel>([]).obs;

  // Box Models
  String listTimings = "listTimings";
  List<String> constListTimings = [
    "Breakfast",
    "Mid morning snacks",
    "Lunch",
    "Evening snacks",
    "Dinner",
  ];

  @override
  void onInit() async {
    await Hive.openBox("planCreationBox");
    addDefaultItemsToBox();
    super.onInit();
  }

  void addDefaultItemsToBox() {
    if (pcBox.get(listTimings)?.isEmpty ?? true) {
      pcBox.put(listTimings, constListTimings);
    }
  }
}

Box pcBox = Hive.box("planCreationBox");

