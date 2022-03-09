import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/rx_variables.dart';
import 'package:flutter/material.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FoodsCollectionListView extends StatelessWidget {
  const FoodsCollectionListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    rxfcv.mapCollectionIDs.value = {};
    return FirestoreListView<Map<String, dynamic>>(
      shrinkWrap: true,
      query: FirebaseFirestore.instance
          .collection(fdcs.foodsCollectionPath0)
          .orderBy(fdcs.fieldTime),
      itemBuilder: (context, snapshot) {
        rxfcv.mapCollectionIDs.addAll({
          snapshot.reference.id: {"isSelectedForDelete": false}
        });

        Rx<bool> isSelectedForDelete = false.obs;
        Map<String, dynamic> fcMap = snapshot.data();

        FoodsCollectionModel fdcm = FoodsCollectionModel.fromMap(fcMap);
        return GFListTile(
          padding: EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          avatar: Icon(MdiIcons.folder),
          title: Text(fdcm.fieldName),
          icon: Obx(() {
            isSelectedForDelete.value = rxfcv
                .mapCollectionIDs[snapshot.reference.id]["isSelectedForDelete"];
            if (rxfcv.isDeletePressed.value && isSelectedForDelete.value) {
              return Icon(MdiIcons.checkboxIntermediate);
            } else if (rxfcv.isDeletePressed.value &&
                !isSelectedForDelete.value) {
              return Icon(MdiIcons.checkboxBlankOutline);
            } else {
              return SizedBox();
            }
          }),
          onTap: () {
            if (rxfcv.isDeletePressed.value) {
              isSelectedForDelete.value = !isSelectedForDelete.value;
              rxfcv.mapCollectionIDs[snapshot.reference.id]
                  ["isSelectedForDelete"] = isSelectedForDelete.value;
            }
          },
        );
      },
    );
  }
}
