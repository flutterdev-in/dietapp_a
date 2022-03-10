import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/rx_variables.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class OnSelectedTopBarForFoodCollection extends StatelessWidget {
  const OnSelectedTopBarForFoodCollection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            child: Icon(MdiIcons.close),
            onPressed: () async {
              await Future.delayed(Duration(milliseconds: 50));
              rxfcv.isSelectionStarted.value = !rxfcv.isSelectionStarted.value;
              rxfcv.isSelectAll.value = false;
              rxfcv.isUnselectAll.value = true;
              rxfcv.currentsPathItemsMaps.forEach((snapRef, thisItemMap) {
                rxfcv.currentsPathItemsMaps[snapRef][fdcs.isItemSelected] =
                    false;
              });
            },
          ),
          TextButton(
            child: const Text("Unselect all"),
            onPressed: () {
              rxfcv.isUnselectAll.value = true;
              rxfcv.isSelectAll.value = false;
              rxfcv.selecAllUnselectAll(trueSelectAllfalseUnselectAll: false);
              // rxfcv.currentsPathItemsMaps.forEach((snapRef, thisItemMap) {
              //   rxfcv.currentsPathItemsMaps[snapRef][fdcs.isItemSelected] =
              //       false;
              // });
            },
          ),
          TextButton(
            child: const Text("Select all"),
            onPressed: () {
              rxfcv.isSelectAll.value = true;
              rxfcv.isUnselectAll.value = false;
              rxfcv.selecAllUnselectAll(trueSelectAllfalseUnselectAll: true);
              // rxfcv.currentsPathItemsMaps.forEach((snapRef, thisItemMap) {
              //   rxfcv.currentsPathItemsMaps[snapRef][fdcs.isItemSelected] =
              //       true;
              // });
              // await FirebaseFirestore.instance.collection(fdcs.foodsCollectionPath0).add(FoodsCollectionModel(fieldName: "fieldName", fieldTime: Timestamp.fromDate(DateTime.now()), isFolder: true).toMap());
            },
          ),
        ],
      ),
    );
  }
}
