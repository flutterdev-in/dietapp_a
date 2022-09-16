import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/functions/fc_useful_functions.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget fcItemEditButton() {
  Widget nullEditButton = TextButton(
      onPressed: () {},
      child: const Text(
        "Rename",
        style: TextStyle(color: Colors.black54),
      ));

  //
  return Obx(
    () {
      if (fcc.isSelectAll.value ||
          fcc.isUnselectAll.value ||
          fcc.itemsSelectionCount.value != 1) {
        return nullEditButton;
      } else if (fcc.itemsSelectionCount.value == 1) {
        return const FCitemEditButton();
      } else {
        return nullEditButton;
      }
    },
  );
}

class FCitemEditButton extends StatelessWidget {
  const FCitemEditButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //

    return TextButton(
      child: const Text("Rename"),
      onPressed: () async {
        await Future.delayed(const Duration(milliseconds: 80));
        DocumentReference? snapshotReference;
        // Values only for initialisation
        FoodModel? fdcm;
        fcc.currentPathMapFoodModels.value.forEach((fdm, isSelected) {
          if (isSelected && fdm.docRef != null) {
            snapshotReference = fdm.docRef!;
            fdcm = fdm;
          }
        });
        TextEditingController tcName = TextEditingController();
        tcName.text = fdcm?.foodName ?? "";
        TextEditingController tcNotes = TextEditingController();
        tcNotes.text = fdcm?.notes ?? "";
        if (fdcm != null) {
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      autofocus: true,
                      controller: tcName,
                      decoration:
                          const InputDecoration(labelText: "Folder name"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: tcNotes,
                      decoration:
                          const InputDecoration(labelText: "Notes (optional)"),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        child: const Text("Cancle"),
                        onPressed: () async {
                          Get.back();
                        },
                      ),
                      ElevatedButton(
                        child: const Text("Update"),
                        onPressed: () async {
                          Get.back();
                          if (snapshotReference != null) {
                            await Future.delayed(
                                const Duration(milliseconds: 700));
                            fcc.currentPathMapFoodModels.value[fdcm!] = false;
                            fcc.isUnselectAll.value = true;
                            fcc.itemsSelectionCount.value =
                                fcufs.countSelectedItems();

                            fcc.isSelectionStarted.value = false;
                            await snapshotReference!.update({
                              fmos.foodName: tcName.text,
                              "$unIndexed.$notes0": tcNotes.text,
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
