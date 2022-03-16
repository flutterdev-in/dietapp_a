import 'package:dietapp_a/my%20foods/screens/Add%20food/constants/adf_const_variables.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/add_food_controller.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/controllers/browser_controllers.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/models/food_model_of_fire_food.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/top%20bars/fc_path_bar.dart';

import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:dietapp_a/x_customWidgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CountButtonAdfdW extends StatelessWidget {
  CountButtonAdfdW({Key? key}) : super(key: key);
  final Rx<num> rxIndex = 1.2.obs;
  @override
  Widget build(BuildContext context) {
    return GFIconButton(
      type: GFButtonType.outline,
      shape: GFIconButtonShape.circle,
      icon: Obx(() => Text(
            adfc.addedFoodList.value.length.toString(),
            textScaleFactor: 1.2,
          )),
      onPressed: () {
        alertDialogueW(
          context,
          contentPadding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
          body: Obx(
            () => rxIndex % 1 != 0 ? listViewSelected() : editFoodDetailes(),
          ),
        );
      },
    );
  }

  Widget listViewSelected() {
    return SizedBox(
      height: 510,
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FcPathBar(),
          SizedBox(
            height: 410,
            child: Obx(
              () {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: adfc.addedFoodList.value.length,
                  itemBuilder: (context, index) {
                    FoodsCollectionModel fdcm = adfc.addedFoodList.value[index];

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(2, 3, 3, 3),
                      child: Row(
                        children: [
                          GFAvatar(
                            shape: GFAvatarShape.standard,
                            size: GFSize.MEDIUM,
                            maxRadius: 20,
                            backgroundImage: NetworkImage(fdcm.imgURL ?? ""),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              fdcm.fieldName,
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
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
                                rxIndex.value = index.toDouble();
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
                              onTap: () =>
                                  adfc.addedFoodList.value.removeAt(index),
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
    FoodsCollectionModel fdcm = adfc.addedFoodList.value[rxIndex.value.toInt()];
    TextEditingController tcName = TextEditingController();
    TextEditingController tcNotes = TextEditingController();
    tcName.text = fdcm.fieldName;
    tcNotes.text = fdcm.notes;
    return WillPopScope(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LimitedBox(
            maxHeight: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.newline,
                maxLines: null,
                autofocus: true,
                controller: tcName,
                decoration: InputDecoration(
                  labelText: "Food name",
                  suffixIcon: InkWell(
                    child: Icon(MdiIcons.web, color: Colors.black),
                    onTap: () {
                      bc.wvc?.loadUrl(
                        urlRequest: URLRequest(
                          url: Uri.parse(fdcm.webURL ?? ""),
                        ),
                      );
                      Get.back();
                    },
                  ),
                ),
              ),
            ),
          ),
          LimitedBox(
            maxHeight: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: null,
                textInputAction: TextInputAction.newline,
                controller: tcNotes,
                decoration:
                    const InputDecoration(labelText: "Notes (optional)"),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: const Text("Cancle"),
                onPressed: () {
                  rxIndex.value = 1.2;
                },
              ),
              ElevatedButton(
                  child: const Text("Modify"),
                  onPressed: () {
                    Map<String, dynamic> fdcmMap = fdcm.toMap();
                    fdcmMap[fdcs.fieldName] = tcName.text.trimRight();
                    fdcmMap[fdcs.notes] = tcNotes.text.trimRight();
                    adfc.addedFoodList.value[rxIndex.value.toInt()] =
                        FoodsCollectionModel.fromMap(fdcmMap);
                    rxIndex.value = 1.2;
                  }),
            ],
          ),
        ],
      ),
      onWillPop: () async {
        Get.back();
        await Future.delayed(const Duration(milliseconds: 200));
        rxIndex.value = 1.2;
        return true;
      },
    );
  }
}
