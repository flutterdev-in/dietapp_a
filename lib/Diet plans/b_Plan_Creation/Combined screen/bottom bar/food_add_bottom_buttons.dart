import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/bottom%20bar/a1_foods_pick_from_folder_screen.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/foods_collection_listview.dart';
import 'package:dietapp_a/x_Browser/_browser_main_screen.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FoodAddButtons extends StatelessWidget {
  const FoodAddButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.blue.shade50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () {
                manualAddFood(context);
              },
              icon: const Icon(MdiIcons.penPlus)),
          IconButton(
              onPressed: () {
                fcc.currentCR.value =
                    pcc.currentTimingDR.value.collection(fmos.foods);
                Get.to(const AddFoodScreen());
              },
              icon: const Icon(MdiIcons.webPlus)),
          IconButton(
              onPressed: () {
                fcc.currentCR.value = userDR.collection(fmos.foodsCollection);
                fcc.listFoodModelsForPath.value.clear();
                Get.to(() => const FoodsPickFromFolderScren());
              },
              icon: const Icon(MdiIcons.textBoxPlusOutline)),
        ],
      ),
    );
  }

  Future<void> foodsAddFromFolder(BuildContext context) async {
    alertDialogW(context,
        body: const SizedBox(
          height: 300,
          child: Expanded(child: FoodsCollectionListView()),
        ));
  }

  void manualAddFood(BuildContext context) {
    Rx<String> name = "".obs;
    Rx<String> notes = "".obs;
    alertDialogW(context,
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
                  decoration: const InputDecoration(
                    labelText: 'Food name',
                    isDense: true,
                  ),
                  onChanged: (value) {
                    name.value = value;
                  },
                ),
              ),
              const SizedBox(height: 10),
              LimitedBox(
                maxHeight: 180,
                child: TextField(
                  maxLines: null,
                  autofocus: true,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                    isDense: true,
                  ),
                  onChanged: (value) {
                    notes.value = value;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () async {
                      if (name.value.isNotEmpty || notes.value.isNotEmpty) {
                        await pcc.currentTimingDR.value
                            .collection(fmos.foods)
                            .add(FoodModel(
                                    foodAddedTime: DateTime.now(),
                                    foodTakenTime: null,
                                    foodName: name.value,
                                    isCamFood: false,
                                    isFolder: null,
                                    notes: notes.value,
                                    rumm: null)
                                .toMap());
                      }

                      Get.back();
                    },
                    child: const Text("Add")),
              ),
            ],
          ),
        ));
  }
}
