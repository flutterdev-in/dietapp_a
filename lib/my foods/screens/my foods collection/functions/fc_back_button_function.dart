import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/w_bottomBar/_bottom_navigation_bar.dart';
import 'package:dietapp_a/y_Models/food_model.dart';

void fcBackButtonFunction() {
  if (fcc.currentCR.value != userDR.collection(fmos.foodsCollection)) {
    fcc.listFoodModelsForPath.value.removeLast();
    if (fcc.listFoodModelsForPath.value.isNotEmpty) {
      fcc.currentCR.value = fcc.listFoodModelsForPath.value.last.docRef
              ?.collection(fmos.subCollections) ??
          userDR.collection(fmos.foodsCollection);
    } else {
      fcc.currentCR.value = userDR.collection(fmos.foodsCollection);
    }
  } else if (fcc.currentCR.value == userDR.collection(fmos.foodsCollection) &&
      fcc.isSelectionStarted.value) {
    fcc.isSelectionStarted.value = false;
  } else if (fcc.currentCR.value == userDR.collection(fmos.foodsCollection)) {
    bottomBarindex.value = 0;
  }
  fcc.currentPathMapFoodModels.value.clear();
  fcc.itemsSelectionCount.value = 0;
}
