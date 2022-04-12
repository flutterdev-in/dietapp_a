import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/functions/fc_useful_functions.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FoodsCollectionListView extends StatelessWidget {
  const FoodsCollectionListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return Obx(
      () => FirestoreListView<Map<String, dynamic>>(
        shrinkWrap: true,
        query: FirebaseFirestore.instance
            .collection(fcc.currentPathCR.value)
            .orderBy(fdcs.isFolder, descending: true)
            .orderBy(fdcs.fieldTime, descending: false),
        itemBuilder: (context, snapshot) {
          //Rx variables
          Rx<bool> isItemSelected = false.obs;

          Map<String, dynamic> fcMap = snapshot.data();

          FoodsCollectionModel fdcm = FoodsCollectionModel.fromMap(fcMap);

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
              if (fdcm.webURL?.contains("youtube.com/watch?v=") ?? false) {
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
            margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            avatar: avatarW(),
            title: Text(
              fdcm.fieldName,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            icon: Obx(() {
              isItemSelected.value = fcc.currentsPathItemsMaps
                  .value[snapshot.reference]?[fdcs.isItemSelected];
              if (fcc.isSelectionStarted.value) {
                if (fcc.isSelectAll.value) {
                  return Icon(MdiIcons.checkboxMarkedCircle);
                } else if (fcc.isUnselectAll.value) {
                  return Icon(MdiIcons.checkboxBlankCircleOutline);
                } else if (isItemSelected.value) {
                  return Icon(MdiIcons.checkboxMarkedCircle);
                } else if (!isItemSelected.value) {
                  return Icon(MdiIcons.checkboxBlankCircleOutline);
                } else {
                  return SizedBox();
                }
              } else {
                return InkWell(
                  child: const SizedBox(
                    width: 20,
                    height: 20,
                    child: Icon(
                      MdiIcons.circleOutline,
                      size: 9,
                      color: Colors.green,
                    ),
                  ),
                  onTap: () {
                    fcc.isSelectAll.value = false;
                    fcc.isUnselectAll.value = false;
                    fcc.currentsPathItemsMaps.value[snapshot.reference]
                        ?[fdcs.isItemSelected] = true;
                    fcc.isSelectionStarted.value = true;
                    fcc.itemsSelectionCount.value = fcufs.countSelectedItems();
                  },
                );
              }
            }),
            onTap: () {
              fcc.isSelectAll.value = false;
              fcc.isUnselectAll.value = false;
              if (fcc.isSelectionStarted.value) {
                isItemSelected.value = !isItemSelected.value;
                fcc.currentsPathItemsMaps.value[snapshot.reference]
                    ?[fdcs.isItemSelected] = isItemSelected.value;
                fcc.itemsSelectionCount.value = fcufs.countSelectedItems();
              } else if (fdcm.isFolder) {
                fcc.currentPathCR.value =
                    snapshot.reference.collection(fdcs.subCollections).path;
                print(fcc.currentPathCR.value);
                fcc.pathsListMaps.value.add(
                  {
                    fdcs.pathCR:
                        snapshot.reference.collection(fdcs.subCollections),
                    fdcs.pathCRstring: fcc.currentPathCR.value,
                    fdcs.fieldName: fdcm.fieldName
                  },
                );
              } else {
                // bc.loadURl(fdcm.webURL ?? "");
              }
            },
            onLongPress: () {
              fcc.isSelectAll.value = false;
              fcc.isUnselectAll.value = false;
              fcc.isSelectionStarted.value = true;
              isItemSelected.value = true;
              fcc.currentsPathItemsMaps.value[snapshot.reference]
                  ?[fdcs.isItemSelected] = true;
              fcc.itemsSelectionCount.value = fcufs.countSelectedItems();
            },
          );
        },
      ),
    );
  }
}
