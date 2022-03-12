import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/functions/fc_delete_copy_move_operations_function.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/bottom%20bars/buttons/r_rename_fc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnSelectedBottomBarForFoodCollection extends StatelessWidget {
  const OnSelectedBottomBarForFoodCollection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void addItemsToListForOperation() {
      if (fcc.itemsSelectionCount.value > 0 ) {
        fcc.currentsPathItemsMaps.value.forEach((snapRef, thisItemMap) {
          if (thisItemMap[fdcs.isItemSelected] ?? false) {
            fcc.listSelectedItemsDRsForOperation.value.add(snapRef);
          }
        });
        fcc.isSelectionStarted.value = false;

        fcc.pathWhenCopyOrMovePressed.value = fcc.currentPathCR.value;
      }
    }

    return Container(
      height: 45,
      color: Colors.orange.shade100,
      child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                child: Text(
                  "Copy",
                  style: TextStyle(
                    color: (fcc.itemsSelectionCount.value > 0)
                        ? Colors.purple
                        : Colors.black38,
                  ),
                ),
                onPressed: () {
                  fcc.isCopyOrMoveStarted.value = true;
                  addItemsToListForOperation();

                  fcc.operationValue.value = 1;
                },
              ),
              TextButton(
                child: Text(
                  "Move",
                  style: TextStyle(
                    color: (fcc.itemsSelectionCount.value > 0)
                        ? Colors.purple
                        : Colors.black38,
                  ),
                ),
                onPressed: () {
                  fcc.isCopyOrMoveStarted.value = true;
                  addItemsToListForOperation();
                  fcc.operationValue.value = 2;
                },
              ),
              TextButton(
                child: Text(
                  "Delete",
                  style: TextStyle(
                    color: (fcc.itemsSelectionCount.value > 0)
                        ? Colors.purple
                        : Colors.black38,
                  ),
                ),
                onPressed: () async {
                  addItemsToListForOperation();
                  fcc.isCopyOrMoveStarted.value = false;
                  fcc.operationValue.value = 0;
                  await fcDeleteCopyMoveOperations(
                    listSourceDR: fcc.listSelectedItemsDRsForOperation.value,
                    targetCRpath: fcc.currentPathCR.value,
                  );
                  fcc.operationValue.value = 9;
                  
                },
              ),
              fcItemEditButton(),
            ],
          )),
    );
  }
}
