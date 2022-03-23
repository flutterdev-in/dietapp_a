import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller0.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/coice_foods_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/timing_info_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/z_Foods/-foods_screen_pc.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TimingsListViewOnPlanCreation extends StatelessWidget {
  final DocumentReference docRef;
  const TimingsListViewOnPlanCreation({Key? key, required this.docRef})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreListView<Map<String, dynamic>>(
      shrinkWrap: true,
      query: docRef
          .collection(tims.timings)
          .orderBy(tims.timingIndex, descending: false),
      itemBuilder: (context, snapshot) {
        Map<String, dynamic> dataMap = snapshot.data();
        TimingInfoModel tim = TimingInfoModel.fromMap(dataMap);

        return GFListTile(
          titleText: tim.timingName,
          icon: const Icon(MdiIcons.dotsVertical),
          onTap: () async {
            

            pcc0.currentTimingDRpath.value = snapshot.reference.path;
            pcc0.activePageTimingsMaps.value.addAll({snapshot.reference: tim});

            pcc0.choiceCounts.value = 0;
            Get.to(FoodsScreenPC());
          },
        );
      },
    );
  }
}
