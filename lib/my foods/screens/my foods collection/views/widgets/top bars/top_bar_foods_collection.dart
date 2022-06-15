import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/top%20bars/a_add_folder_for_foods.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/top%20bars/fc_path_bar.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/top%20bars/on_selection_top_bar_for_food_collection.dart';
import 'package:dietapp_a/w_bottomBar/_bottom_navigation_bar.dart';
import 'package:dietapp_a/x_Browser/_browser_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodsCollectionTopBar extends StatelessWidget {
  const FoodsCollectionTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget onStartW = Container(
        color: secondaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              child: const Text("Add Notes"),
              onPressed: () {},
            ),
            TextButton(
              child: const Text("Add Food"),
              onPressed: () {
                bottomBarindex.value = 3;
                Get.to(const AddFoodScreen());
              },
            ),
            TextButton(
              child: const Text("Add Folder"),
              onPressed: () async {
                List<String> listSubs =
                    fcc.currentCR.value.path.split(fdcs.subCollections);
                if (listSubs.length < 6) {
                  addFolderForFoods(context);
                }
              },
            ),
          ],
        ));
    return Column(
      children: [
        SizedBox(
          height: 40,
          // color: Colors.yellow.shade100,
          child: Obx(() => fcc.isSelectionStarted.value
              ? const OnSelectedTopBarForFoodCollection()
              : onStartW),
        ),
        const SizedBox(height: 1),
        const FcPathBar(),
      ],
    );
  }
}
