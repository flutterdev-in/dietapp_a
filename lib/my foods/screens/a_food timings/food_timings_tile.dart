import 'package:dietapp_a/my%20foods/screens/a_food%20timings/food_timings_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FoodTimingsTile extends StatelessWidget {
  const FoodTimingsTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      avatar: const Icon(MdiIcons.alarm),
      titleText: "Food Timings",
      onTap: () {
        Get.to(() => FoodTimingsScreen());
      },
    );
  }
}
