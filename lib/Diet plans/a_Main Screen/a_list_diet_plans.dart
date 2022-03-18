import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/x_Days/_plan_creation_screen.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class ListDietPlansW extends StatelessWidget {
  const ListDietPlansW({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreListView<Map<String, dynamic>>(
      shrinkWrap: true,
      query: FirebaseFirestore.instance
          .collection(uss.users)
          .doc(userUID)
          .collection("dietPlans"),
      itemBuilder: (context, snapshot) {
        Map<String, dynamic> dietPlanMap = snapshot.data();
        DietPlanBasicInfoModel dpbim =
            DietPlanBasicInfoModel.fromMap(dietPlanMap);
        return GFListTile(
          titleText: dpbim.planName,
          onTap: () {
            pcc.currentPlanDocRefPath.value = snapshot.reference.path;
            Get.to(PlanCreationScreen());
          },
        );
      },
    );
  }
}
