import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/coice_foods_model.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/functions/fc_useful_functions.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/top%20bars/fc_path_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FoldersPickFromFolderScren extends StatelessWidget {
  FoldersPickFromFolderScren({Key? key}) : super(key: key);
  Rx<int> selectedUnselectedAllIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () async {
                fcc.currentsPathItemsMaps.value
                    .forEach((docRef, itemMap) async {
                  FoodsCollectionModel fdcm = itemMap[fdcs.fcModel];
                  Map fdcmMap = fdcm.toMap();
                  if (itemMap[fdcs.isItemSelected] &&
                      fdcm.isFolder &&
                      fdcmMap.isNotEmpty) {
                    await FirebaseFirestore.instance
                        .doc(pcc.currentTimingDRpath.value)
                        .collection("foods")
                        .where(fdcs.fieldTime, isEqualTo: fdcm.fieldTime)
                        .limit(1)
                        .get()
                        .then((value) async {
                      if (value.docs.length != 1) {
                        // await FirebaseFirestore.instance
                        //     .doc(pcc.currentTimingDRpath.value)
                        //     .collection("foods")
                        //     .add(ChoiceFoodsModel(choiceIndex: pcc.activePageChoicesinMaps.value.length+1, choiceName: fdcm.fieldName, totalFoodsHas: totalFoodsHas, notes: fdcm.notes, refURL: fdcm.webURL));
                      }
                    });
                  }
                });

                Get.back();
              },
              child: const Text("Pick selected folders")),
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
          Expanded(
            child: Obx(
              () => FirestoreListView<Map<String, dynamic>>(
                shrinkWrap: true,
                query: FirebaseFirestore.instance
                    .collection(fcc.currentPathCR.value)
                    .orderBy(fdcs.isFolder, descending: true),
                itemBuilder: (context, snapshot) {
                  //Rx variables

                  Rx<bool> isItemSelected = false.obs;

                  Map<String, dynamic> fcMap = snapshot.data();

                  FoodsCollectionModel fdcm =
                      FoodsCollectionModel.fromMap(fcMap);
                  Rx<bool> isFolder = fdcm.isFolder.obs;
                  fcc.currentsPathItemsMaps.value.addAll({
                    snapshot.reference: {
                      fdcs.isItemSelected: false,
                      fdcs.itemIndex: fcc.currentsPathItemsMaps.value.length,
                      fdcs.fcModel: fdcm
                    }
                  });
                  Widget avatarW() {
                    if (fdcm.isFolder) {
                      return const Icon(
                        MdiIcons.folder,
                        color: Colors.orange,
                      );
                    } else {
                      Widget avatar = GFAvatar(
                        shape: GFAvatarShape.standard,
                        size: GFSize.MEDIUM,
                        maxRadius: 20,
                        backgroundImage: NetworkImage(fdcm.imgURL ?? ""),
                      );
                      if (fdcm.webURL?.contains("youtube.com/watch?v=") ??
                          false) {
                        return Stack(
                          children: [
                            avatar,
                            Positioned(
                              child: Container(
                                color: Colors.white70,
                                child: Icon(
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
                      fdcm.fieldName,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    icon: InkWell(
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Obx(
                            () {
                              if (isFolder.value) {
                                if (selectedUnselectedAllIndex.value == 1) {
                                  return const Icon(
                                      MdiIcons.checkboxMarkedCircle);
                                } else if (selectedUnselectedAllIndex.value ==
                                    0) {
                                  return const Icon(
                                      MdiIcons.checkboxBlankCircleOutline);
                                } else {
                                  isItemSelected.value = fcc
                                          .currentsPathItemsMaps
                                          .value[snapshot.reference]
                                      ?[fdcs.isItemSelected];
                                  if (isItemSelected.value) {
                                    return const Icon(
                                        MdiIcons.checkboxMarkedCircle);
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
                        ),
                        onTap: () {
                          if (fdcm.isFolder) {
                            selectedUnselectedAllIndex.value = 9;

                            bool isSlected = fcc.currentsPathItemsMaps
                                    .value[snapshot.reference]
                                ?[fdcs.isItemSelected];

                            fcc.currentsPathItemsMaps.value[snapshot.reference]
                                ?[fdcs.isItemSelected] = !isSlected;
                            isItemSelected.value = !isSlected;
                          }
                        }),
                    onTap: () {
                      if (fdcm.isFolder) {
                        fcc.currentPathCR.value =
                            snapshot.reference.path + fdcs.fcPathSeperator;

                        fcc.pathsListMaps.value.add(
                          {
                            fdcs.pathCR: snapshot.reference
                                .collection(fdcs.subCollections),
                            fdcs.pathCRstring: fcc.currentPathCR.value,
                            fdcs.fieldName: fdcm.fieldName
                          },
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
