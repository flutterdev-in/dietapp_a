import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/constsnts/const_objects_pc.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/coice_foods_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/timing_info_model.dart';
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
  Rx<String> currentChoiceDRpath = "".obs;
  Rx<int> choiceCounts = 0.obs;
  Rx<String> editScreenModel = "".obs;
  Rx<int> lastDayIndex = 0.obs;
  final activePageTimingsMaps =
      RxMap<DocumentReference<Map<String, dynamic>>, TimingInfoModel>({}).obs;
  final selectedTimingMap =
      RxMap<DocumentReference<Map<String, dynamic>>, TimingInfoModel>({}).obs;
  final pickedFoodCollectionModels = RxList<FoodsCollectionModel>([]).obs;

  //
  final selectedChoiceMap =
      RxMap<DocumentReference<Map<String, dynamic>>, ChoiceFoodsModel>({}).obs;

  final activePageChoicesinMaps =
      RxMap<DocumentReference<Map<String, dynamic>>, ChoiceFoodsModel>({}).obs;

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

  Future<DocumentReference> getFirstEmptyChoiceDR() async {
    DocumentReference docRef = await FirebaseFirestore.instance
        .doc(currentTimingDRpath.value)
        .collection(choiceFMS.choices)
        .add(ChoiceFoodsModel(
                choiceIndex: 0, choiceName: "", notes: "", refURL: null)
            .toMap())
        .then((value) {
      return value;
    });
    return docRef;
  }
}

Box pcBox = Hive.box("planCreationBox");
