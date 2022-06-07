import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void addFolderForFoods(BuildContext context) async {
  TextEditingController tc = TextEditingController();
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
              controller: tc,
              decoration: const InputDecoration(labelText: "Folder name"),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(labelText: "Notes (optional)"),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                Get.back();
                await Future.delayed(const Duration(milliseconds: 700));

                await FirebaseFirestore.instance
                    .collection(fcc.currentPathCR.value)
                    .add(FoodsCollectionModel(
                      fieldName: tc.text,
                      fieldTime: DateTime.now(),
                      isFolder: true,
                      rumm: null,
                      notes: null,
                    ).toMap())
                    .then((dr) async {
                  dr.update({"$unIndexed.$docRef0": dr});
                });
              },
              child: const Text("Add Folder")),
        ],
      ),
    ),
  );
}
