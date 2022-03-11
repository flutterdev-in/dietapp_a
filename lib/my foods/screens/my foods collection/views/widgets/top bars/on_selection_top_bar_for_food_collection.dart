import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/functions/fc_useful_functions.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class OnSelectedTopBarForFoodCollection extends StatelessWidget {
  const OnSelectedTopBarForFoodCollection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            child: Icon(MdiIcons.close),
            onPressed: () async {
              await Future.delayed(Duration(milliseconds: 50));
              fcc.isSelectionStarted.value = !fcc.isSelectionStarted.value;
              fcc.isSelectAll.value = false;
              fcc.isUnselectAll.value = true;
              fcc.currentsPathItemsMaps.value.forEach((snapRef, thisItemMap) {
                fcc.currentsPathItemsMaps.value[snapRef]?[fdcs.isItemSelected] =
                    false;
              });
            },
          ),
          Obx(() => Text(
                fcc.documentsFetchedForBatch.value.toString() +
                    "..." +
                    fcc.documentsDeletedFromBatch.value.toString(),
              )),
          TextButton(
            child: const Text("Unselect all"),
            onPressed: () {
              fcc.isUnselectAll.value = true;
              fcc.isSelectAll.value = false;

              fcufs.selecAllUnselectAll(trueSelectAllfalseUnselectAll: false);
            },
          ),
          TextButton(
            child: const Text("Select all"),
            onPressed: () {
              fcc.isSelectAll.value = true;
              fcc.isUnselectAll.value = false;

              fcufs.selecAllUnselectAll(trueSelectAllfalseUnselectAll: true);
            },
          ),
        ],
      ),
    );
  }
}
