import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';

FCusefulFunctions fcufs = FCusefulFunctions();

class FCusefulFunctions {
//
  void selecAllUnselectAll({required bool trueSelectAllfalseUnselectAll}) {
    fcc.currentPathMapFoodModels.value.forEach((fdm, isSelected) {
      fcc.currentPathMapFoodModels.value[fdm] = trueSelectAllfalseUnselectAll;
      fcc.itemsSelectionCount.value = countSelectedItems();
    });
  }

//
  int countSelectedItems() {
    int currentPathSelectedItemsCount = 0;
    fcc.currentPathMapFoodModels.value.forEach((fdm, isSelected) {
      if (isSelected) {
        currentPathSelectedItemsCount++;
      }
    });
    return currentPathSelectedItemsCount;
  }
}
