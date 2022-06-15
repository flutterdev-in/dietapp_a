import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/_common_top_widget_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/helper%20widgets/folder_view_middle.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SingleFolderMiddle extends StatelessWidget {
  final FoodModel fdcm;

  final String? text;
  const SingleFolderMiddle({Key? key, required this.fdcm, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonTopWidgetMiddle(
      text: text,
      color: chatFoodCollectionColor,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          child: Row(
            children: [
              const Icon(MdiIcons.folderOutline, color: Colors.white, size: 35),
              const SizedBox(width: 15),
              Text(fdcm.foodName, style: const TextStyle(color: Colors.white)),
            ],
          ),
          onTap: () {
            if (fdcm.docRef != null) {
              fcc.listFoodModelsForPath.value.clear();
              fcc.currentCR.value =
                  fdcm.docRef!.collection(fdcs.subCollections);
              Get.to(() => FolderViewMiddle(
                    folderName: fdcm.foodName,
                    homePath: fcc.currentCR.value.path,
                  ));
            }
          },
        ),
      ),
    );
  }
}
