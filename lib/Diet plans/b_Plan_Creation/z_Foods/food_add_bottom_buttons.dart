import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/z_Foods/a_foods_pick_from_folder_screen.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/add_food_sreen.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/foods_collection_listview.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FoodAddButtons extends StatelessWidget {
  const FoodAddButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () async {}, icon: Icon(MdiIcons.folderPlusOutline)),
          IconButton(
              onPressed: () async {},
              icon: Icon(MdiIcons.plusBoxMultipleOutline)),
          Text("|"),
          IconButton(onPressed: () async {}, icon: Icon(MdiIcons.penPlus)),
          IconButton(
              onPressed: () {
                fcc.currentPathCR.value = FirebaseFirestore.instance
                    .doc(pcc.currentTimingDRpath.value)
                    .collection("foods")
                    .path;
                Get.to(AddFoodScreen());
              },
              icon: Icon(MdiIcons.webPlus)),
          IconButton(
              onPressed: () {
                Get.to(FoodsPickFromFolderScren());
              },
              icon: Icon(MdiIcons.textBoxPlusOutline)),
        ],
      ),
    );
  }

  Future<void> foodsAddFromFolder(BuildContext context) async {
    alertDialogueW(context,
        body: SizedBox(
          height: 300,
          child: Expanded(child: FoodsCollectionListView()),
        ));
  }
}
