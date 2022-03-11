import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/functions/fc_useful_functions.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
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
            .orderBy(fdcs.fieldTime),
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
          return GFListTile(
            padding: const EdgeInsets.fromLTRB(0, 5, 8, 0),
            margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            avatar:const Icon(
              MdiIcons.folder,
              color: Colors.orange,
            ),
            title: Text(fdcm.fieldName),
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
                  child:const SizedBox(
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
              } else {
                // fcufs.selecAllUnselectAll(trueSelectAllfalseUnselectAll: false);
                fcc.currentPathCR.value =
                    snapshot.reference.path + fdcs.fcPathSeperator;

                fcc.pathsListMaps.value.add(
                  {
                    fdcs.pathCR:
                        snapshot.reference.collection(fdcs.subCollections),
                    fdcs.pathCRstring: fcc.currentPathCR.value,
                    fdcs.fieldName: fdcm.fieldName
                  },
                );
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
