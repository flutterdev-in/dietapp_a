import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';

FCusefulFunctions fcufs = FCusefulFunctions();

class FCusefulFunctions {
//
  void selecAllUnselectAll({required bool trueSelectAllfalseUnselectAll}) {
    fcc.currentsPathItemsMaps.value.forEach((snapRef, thisItemMap) {
      fcc.currentsPathItemsMaps.value[snapRef]?[fdcs.isItemSelected] =
          trueSelectAllfalseUnselectAll;
      fcc.itemsSelectionCount.value = countSelectedItems();
    });
  }

//
  int countSelectedItems() {
    int currentPathSelectedItemsCount = 0;
    fcc.currentsPathItemsMaps.value.forEach((snapReference, thisItemMap) {
      if (thisItemMap[fdcs.isItemSelected] ?? false) {
        currentPathSelectedItemsCount++;
      }
    });
    return currentPathSelectedItemsCount;
  }
}
