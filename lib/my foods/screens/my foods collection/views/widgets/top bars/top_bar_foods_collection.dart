import 'package:dietapp_a/my%20foods/screens/Add%20food/add_food_sreen.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/top%20bars/a_add_folder_for_foods.dart';
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
        // TextButton(
        //     onPressed: () async {
        //       await Future.delayed(const Duration(milliseconds: 50));
        //       fcc.isSelectionStarted.value = !fcc.isSelectionStarted.value;
        //       fcc.isUnselectAll.value = true;
        //       fcc.isSelectAll.value = false;
        //       fcufs.selecAllUnselectAll(trueSelectAllfalseUnselectAll: false);
        //     },
        //     child: const Text("Select")),
        TextButton(
          child: const Text("Add Folder"),
          onPressed: () async {
            List<String> listSubs =
                fcc.currentPathCR.split(fdcs.subCollections);
            if (listSubs.length < 6) {
              addFolderForFoods(context);
            }
          },
        ),
        TextButton(
          child: const Text("Add Food"),
          onPressed: () {
            Get.to(const AddFoodScreen());
          },
        ),
      ],
    );
    return Column(
      children: [
        Container(
          height: 40,
          color: Colors.yellow.shade100,
          child: Obx(() => fcc.isSelectionStarted.value
              ? const OnSelectedTopBarForFoodCollection()
              : onStartW),
        ),
        const FcPathBar(),
      ],
    );
  }
}
