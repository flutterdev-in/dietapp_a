import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/_plan_creation_combined_screen.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ListDietPlansW extends StatelessWidget {
  const ListDietPlansW({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        activeDietPlan(),
        plannedList(),
      ],
    );
  }

  Widget activeDietPlan() {
    return GFListTile(
        avatar: const GFAvatar(
          size: GFSize.MEDIUM,
          child: Icon(MdiIcons.clipboardAccountOutline, size: 30),
        ),
        titleText: "My active diet plan",
        onTap: () async {
          pcc.currentPlanDR.value = userDR;
          pcc.currentDayDR.value = admos.activeDayDR(DateTime.now(), userUID);
          pcc.currentTimingDR.value =
              await pcc.getTimingDRfromDay(pcc.currentDayDR.value);
          pcc.isCombinedCreationScreen.value = true;
          Get.to(() => const PlanCreationCombinedScreen(
                isWeekWisePlan: false,
                isForActivePlan: true,
              ));
        });
  }

  Widget plannedList() {
    return Expanded(
      child: FirestoreListView<Map<String, dynamic>>(
        shrinkWrap: true,
        query: FirebaseFirestore.instance
            .collection(uss.users)
            .doc(userUID)
            .collection(dietpbims.dietPlansBeta),
        itemBuilder: (context, snapshot) {
          Map<String, dynamic> dietPlanMap = snapshot.data();
          DietPlanBasicInfoModel dpbim =
              DietPlanBasicInfoModel.fromMap(dietPlanMap);

          return GFListTile(
            title: Text(dpbim.planName),
            subTitle: const Text(""),
            avatar: GFAvatar(
              backgroundColor: primaryColor,
              shape: GFAvatarShape.standard,
              child: Text(
                dpbim.isWeekWisePlan ? "Weekly\nPlan" : "Daily\nPlan",
                textScaleFactor: 0.9,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            onTap: () async {
              pcc.currentPlanDR.value = snapshot.reference;
              await pcc
                  .getPlanRxValues(snapshot.reference, dpbim.isWeekWisePlan)
                  .then((value) {
                pcc.isCombinedCreationScreen.value = true;
                Get.to(() => PlanCreationCombinedScreen(
                      isWeekWisePlan: dpbim.isWeekWisePlan,
                      isForActivePlan: false,
                    ));
              });
            },
          );
        },
      ),
    );
  }
}
