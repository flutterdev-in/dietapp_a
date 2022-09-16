import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:get/get.dart';

FoodsCollectionController fcc = Get.put(FoodsCollectionController());

class FoodsCollectionController extends GetxController {
  Rx<bool> isCopyOrMoveStarted = false.obs;
  Rx<String> pathWhenCopyOrMovePressed = "".obs;
  Rx<int> operationValue = 9.obs;
  Rx<bool> isUnselectAll = true.obs;
  Rx<bool> isSelectAll = false.obs;
  Rx<bool> isSelectionStarted = false.obs;
  Rx<bool> isSortPressed = false.obs;
  Rx<String> printPurpose = "".obs;
  final listFoodModelsForPath = RxList<FoodModel>([]).obs;
  final currentCR = userDR.collection(fmos.foodsCollection).obs;
  final currentPathMapFoodModels = RxMap<FoodModel, bool>({}).obs;

  // final currentsPathItemsMaps =
  //     RxMap<DocumentReference<Map<String, dynamic>>, Map<String, dynamic>>({})
  //         .obs;
  Rx<int> itemsSelectionCount = 0.obs;

  Rx<int> documentsFetchedForBatch = 0.obs;
  Rx<int> documentsDeletedFromBatch = 0.obs;
  final listSelectedItemsDRsForOperation =
      RxList<DocumentReference<Map<String, dynamic>>>([]).obs;
  @override
  void onClose() {
    currentCR.value = userDR.collection(fmos.foodsCollection);

    fcc.listFoodModelsForPath.value.clear();
    super.onClose();
  }
}
