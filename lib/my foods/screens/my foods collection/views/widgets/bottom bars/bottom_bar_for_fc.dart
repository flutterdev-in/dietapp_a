import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/functions/nested_func.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/rx_variables.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/bottom%20bars/buttons/d_delete_fc.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/bottom%20bars/buttons/r_rename_fc.dart';
import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class OnSelectedBottomBarForFoodCollection extends StatelessWidget {
  const OnSelectedBottomBarForFoodCollection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late List<DocumentReference> listDRs = [];
    return Container(
      height: 50,
      color: Colors.black12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(MdiIcons.contentCopy),
            onPressed: () async {
              if (rxfcv.itemsSelectionCount.value > 0) {
                rxfcv.currentsPathItemsMaps.forEach((snapRef, thisItemMap) {
                  if (thisItemMap[fdcs.isItemSelected] ?? false) {
                    listDRs.add(snapRef);
                  }
                });
                rxfcv.isSelectionStarted.value = false;
              }
            },
          ),
          IconButton(
              onPressed: () async {
                print(listDRs);
                BatchCopyNestedCollections bcnc = BatchCopyNestedCollections();
                await bcnc.batchCopy(
                  listSourceDR: listDRs,
                  targetSubCRstring: rxfcv.currentPathCR.value,
                );
              },
              icon: const Icon(MdiIcons.pasta)),
          fcItemEditButton(),
          TextButton(
            child: const Text("Delete"),
            onPressed: () async {
              await deleteItemsFromFC(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> batchCopy() async {
    late List<DocumentReference> listDRs = [];
    rxfcv.currentsPathItemsMaps.forEach((snapRef, thisItemMap) {
      if (thisItemMap[fdcs.isItemSelected] ?? false) {
        listDRs.add(snapRef.reference);
      }
    });

    BatchCopyNestedCollections bcnc = BatchCopyNestedCollections();
    await bcnc.batchCopy(
      listSourceDR: listDRs,
      targetSubCRstring: rxfcv.currentPathCR.value,
    );
  }
}
