import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/top%20bars/fc_path_bar.dart';
import 'package:dietapp_a/w_bottomBar/_bottom_navigation_bar.dart';
import 'package:dietapp_a/x_Browser/controllers/add_food_controller.dart';
import 'package:dietapp_a/x_Browser/controllers/browser_controllers.dart';
import 'package:dietapp_a/x_Browser/controllers/rxvariables_for_count_button.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
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
      color: Colors.black26,
      type: GFButtonType.outline,
      shape: GFIconButtonShape.circle,
      icon: Obx(() => Text(
            adfc.addedFoodList.value.length.toString(),
            textScaleFactor: 1.3,
          )),
      onPressed: () {
        alertDialogW(
          context,
          contentPadding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
          body: Obx(
            () => rxIndex % 1 != 0 ? listViewSelected() : editFoodDetails(),
          ),
        );
      },
    );
  }

  Widget listViewSelected() {
    return SizedBox(
      height: 520,
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const FcPathBar(),
          Wrap(
            children: const [
              Text("Tap on ", textScaleFactor: 0.7),
              Icon(MdiIcons.webPlus, color: Colors.black, size: 12),
              Text(
                " or Long press on webLinks to Add foods",
                textScaleFactor: 0.7,
              ),
            ],
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 410,
            child: Obx(
              () {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: adfc.addedFoodList.value.length,
                  itemBuilder: (context, index) {
                    FoodModel fdcm = adfc.addedFoodList.value[index];

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(2, 3, 3, 3),
                      child: Row(
                        children: [
                          InkWell(
                            child: GFAvatar(
                              shape: GFAvatarShape.standard,
                              size: GFSize.MEDIUM,
                              maxRadius: 20,
                              backgroundImage: fdcm.rumm?.img != null
                                  ? NetworkImage(fdcm.rumm!.img!)
                                  : null,
                            ),
                            onTap: () {
                              Get.back();
                              bc.loadURl(fdcm.rumm?.img ?? "");
                            },
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: InkWell(
                              child: Text(
                                fdcm.foodName,
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {
                                Get.back();
                                bc.loadURl(fdcm.rumm?.img ?? "");
                              },
                            ),
                            flex: 8,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: InkWell(
                              child: const Icon(
                                MdiIcons.circleEditOutline,
                                color: Colors.black,
                              ),
                              onTap: () {
                                rxIndex.value = index.toDouble();
                              },
                            ),
                            flex: 1,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: InkWell(
                              child: const Icon(
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
          const SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await Future.delayed(const Duration(milliseconds: 600));
                      adfc.addedFoodList.value.clear();
                      await Future.delayed(const Duration(milliseconds: 200));
                      Get.back();
                      countbvs.isClearAll.value = true;
                      await Future.delayed(const Duration(milliseconds: 2500));
                      countbvs.isClearAll.value = false;
                    },
                    child: const Text("Clear all")),
                ElevatedButton(
                  child: const Text("Add all"),
                  onPressed: () async {
                    for (FoodModel fcm in adfc.addedFoodList.value) {
                      if (bottomBarindex.value == 3) {
                        fcc.currentCR.value.add(fcm.toMap());
                      } else if (pcc.currentTimingDR.value != userDR) {
                        pcc.currentTimingDR.value
                            .collection(fmos.foods)
                            .add(fcm.toMap());
                      }
                    }
                    await Future.delayed(const Duration(milliseconds: 900));
                    adfc.addedFoodList.value.clear();
                    await Future.delayed(const Duration(milliseconds: 300));
                    Get.back();
                    countbvs.isAddAll.value = true;
                    await Future.delayed(const Duration(milliseconds: 2800));
                    countbvs.isAddAll.value = false;
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget editFoodDetails() {
    FoodModel fdcm = adfc.addedFoodList.value[rxIndex.value.toInt()];
    TextEditingController tcName = TextEditingController();
    TextEditingController tcNotes = TextEditingController();
    tcName.text = fdcm.foodName;
    tcNotes.text = fdcm.notes ?? "";
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
                    child: const Icon(MdiIcons.web, color: Colors.black),
                    onTap: () {
                      bc.wvc?.loadUrl(
                        urlRequest: URLRequest(
                          url: Uri.parse(fdcm.rumm?.url ?? ""),
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
          const SizedBox(height: 20),
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
                    fdcm.foodName = tcName.text.trimRight();
                    fdcm.notes = tcNotes.text.trimRight();
                    adfc.addedFoodList.value[rxIndex.value.toInt()] = fdcm;
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
