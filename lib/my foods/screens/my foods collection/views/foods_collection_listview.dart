import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/functions/fc_count_of_selected_items.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/rx_variables.dart';
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
            .collection(rxfcv.currentPathCR.value)
            .orderBy(fdcs.fieldTime),
        itemBuilder: (context, snapshot) {
          //Rx variables
          Rx<bool> isItemSelected = false.obs;

          //
          // rxfcv.currentPathItemsListMaps.add({
          //   snapshot.reference: {fdcs.isItemSelected: false}
          // });

          Map<String, dynamic> fcMap = snapshot.data();

          FoodsCollectionModel fdcm = FoodsCollectionModel.fromMap(fcMap);
          rxfcv.currentsPathItemsMaps.addAll({
            snapshot.reference: {
              fdcs.isItemSelected: false,
              fdcs.itemIndex: rxfcv.currentsPathItemsMaps.length,
              fdcs.fcModel: fdcm
            }
          });
          return GFListTile(
            padding: EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            avatar: Icon(
              MdiIcons.folder,
              color: Colors.orange,
            ),
            title: Text(fdcm.fieldName),
            icon: Obx(() {
              isItemSelected.value =
                  rxfcv.currentsPathItemsMaps[snapshot.reference]
                      [fdcs.isItemSelected];
              if (rxfcv.isSelectionStarted.value) {
                if (rxfcv.isSelectAll.value) {
                  return Icon(MdiIcons.checkboxMarkedCircle);
                } else if (rxfcv.isUnselectAll.value) {
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
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: Icon(
                      MdiIcons.circleOutline,
                      size: 9,
                      color: Colors.green,
                    ),
                  ),
                  onTap: () {
                    rxfcv.isSelectAll.value = false;
                    rxfcv.isUnselectAll.value = false;
                    rxfcv.currentsPathItemsMaps[snapshot.reference]
                        [fdcs.isItemSelected] = true;
                    rxfcv.isSelectionStarted.value = true;
                    rxfcv.itemsSelectionCount.value =
                        fcCountOfSelectedItems(rxfcv.currentsPathItemsMaps);
                  },
                );
              }
            }),
            onTap: () {
              rxfcv.isSelectAll.value = false;
              rxfcv.isUnselectAll.value = false;
              if (rxfcv.isSelectionStarted.value) {
                isItemSelected.value = !isItemSelected.value;
                rxfcv.currentsPathItemsMaps[snapshot.reference]
                    [fdcs.isItemSelected] = isItemSelected.value;
                rxfcv.itemsSelectionCount.value =
                    fcCountOfSelectedItems(rxfcv.currentsPathItemsMaps);
              } else {
                rxfcv.selecAllUnselectAll(trueSelectAllfalseUnselectAll: false);
                rxfcv.currentPathCR.value =
                    snapshot.reference.path + fdcs.fcPathSeperator;

                rxfcv.pathsListMaps.add(
                  {
                    fdcs.pathCR: rxfcv.currentPathCR.value,
                    fdcs.fieldName: fdcm.fieldName
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
