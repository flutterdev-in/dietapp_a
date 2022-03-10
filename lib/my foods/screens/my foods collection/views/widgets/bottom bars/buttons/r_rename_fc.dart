import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/functions/fc_count_of_selected_items.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/rx_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FCitemEditButton extends StatelessWidget {
  FCitemEditButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    String buttonName = "Edit";

    return Obx(() {
      if (rxfcv.isSelectionStarted.value &&
          rxfcv.itemsSelectionCount.value == 1) {
        DocumentReference? snapshotReference;
        // Values only for initialisation
        FoodsCollectionModel fdcm = FoodsCollectionModel(
            fieldName: "",
            fieldTime: Timestamp.fromDate(DateTime.now()),
            isFolder: true);
        rxfcv.currentsPathItemsMaps.forEach((snapReference, thisItemMap) {
          if (thisItemMap[fdcs.isItemSelected] ?? false) {
            snapshotReference = snapReference;
            fdcm = thisItemMap[fdcs.fcModel];
          }
        });
        TextEditingController tcName = TextEditingController();
        tcName.text = fdcm.fieldName;
        TextEditingController tcNotes = TextEditingController();
        tcNotes.text = fdcm.notes;
        return TextButton(
          child: Text(buttonName),
          onPressed: () async {
            await Future.delayed(const Duration(milliseconds: 80));
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
                        decoration: const InputDecoration(
                            labelText: "Notes (optional)"),
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
                          child: const Text("Modify"),
                          onPressed: () async {
                            Get.back();
                            if (fdcm.isFolder && snapshotReference != null) {
                              await Future.delayed(
                                  const Duration(milliseconds: 700));
                              rxfcv.currentsPathItemsMaps[snapshotReference]
                                  [fdcs.isItemSelected] = false;
                              rxfcv.isUnselectAll.value = true;
                              rxfcv.itemsSelectionCount.value =
                                  fcCountOfSelectedItems(
                                      rxfcv.currentsPathItemsMaps);

                              await snapshotReference!.update({
                                fdcs.fieldName: tcName.text,
                                fdcs.notes: tcNotes.text,
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
          },
        );
      } else {
        return TextButton(
            onPressed: () {},
            child: Text(
              buttonName,
              style: TextStyle(color: Colors.black54),
            ));
      }
    });
  }
}
