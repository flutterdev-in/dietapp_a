import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/coice_foods_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/timing_info_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/z_Foods/-foods_screen_pc.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ChoiceFoodsListView extends StatelessWidget {
  final DocumentReference docRef;
  ChoiceFoodsListView({Key? key, required this.docRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreListView<Map<String, dynamic>>(
      shrinkWrap: true,
      query: docRef
          .collection(choiceFMS.choices)
          .orderBy(choiceFMS.choiceIndex, descending: false),
      itemBuilder: (context, snapshot) {
        Map<String, dynamic> dataMap = snapshot.data();
        ChoiceFoodsModel cfm = ChoiceFoodsModel.fromMap(dataMap);
        pcc.activePageChoicesinMaps.value.addAll({snapshot.reference: cfm});

        return GFListTile(
          titleText: cfm.choiceName,
          icon: Icon(MdiIcons.dotsVertical),
          onTap: () {
            pcc.selectedChoiceMap.value.clear();
            pcc.selectedChoiceMap.value.addAll({snapshot.reference: cfm});

            Get.to(FoodsScreenPC());
          },
        );
      },
    );
  }
}
