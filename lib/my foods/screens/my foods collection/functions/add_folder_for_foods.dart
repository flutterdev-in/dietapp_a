import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/my%20foods/screens/a_food%20timings/models/food_timing_model.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(labelText: "Notes (optional)"),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                Get.back();
                await Future.delayed(Duration(milliseconds: 700));
                await FirebaseFirestore.instance
                    .collection(fdcs.foodsCollectionPath0)
                    .add(FoodsCollectionModel(
                            fieldName: tc.text,
                            fieldTime: Timestamp.fromDate(DateTime.now()),
                            isFolder: true)
                        .toMap());
              },
              child: Text("Add Folder")),
        ],
      ),
    ),
  );
}
