import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_widget.dart';
import 'package:dietapp_a/app%20Constants/url/url_avatar.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_food_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../y_Active diet/controllers/active_plan_controller.dart';
import '../../../y_Active diet/models/active_timing_model.dart';

class ActiveTimingsView extends StatelessWidget {
  final bool editingIconRequired;
  const ActiveTimingsView({Key? key, this.editingIconRequired = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => FirestoreListView<Map<String, dynamic>>(
          shrinkWrap: true,
          query: apc.cuurentActiveDayDR.value
              .collection(atmos.timings)
              .orderBy(atmos.timingString),
          itemBuilder: (context, qDS) {
            ActiveTimingModel atm = ActiveTimingModel.fromMap(qDS.data());

            return timingsView(atm);
          },
        ));
  }

  Widget timingsView(ActiveTimingModel atm) {
    RefUrlMetadataModel rumm = atm.prud ?? rummfos.constModel;

    return Card(
      child: Column(
        children: [
          GFListTile(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
            color: Colors.yellow.shade100,
            title: Text(
              atm.timingName,
              maxLines: 1,
              style: const TextStyle(fontSize: 18, color: Colors.red),
            ),
            icon: Text(dtmos.displayTiming(atm.timingString)),
          ),
          if (atm.prud != null)
            RefURLWidget(
              refUrlMetadataModel: rumm,
              editingIconRequired: editingIconRequired,
            ),
          if (atm.plannedNotes != null && atm.plannedNotes != "")
            Card(
                child: SizedBox(
              child: Text(atm.plannedNotes!),
              width: double.maxFinite,
            )),
          FirestoreListView<Map<String, dynamic>>(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              query: apc.cuurentActiveDayDR.value
                  .collection(atmos.timings)
                  .doc(atm.timingString)
                  .collection(fmfpcfos.foods),
              itemBuilder: (context, doc) {
                ActiveFoodModel fm = ActiveFoodModel.fromMap(doc.data());

                return GFListTile(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  margin:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                  avatar: URLavatar(
                      imgURL: fm.prud?.img ?? fm.trud?.img,
                      webURL: fm.prud?.url ?? fm.trud?.url),
                  title: Text(fm.foodName, maxLines: 1),
                  icon: Icon(fm.isTaken
                      ? MdiIcons.checkDecagram
                      : MdiIcons.progressClock),
                  subTitleText:
                      (fm.plannedNotes == null || fm.plannedNotes == "")
                          ? null
                          : fm.plannedNotes,
                );
              }),
        ],
      ),
    );
  }
}
