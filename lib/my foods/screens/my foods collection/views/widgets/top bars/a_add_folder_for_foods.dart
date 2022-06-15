import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void addFolderForFoods(BuildContext context) async {
  TextEditingController tcText = TextEditingController();
  TextEditingController tcNotes = TextEditingController();
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
              controller: tcText,
              decoration: const InputDecoration(labelText: "Folder name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LimitedBox(
              maxHeight: 100,
              child: TextField(
                maxLines: null,
                controller: tcNotes,
                decoration:
                    const InputDecoration(labelText: "Notes (optional)"),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  Get.back();
                  await Future.delayed(const Duration(milliseconds: 700));

                  await fcc.currentCR.value
                      .add(FoodModel(
                    foodName: tcText.text,
                    foodAddedTime: DateTime.now(),
                    foodTakenTime: null,
                    isCamFood: null,
                    isFolder: true,
                    rumm: null,
                    notes: null,
                  ).toMap())
                      .then((dr) async {
                    dr.update({"$unIndexed.$docRef0": dr});
                  });
                },
                child: const Text("Add Folder")),
          ),
        ],
      ),
    ),
  );
}
