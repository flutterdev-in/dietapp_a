import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/functions/fc_useful_functions.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/top%20bars/fc_path_bar.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FoodsPickFromFolderScren extends StatelessWidget {
  FoodsPickFromFolderScren({Key? key}) : super(key: key);
  Rx<int> selectedUnselectedAllIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () async {
                fcc.currentsPathItemsMaps.value.forEach(
                  (docRef, itemMap) async {
                    FoodModel fcm = itemMap[fdcs.fcModel];
                    Map fdcmMap = fcm.toMap();
                    if (itemMap[fdcs.isItemSelected] &&
                        (fcm.isFolder != true) &&
                        fdcmMap.isNotEmpty) {
                      await pcc.addFoods(fcm);
                    }
                  },
                );

                Get.back();
              },
              child: const Text("Pick selected foods")),
          const SizedBox(width: 20),
          IconButton(
              onPressed: () {
                if (selectedUnselectedAllIndex.value == 1) {
                  selectedUnselectedAllIndex.value = 0;
                  fcufs.selecAllUnselectAll(
                      trueSelectAllfalseUnselectAll: false);
                } else {
                  selectedUnselectedAllIndex.value = 1;
                  fcufs.selecAllUnselectAll(
                      trueSelectAllfalseUnselectAll: true);
                }
              },
              icon: const Icon(MdiIcons.selectAll)),
          const SizedBox(width: 20),
        ],
      ),
      body: Column(
        children: [
          const FcPathBar(),
          Obx(
            () => FirestoreListView<Map<String, dynamic>>(
              shrinkWrap: true,
              query: FirebaseFirestore.instance
                  .collection(fcc.currentPathCR.value)
                  .orderBy(fdcs.isFolder, descending: false),
              itemBuilder: (context, snapshot) {
                //Rx variables

                Rx<bool> isItemSelected = false.obs;

                Map<String, dynamic> fcMap = snapshot.data();

                FoodModel fdcm = FoodModel.fromMap(fcMap);
                Rx<bool> isFolder = true.obs;
                fcc.currentsPathItemsMaps.value.addAll({
                  snapshot.reference: {
                    fdcs.isItemSelected: false,
                    fdcs.itemIndex: fcc.currentsPathItemsMaps.value.length,
                    fdcs.fcModel: fdcm
                  }
                });
                Widget avatarW() {
                  if (fdcm.isFolder == true) {
                    return const Icon(
                      MdiIcons.folder,
                      color: Colors.orange,
                    );
                  } else {
                    Widget avatar = GFAvatar(
                      shape: GFAvatarShape.standard,
                      size: GFSize.MEDIUM,
                      maxRadius: 20,
                      backgroundImage: NetworkImage(fdcm.rumm?.img ?? ""),
                    );
                    if (fdcm.rumm?.isYoutubeVideo ?? false) {
                      return Stack(
                        children: [
                          avatar,
                          Positioned(
                            child: Container(
                              color: Colors.white70,
                              child: const Icon(
                                MdiIcons.youtube,
                                color: Colors.red,
                                size: 15,
                              ),
                            ),
                            right: 0,
                            bottom: 0,
                          )
                        ],
                      );
                    } else {
                      return avatar;
                    }
                  }
                }

                return GFListTile(
                  padding: const EdgeInsets.fromLTRB(0, 5, 8, 0),
                  margin:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  avatar: avatarW(),
                  title: Text(
                    fdcm.foodName,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  icon: Obx(
                    () {
                      if (!isFolder.value) {
                        if (selectedUnselectedAllIndex.value == 1) {
                          return const Icon(MdiIcons.checkboxMarkedCircle);
                        } else if (selectedUnselectedAllIndex.value == 0) {
                          return const Icon(
                              MdiIcons.checkboxBlankCircleOutline);
                        } else {
                          isItemSelected.value = fcc.currentsPathItemsMaps
                              .value[snapshot.reference]?[fdcs.isItemSelected];
                          if (isItemSelected.value) {
                            return const Icon(MdiIcons.checkboxMarkedCircle);
                          } else {
                            return const Icon(
                                MdiIcons.checkboxBlankCircleOutline);
                          }
                        }
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  onTap: () {
                    if (fdcm.isFolder == true) {
                      fcc.currentPathCR.value =
                          snapshot.reference.path + fdcs.fcPathSeperator;

                      fcc.pathsListMaps.value.add(
                        {
                          fdcs.pathCR: snapshot.reference
                              .collection(fdcs.subCollections),
                          fdcs.pathCRstring: fcc.currentPathCR.value,
                          fdcs.fieldName: fdcm.foodName
                        },
                      );
                    } else {
                      selectedUnselectedAllIndex.value = 9;

                      bool isSlected = fcc.currentsPathItemsMaps
                          .value[snapshot.reference]?[fdcs.isItemSelected];

                      // isItemSelected.value = !isItemSelected.value;
                      fcc.currentsPathItemsMaps.value[snapshot.reference]
                          ?[fdcs.isItemSelected] = !isSlected;
                      isItemSelected.value = !isSlected;
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
