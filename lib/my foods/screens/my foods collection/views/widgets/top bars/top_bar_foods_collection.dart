import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/top%20bars/a_add_folder_for_foods.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/rx_variables.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/top%20bars/fc_path_bar.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/top%20bars/on_selection_top_bar_for_food_collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodsCollectionTopBar extends StatelessWidget {
  const FoodsCollectionTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget onStartW = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
            onPressed: () async {
              await Future.delayed(Duration(milliseconds: 50));
              rxfcv.isSelectionStarted.value = !rxfcv.isSelectionStarted.value;
              
            },
            child: const Text("Select")),
        TextButton(onPressed: () {

        }, child: const Text("Sort")),
        TextButton(
            onPressed: () async {
              addFolderForFoods(context);
              
            },
            child: const Text("Add Folder")),
        TextButton(onPressed: () {}, child: const Text("Add Food")),
      ],
    );
    return Column(
      children: [
        Container(
          height: 40,
          color: Colors.yellow.shade100,
          child: Obx(() => rxfcv.isSelectionStarted.value
              ? OnSelectedTopBarForFoodCollection()
              : onStartW),
        ),
        FcPathBar(),
      ],
    );
  }
}
