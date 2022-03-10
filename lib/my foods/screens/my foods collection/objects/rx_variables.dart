import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:get/get.dart';

RxFoodsCollectionVariables rxfcv = RxFoodsCollectionVariables();

class RxFoodsCollectionVariables {
  Rx<String> currentPathCR = fdcs.foodsCR0.path.obs;
  RxList pathsListMaps = [].obs;

  Rx<bool> isUnselectAll = true.obs;
  Rx<bool> isSelectAll = false.obs;
  Rx<bool> isSelectionStarted = false.obs;
  Rx<bool> isSortPressed = false.obs;
  RxMap currentsPathItemsMaps = {}.obs;
  Rx<int> itemsSelectionCount = 0.obs;
  // RxList currentPathItemsListMaps = [].obs;
  // RxList currentPathSelectedList = [].obs;

  void selecAllUnselectAll({required bool trueSelectAllfalseUnselectAll}) {
    currentsPathItemsMaps.forEach((snapRef, thisItemMap) {
      currentsPathItemsMaps[snapRef][fdcs.isItemSelected] =
          trueSelectAllfalseUnselectAll;
      itemsSelectionCount.value = countSelectedItems();
    });
  }

  int countSelectedItems() {
    int currentPathSelectedItemsCount = 0;
    currentsPathItemsMaps.forEach((snapReference, thisItemMap) {
      if (thisItemMap[fdcs.isItemSelected] ?? false) {
        currentPathSelectedItemsCount++;
      }
    });
    return currentPathSelectedItemsCount;
  }
}
