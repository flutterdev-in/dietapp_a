import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/functions/fc_delete_copy_move_operations_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/toast/gf_toast.dart';

class PasteBarForFC extends StatelessWidget {
  const PasteBarForFC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      color: Colors.orange.shade100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            child: const Text(
              "Cancle",
              style: TextStyle(color: Colors.black38),
            ),
            onPressed: () {
              fcc.isCopyOrMoveStarted.value = false;
            },
          ),
          TextButton(
            child: Obx(() => Text(
                  "Paste",
                  style: TextStyle(
                    color: (isPasteValidPath() &&
                            fcc.pathWhenCopyOrMovePressed.value != "")
                        ? Colors.purple
                        : Colors.black38,
                  ),
                )),
            onPressed: () async {
              if (isPasteValidPath() &&
                  fcc.pathWhenCopyOrMovePressed.value != "") {
                await fcDeleteCopyMoveOperations(
                  listSourceDR: fcc.listSelectedItemsDRsForOperation.value,
                  targetCRpath: fcc.currentPathCR.value,
                );

                fcc.isCopyOrMoveStarted.value = false;
                fcc.itemsSelectionCount.value = 0;
                fcc.operationValue.value = 9;
              } else {
                GFToast.showToast(
                  "Paste location cannot be the same path",
                  context,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  bool isPasteValidPath() {
    bool isPathValid = true;
    if (fcc.currentPathCR.value == fcc.pathWhenCopyOrMovePressed.value) {
      isPathValid = false;
    } else {
      fcc.listSelectedItemsDRsForOperation.value
          .forEach((DocumentReference<Map<String, dynamic>> thisDR) {
        if (fcc.currentPathCR.value.contains(thisDR.path)) {
          isPathValid = false;
        }
      });
    }

    return isPathValid;
  }
}
