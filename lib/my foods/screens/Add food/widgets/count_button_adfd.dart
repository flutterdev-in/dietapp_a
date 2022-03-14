import 'package:dietapp_a/my%20foods/screens/Add%20food/constants/adf_const_variables.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/add_food_controller.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/models/food_model_of_fire_food.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';

import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CountButtonAdfdW extends StatelessWidget {
  CountButtonAdfdW({Key? key}) : super(key: key);
  final Rx<String> rxfID = "".obs;
  @override
  Widget build(BuildContext context) {
    return GFIconButton(
      shape: GFIconButtonShape.circle,
      icon:
          Obx(() => Text(adfc.grossSelectedFCmodelMap.value.length.toString())),
      onPressed: () {
        alertDialogueW(
          context,
          contentPadding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
          body: Obx(
            () => rxfID.value.isEmpty ? listViewSelected() : editFoodDetailes(),
          ),
        );
      },
    );
  }

  Widget listViewSelected() {
    return SizedBox(
      height: 460,
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 410,
            child: Obx(
              () {
                List<String> listFIDs =
                    adfc.grossSelectedFCmodelMap.value.keys.toList();
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: listFIDs.length,
                  itemBuilder: (context, index) {
                    FoodModelOfFireFood fmff = adfc.grossSelectedFCmodelMap
                        .value[listFIDs[index]]?[adfcv.foodModelOfFireFood];
                    String matchedName = adfc.grossSelectedFCmodelMap
                        .value[listFIDs[index]]?[adfcv.matchedname];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(2, 3, 3, 3),
                      child: Row(
                        children: [
                          GFAvatar(
                            maxRadius: 20,
                            backgroundImage: NetworkImage(fmff.img150),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(matchedName, softWrap: true),
                            flex: 8,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: InkWell(
                              child: Icon(
                                MdiIcons.circleEditOutline,
                                color: Colors.black,
                              ),
                              onTap: () {
                                rxfID.value = listFIDs[index];
                              },
                            ),
                            flex: 1,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: InkWell(
                              child: Icon(
                                MdiIcons.minusCircleOutline,
                                color: Colors.black,
                              ),
                              onTap: () => adfc.grossSelectedFCmodelMap.value
                                  .remove(listFIDs[index]),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () => Get.back(), child: Text("Add more")),
                ElevatedButton(
                  child: Text("Add all"),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget editFoodDetailes() {
    FoodsCollectionModel fdcm = adfc.grossSelectedFCmodelMap.value[rxfID.value]
        ?[adfcv.foodCollectionModel];
    TextEditingController tcName = TextEditingController();
    TextEditingController tcNotes = TextEditingController();
    tcName.text = fdcm.fieldName;
    tcNotes.text = fdcm.notes;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            autofocus: true,
            controller: tcName,
            decoration: const InputDecoration(labelText: "Food name"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: tcNotes,
            decoration: const InputDecoration(labelText: "Notes (optional)"),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text("Cancle"),
              onPressed: () {
                Get.back();
              },
            ),
            ElevatedButton(
                child: const Text("Modify"),
                onPressed: () {
                  Map<String, dynamic> fdcmMap = fdcm.toMap();
                  fdcmMap[fdcs.fieldName] = tcName.text;
                  fdcmMap[fdcs.notes] = tcNotes.text;
                  adfc.grossSelectedFCmodelMap
                          .value[rxfID.value]![adfcv.foodCollectionModel] =
                      FoodsCollectionModel.fromMap(fdcmMap);
                  adfc.grossSelectedFCmodelMap
                      .value[rxfID.value]![adfcv.matchedname] = tcName.text;

                  rxfID.value = "";
                  // Get.back();
                }),
          ],
        ),
      ],
    );
  }
}
