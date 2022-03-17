import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/a_Main%20Screen/a_list_diet_plans.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/x_Days/plan_creation_screen.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
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
            createPlan(context),
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

  Widget createPlan(BuildContext context) {
    Rx<String> rxName = "".obs;
    return IconButton(
      icon: Icon(MdiIcons.plus),
      onPressed: () {
        alertDialogueW(
          context,
          body: LimitedBox(
            maxHeight: 170,
            child: Stack(
              children: [
                Positioned(
                  child: InkWell(
                    child: Container(
                      color: Colors.red.shade50,
                      child: const Icon(MdiIcons.close),
                      width: 20,
                      height: 20,
                    ),
                    onTap: () => Get.back(),
                  ),
                  top: 3,
                  right: 3,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        autofocus: true,
                        onChanged: (tcName) {
                          rxName.value = tcName;
                        },
                        decoration: InputDecoration(
                          labelText: "Plan Name",
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection(uss.users)
                              .doc(userUID)
                              .collection("dietPlans")
                              .add({"planName": rxName.value}).then((value) {
                            pcc.currentPlanDocRefPath.value = value.path;
                          });
                          Get.back();
                          Get.to(PlanCreationScreen());
                          print("objectsvvv");
                        },
                        child: Text("Continue")),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
