import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:get/get.dart';

FoodsCollectionController fcc = Get.put(FoodsCollectionController());

class FoodsCollectionController extends GetxController {
  Rx<String> currentPathCR = fdcs.foodsCR0.path.obs;
  final pathsListMaps = RxList<Map<String, dynamic>>([]).obs;
  Rx<bool> isCopyOrMoveStarted = false.obs;
  Rx<String> pathWhenCopyOrMovePressed = "".obs;
  Rx<int> operationValue = 9.obs;
  Rx<bool> isUnselectAll = true.obs;
  Rx<bool> isSelectAll = false.obs;
  Rx<bool> isSelectionStarted = false.obs;
  Rx<bool> isSortPressed = false.obs;
  Rx<String> printPurpose = "".obs;

  final currentsPathItemsMaps =
      RxMap<DocumentReference<Map<String, dynamic>>, Map<String, dynamic>>({})
          .obs;
  Rx<int> itemsSelectionCount = 0.obs;

  Rx<int> documentsFetchedForBatch = 0.obs;
  Rx<int> documentsDeletedFromBatch = 0.obs;
  final listSelectedItemsDRsForOperation =
      RxList<DocumentReference<Map<String, dynamic>>>([]).obs;
  @override
  void onClose() {
    fcc.currentPathCR.value = fdcs.foodsCR0.path;
    super.onClose();
  }
}
