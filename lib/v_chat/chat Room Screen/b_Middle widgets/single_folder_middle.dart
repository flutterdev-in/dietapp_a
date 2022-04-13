import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/_common_top_widget_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/helper%20widgets/folder_view_middle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SingleFolderMiddle extends StatelessWidget {
  final FoodsCollectionModel fdcm;

  final String? text;
  const SingleFolderMiddle({Key? key, required this.fdcm, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonTopWidgetMiddle(
      text: text,
      child: InkWell(
        child: Row(
          children: [
            const Icon(MdiIcons.folderOutline, color: Colors.white),
            SizedBox(width: 15),
            Text(fdcm.fieldName, style: TextStyle(color: Colors.white)),
          ],
        ),
        onTap: () {
          if (fdcm.docRef != null) {
            fcc.pathsListMaps.value.clear();
            fcc.currentPathCR.value = FirebaseFirestore.instance
                .doc(fdcm.docRef!)
                .collection(fdcs.subCollections)
                .path;
            Get.to(() => FolderViewMiddle(
                  folderName: fdcm.fieldName,
                  homePath: fcc.currentPathCR.value,
                ));
          }
        },
      ),
    );
  }
}
