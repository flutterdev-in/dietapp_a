import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_widget.dart';
import 'package:dietapp_a/app%20Constants/url/url_avatar.dart';
import 'package:dietapp_a/x_customWidgets/expandable_text.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:dietapp_a/y_Models/timing_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class TimingsViewPC extends StatelessWidget {
  final bool editingIconRequired;
  const TimingsViewPC({Key? key, this.editingIconRequired = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => FirestoreListView<Map<String, dynamic>>(
          shrinkWrap: true,
          query: pcc.currentDayDR.value
              .collection(dtmos.timings)
              .orderBy(dtmos.timingString, descending: false),
          itemBuilder: (context, qDocSnap) {
            return timingsView(qDocSnap);
          },
        ));
  }

  Widget timingsView(QueryDocumentSnapshot<Map<String, dynamic>> qDocSnap) {
    TimingModel dtm = TimingModel.fromMap(qDocSnap.data());
    RefUrlMetadataModel rumm = dtm.rumm ?? rummfos.constModel;

    return Card(
      child: Column(
        children: [
          GFListTile(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
            color: secondaryColor,
            title: Text(
              dtm.timingName,
              maxLines: 2,
              style: const TextStyle(fontSize: 18),
            ),
            icon: Text(dtmos.displayTiming(dtm.timingString)),
          ),
          if (dtm.rumm != null)
            RefURLWidget(
              refUrlMetadataModel: rumm,
              editingIconRequired: editingIconRequired,
            ),
          if (dtm.notes != null && dtm.notes != "")
            Card(
              child: expText(
                dtm.notes,
                fontSize: 13,
              ),
            ),
          FirestoreListView<Map<String, dynamic>>(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              query: qDocSnap.reference
                  .collection(fmfpcfos.foods)
                  .orderBy(fmfpcfos.foodAddedTime, descending: false),
              itemBuilder: (context, doc) {
                FoodModel fm = FoodModel.fromMap(doc.data());
                return GFListTile(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  margin:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                  avatar: URLavatar(imgURL: fm.rumm?.img, webURL: fm.rumm?.url),
                  title: Text(fm.foodName, maxLines: 1),
                  subTitle: expText(
                    fm.notes,
                    fontSize: 13,
                  ),
                  // subTitleText:
                  //     (fm.notes == null || fm.notes == "") ? null : fm.notes,
                );
              }),
        ],
      ),
    );
  }
}
