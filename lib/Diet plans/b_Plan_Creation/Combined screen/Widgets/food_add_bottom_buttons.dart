import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller0.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/z_Foods/a0_folders_pick_from_folder_screen.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/z_Foods/a1_foods_pick_from_folder_screen.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/add_food_sreen.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
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
              onPressed: () {
                Get.to(FoldersPickFromFolderScren());

              },
              icon: Icon(MdiIcons.folderPlusOutline)),
          IconButton(
              onPressed: () async {},
              icon: Icon(MdiIcons.plusBoxMultipleOutline)),
          Text("|"),
          IconButton(
              onPressed: () {
                manualAddFood(context);
              },
              icon: Icon(MdiIcons.penPlus)),
          IconButton(
              onPressed: () {
                fcc.currentPathCR.value = pcc.currentTimingDR.value
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

  void manualAddFood(BuildContext context) {
    Rx<String> name = "".obs;
    Rx<String> notes = "".obs;
    alertDialogueW(context,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              LimitedBox(
                maxHeight: 80,
                child: TextField(
                  maxLines: null,
                  autofocus: true,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.next,
                  decoration:const InputDecoration(
                    labelText: 'Food name',
                    isDense: true,
                  ),
                  onChanged: (value) {
                    name.value = value;
                  },
                ),
              ),
              SizedBox(height: 10),
              LimitedBox(
                maxHeight: 180,
                child: TextField(
                  maxLines: null,
                  autofocus: true,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    labelText: 'Notes',
                    isDense: true,
                  ),
                  onChanged: (value) {
                    notes.value = value;
                  },
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () async {
                      if (name.value.isNotEmpty || notes.value.isNotEmpty) {
                        await FirebaseFirestore.instance
                            .doc(pcc0.currentTimingDRpath.value)
                            .collection("foods")
                            .add(FoodsCollectionModel(
                                    fieldName: name.value,
                                    fieldTime:
                                        Timestamp.fromDate(DateTime.now()),
                                    isFolder: false)
                                .toMap());
                      }
                      Get.back();
                    },
                    child: Text("Add")),
              ),
            ],
          ),
        ));
  }
}
