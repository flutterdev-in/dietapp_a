import 'package:dietapp_a/Diet%20plans/a_Main%20Screen/Appbar%20actions/diet_plan_screen_menu_button.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/w_Plan%20creation%20Screen/plan_creation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppbarActionsWidget extends StatelessWidget {
  const AppbarActionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Get.to(() =>PlanCreationScreen());
            },
            icon: Icon(MdiIcons.plus)),
        MenuButtonDietPlanScreen(),
      ],
    );
  }
}
