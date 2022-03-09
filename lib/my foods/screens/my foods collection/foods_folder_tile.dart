import 'package:dietapp_a/my%20foods/screens/a_food%20timings/food_timings_edit_screen.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/_foods_folder_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FoodsFolderTile extends StatelessWidget {
  const FoodsFolderTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      avatar: const Icon(MdiIcons.folderOpenOutline),
      titleText: "My Foods",
      onTap: () {
        Get.to(() => MyFoodsCollectionView());
      },
    );
  }
}
