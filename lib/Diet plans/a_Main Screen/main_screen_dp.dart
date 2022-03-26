import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/a_Main%20Screen/a_list_diet_plans.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainScreenDP extends StatelessWidget {
  const MainScreenDP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(),
           
          ],
        ),
        SizedBox(child: ListDietPlansW(), height: 200),
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
