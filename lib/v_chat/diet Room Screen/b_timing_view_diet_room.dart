import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_widget.dart';
import 'package:dietapp_a/app%20Constants/url/url_avatar.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_food_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '_diet_room_controller.dart';

class TimingsViewDietRoom extends StatelessWidget {
  final bool editingIconRequired;

  const TimingsViewDietRoom({
    Key? key,
    this.editingIconRequired = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: drc.currentDayDR.value
            .collection(atmos.timings)
            .orderBy(atmos.timingString)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text("Error while fetching data, please try again");
          } else if (!snapshot.hasData ||
              (snapshot.hasData && snapshot.data!.docs.isEmpty)) {
            return const Text("Diet not yet planned for this day");
          } else {
            var listTimingDocs = snapshot.data!.docs.map((e) {
              ActiveTimingModel atm = ActiveTimingModel.fromMap(e.data());
              atm.docRef = e.reference;
              return atm;
            }).toList();
            return ListView.builder(
              shrinkWrap: true,
              itemCount: listTimingDocs.length,
              itemBuilder: (context, index) {
                ActiveTimingModel atm = listTimingDocs[index];
                return timingsView(atm);
              },
            );
          }
        }));
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
              textScaleFactor: 1.2,
              maxLines: 1,
              style: const TextStyle(color: Colors.red),
            ),
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
              query: drc.currentDayDR.value
                  .collection(atmos.timings)
                  .doc(atm.timingString)
                  .collection(fmfpcfos.foods),
              itemBuilder: (context, doc) {
                ActiveFoodModel fm = ActiveFoodModel.fromMap(doc.data());

                return GFListTile(
                  padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                  margin:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                  avatar: URLavatar(
                      imgURL: fm.prud?.img ?? fm.trud?.img,
                      webURL: fm.prud?.url ?? fm.trud?.url),
                  title: Text(fm.foodName, maxLines: 1),
                  icon: fm.isTaken ? const Icon(MdiIcons.accountCheck) : null,
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
