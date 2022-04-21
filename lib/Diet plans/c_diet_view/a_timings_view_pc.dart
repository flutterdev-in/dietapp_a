import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_widget.dart';
import 'package:dietapp_a/app%20Constants/url/url_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class TimingsViewPC extends StatelessWidget {
  DocumentReference? dayDocRef;
  final bool editingIconRequired;
  TimingsViewPC({Key? key, this.dayDocRef, this.editingIconRequired = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dayDocRef == null) {
      return Obx(
        () => FirestoreListView<Map<String, dynamic>>(
          shrinkWrap: true,
          query: pcc.currentWeekDR.value
              .collection(daymfos.days)
              .doc(pcc.currentDayIndex.value.toString())
              .collection(dtmos.timings)
              .orderBy(dtmos.timingString, descending: false),
          itemBuilder: (context, doc) {
            return timingsView(doc);
          },
        ),
      );
    } else {
      return FirestoreListView<Map<String, dynamic>>(
        shrinkWrap: true,
        query: dayDocRef!
            .collection(dtmos.timings)
            .orderBy(dtmos.timingString, descending: false),
        itemBuilder: (context, doc) {
          return timingsView(doc);
        },
      );
    }
  }

  Widget timingsView(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    DefaultTimingModel dtm = DefaultTimingModel.fromMap(doc.data());
    RefUrlMetadataModel rumm = dtm.rumm ?? rummfos.constModel;

    return Card(
      child: Column(
        children: [
          GFListTile(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
            color: Colors.yellow.shade100,
            title: Text(
              dtm.timingName,
              maxLines: 1,
              style: const TextStyle(fontSize: 18, color: Colors.red),
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
                child: SizedBox(
              child: Text(dtm.notes!),
              width: double.maxFinite,
            )),
          FirestoreListView<Map<String, dynamic>>(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              query: doc.reference
                  .collection(fmfpcfos.foods)
                  .orderBy(fmfpcfos.foodAddedTime, descending: false),
              itemBuilder: (context, doc) {
                FoodsModelForPlanCreation fm =
                    FoodsModelForPlanCreation.fromMap(doc.data());
                return GFListTile(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  margin:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                  avatar: URLavatar(imgURL: fm.rumm?.img, webURL: fm.rumm?.url),
                  title: Text(fm.foodName, maxLines: 1),
                  subTitleText:
                      (fm.notes == null || fm.notes == "") ? null : fm.notes,
                );
              }),
        ],
      ),
    );
  }
}
