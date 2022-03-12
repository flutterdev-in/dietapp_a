import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/w_bottomBar/rx_index_for_bottombar.dart';

void fcBackButtonFunction() {
  if (fcc.currentPathCR.value != fdcs.foodsCR0.path) {
    fcc.pathsListMaps.value.removeLast();
    if (fcc.pathsListMaps.value.isNotEmpty) {
      fcc.currentPathCR.value = fcc.pathsListMaps.value.last[fdcs.pathCRstring];
    } else {
      fcc.currentPathCR.value = fdcs.foodsCR0.path;
    }
  } else if (fcc.currentPathCR.value == fdcs.foodsCR0.path &&
      fcc.isSelectionStarted.value) {
    fcc.isSelectionStarted.value = false;
  } else if (fcc.currentPathCR.value == fdcs.foodsCR0.path) {
    bottomBarindex.value = 0;
  }
}
