import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/y_Timings/timings_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class DaysListViewOnPlanCreation extends StatelessWidget {
  final DocumentReference docRef;
  const DaysListViewOnPlanCreation({Key? key, required this.docRef})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FirestoreListView<Map<String, dynamic>>(
        shrinkWrap: true,
        query: docRef.collection("days").orderBy(daypbims.docEntryTime),
        itemBuilder: (context, snapshot) {
          Map<String, dynamic> dataMap = snapshot.data();
          DayPlanBasicInfoModel daypbim =
              DayPlanBasicInfoModel.fromMap(dataMap);
          pcc.lastDayIndex.value = daypbim.dayIndex;
          return Card(
            child: GFListTile(
              titleText: "Day " + daypbim.dayIndex.toString(),
              onTap: () {
                pcc.currentDayDRpath.value = snapshot.reference.path;
                Get.to(TimingsEditScreen());
              },
            ),
          );
        },
      ),
    );
  }
}
