import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimingFoodsListView extends StatelessWidget {
  const TimingFoodsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () {
          if (pcc.currentTimingDR.value != userDR) {
            return listview(pcc.currentTimingDR.value);
          } else {
            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .doc(pcc.currentPlanDRpath.value)
                  .collection(wmfos.weeks)
                  .doc(pcc.currentWeekIndex.value.toString())
                  .collection(daymfos.days)
                  .doc(pcc.currentDayIndex.value.toString())
                  .collection(dtmos.timings)
                  .orderBy(dtmos.timingString, descending: false)
                  .limit(1)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.docs.length == 1) {
                  Map<String, dynamic> dataMap =
                      snapshot.data!.docs.first.data() as Map<String, dynamic>;

                  return listview(snapshot.data!.docs.first.reference);
                } else {
                  return const SizedBox();
                }
              },
            );
          }
        },
      ),
    );
  }

  Widget listview(DocumentReference<Object?> dr) {
    pcc.curreTimingDRpath.value = dr.path;
    return FirestoreListView<Map<String, dynamic>>(
      shrinkWrap: true,
      query: dr.collection("foods"),
      itemBuilder: (context, doc) {
        Map<String, dynamic> foodMap = doc.data();

        FoodsModelForPlanCreation fm =
            FoodsModelForPlanCreation.fromMap(foodMap);
        pcc.currentFoodChoiceIndex.value = fm.choiceIndex;
        pcc.currentFoodOptionIndex.value = fm.optionIndex;
        pcc.currentFoodIndex.value = fm.foodIndex;
        return Text(fm.toMap().toString());
      },
    );
  }
}
