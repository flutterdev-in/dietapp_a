import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Screens/plan_edit_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class MainScreenDP extends StatelessWidget {
  const MainScreenDP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GFListTile(
          titleText: "Create plan",
          onTap: () => Get.to(PlanEditMainScreen()),
        ),
        GFListTile(
          titleText: "Diet Plans",
        ),
        GFListTile(
          titleText: "Day models",
        ),
        GFListTile(
          titleText: "Timing models",
        ),
      ],
    );
  }
}
