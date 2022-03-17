import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Screens/Basic%20details/a_plan_basic_details.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Screens/Create%20diet/create_diet_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PlanEditMainScreen extends StatelessWidget {
  const PlanEditMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Card(
            child: Column(
              children: [
                GFListTile(
                  padding: const EdgeInsets.all(0),
                  titleText: "Diet Plan 1",
                  onTap: () => Get.to(() => PlanBasicDetails()),
                  icon: Icon(MdiIcons.squareEditOutline),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: Text("Notes"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(""),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: GFListTile(
                    titleText: "Create diet",
                    onTap: () => Get.to(() => CreateDietMainScreen()),
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: GFListTile(
              titleText: "Create diet",
              onTap: () => Get.to(() => CreateDietMainScreen()),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GFButton(onPressed: null, child: Text("Preview")),
              GFButton(onPressed: null, child: Text("Submit")),
            ],
          ),
        ],
      ),
    );
  }
}
