import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/functions/add_folder_for_foods.dart';

import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/rx_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FoodsFolderTopBar extends StatelessWidget {
  const FoodsFolderTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // color: Colors.black87,
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () async {
                  // addFolderForFoods(context);
                  // await FirebaseFirestore.instance.collection(fdcs.foodsCollectionPath0).add(FoodsCollectionModel(fieldName: "fieldName", fieldTime: Timestamp.fromDate(DateTime.now()), isFolder: true).toMap());
                },
                icon: const Icon(MdiIcons.close)),
            IconButton(
                onPressed: () {},
                icon: const Icon(MdiIcons.checkboxMultipleBlankCircleOutline)),
            IconButton(
                onPressed: () async {
                  rxfcv.isDeletePressed.value = !rxfcv.isDeletePressed.value;
                  // await FirebaseFirestore.instance.collection(fdcs.foodsCollectionPath0).add(FoodsCollectionModel(fieldName: "fieldName", fieldTime: Timestamp.fromDate(DateTime.now()), isFolder: true).toMap());
                },
                icon: const Icon(MdiIcons.checkboxMultipleBlankCircle)),
            IconButton(
                onPressed: () {}, icon: const Icon(MdiIcons.trashCanOutline)),
            IconButton(
                onPressed: () {}, icon: const Icon(MdiIcons.contentCopy)),
            IconButton(
                onPressed: () {}, icon: const Icon(MdiIcons.folderMoveOutline)),
          ],
        ));

    Obx(() => SizedBox(
        // color: Colors.black87,
        height: 35,
        child: rxfcv.isDeletePressed.value
            ? deletePressedRow(context)
            : mainRow(context)));
  }

  Widget mainRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
            onPressed: () async {
              addFolderForFoods(context);
              // await FirebaseFirestore.instance.collection(fdcs.foodsCollectionPath0).add(FoodsCollectionModel(fieldName: "fieldName", fieldTime: Timestamp.fromDate(DateTime.now()), isFolder: true).toMap());
            },
            child: const Text("Add Folder")),
        TextButton(onPressed: () {}, child: const Text("Add Food")),
        TextButton(
            onPressed: () async {
              rxfcv.isDeletePressed.value = !rxfcv.isDeletePressed.value;
              // await FirebaseFirestore.instance.collection(fdcs.foodsCollectionPath0).add(FoodsCollectionModel(fieldName: "fieldName", fieldTime: Timestamp.fromDate(DateTime.now()), isFolder: true).toMap());
            },
            child: const Text("Delete")),
        TextButton(onPressed: () {}, child: const Text("Sort")),
      ],
    );
  }

  Widget deletePressedRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
            onPressed: () async {
              // addFolderForFoods(context);
              // await FirebaseFirestore.instance.collection(fdcs.foodsCollectionPath0).add(FoodsCollectionModel(fieldName: "fieldName", fieldTime: Timestamp.fromDate(DateTime.now()), isFolder: true).toMap());
            },
            child: const Icon(MdiIcons.close)),
        TextButton(
            onPressed: () {},
            child: const Icon(MdiIcons.checkboxMultipleBlankOutline)),
        TextButton(
            onPressed: () async {
              rxfcv.isDeletePressed.value = !rxfcv.isDeletePressed.value;
              // await FirebaseFirestore.instance.collection(fdcs.foodsCollectionPath0).add(FoodsCollectionModel(fieldName: "fieldName", fieldTime: Timestamp.fromDate(DateTime.now()), isFolder: true).toMap());
            },
            child: const Icon(MdiIcons.checkboxMultipleBlank)),
        TextButton(
            onPressed: () {}, child: const Icon(MdiIcons.trashCanOutline)),
      ],
    );
  }
}
