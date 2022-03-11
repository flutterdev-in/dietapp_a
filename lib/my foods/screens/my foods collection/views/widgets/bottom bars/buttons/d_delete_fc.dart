import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

  Future<void> deleteItemsFromFC(BuildContext context) async {
    int currentPathSelectedItems = 0;
    fcc.currentsPathItemsMaps.value.forEach((snapRef, thisItemMap) {
      if (thisItemMap[fdcs.isItemSelected] ?? false) {
        currentPathSelectedItems++;
      }
    });

    if (currentPathSelectedItems > 0) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          contentPadding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 24.0),
          scrollable: true,
          actionsAlignment: MainAxisAlignment.start,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sure to delete selected items?"),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        Get.back();
                      },
                      child: Text("No, Cancle")),
                  ElevatedButton(
                    child: const Text("Yes, Delete"),
                      onPressed: () {
                        Get.back();
                       fcc.currentsPathItemsMaps.value
                            .forEach((snapRef, thisItemMap) async {
                          if (thisItemMap[fdcs.isItemSelected] ?? false) {
                            await snapRef.delete();
                          }
                        });
                      },
                      ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      GFToast.showToast(
        "No items selected",
        context,
        toastPosition: GFToastPosition.CENTER,
      );
    }
  }