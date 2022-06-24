import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_widget.dart';
import 'package:dietapp_a/app%20Constants/url/url_avatar.dart';
import 'package:dietapp_a/v_chat/models/chat_room_model.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:dietapp_a/y_Models/timing_model.dart';
import 'package:dietapp_a/z_homeScreen/c_Timings%20view/b_cam_pictures_timings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '_diet_room_controller.dart';

class TimingsViewDietRoom extends StatelessWidget {
  final bool editingIconRequired;
  final ChatRoomModel crm;

  const TimingsViewDietRoom(
    this.crm, {
    Key? key,
    this.editingIconRequired = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: drc.currentDayDR.value
            .collection(tmos.timings)
            .orderBy(tmos.timingString)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text("Error while fetching data, please try again");
          } else if (!snapshot.hasData ||
              (snapshot.hasData && snapshot.data!.docs.isEmpty)) {
            return const Text("Diet not yet planned for this day");
          } else {
            var listTimingDocs = snapshot.data!.docs.map((e) {
              TimingModel atm = TimingModel.fromMap(e.data());
              atm.docRef = e.reference;
              return atm;
            }).toList();
            return ListView.builder(
              shrinkWrap: true,
              itemCount: listTimingDocs.length,
              itemBuilder: (context, index) {
                TimingModel atm = listTimingDocs[index];

                return timingsView(atm);
              },
            );
          }
        }));
  }

  Widget timingsView(TimingModel atm) {
    RefUrlMetadataModel rumm = atm.rumm ?? rummfos.constModel;

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
          if (atm.rumm != null)
            RefURLWidget(
              refUrlMetadataModel: rumm,
              editingIconRequired: editingIconRequired,
            ),
          if (atm.notes != null && atm.notes != "")
            Card(
                child: SizedBox(
              child: Text(atm.notes!),
              width: double.maxFinite,
            )),
          CamPicturesTimingsView(atm, isActionAllowed: false),
          FirestoreListView<Map<String, dynamic>>(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              query: atm.docRef!
                  .collection(fmfpcfos.foods)
                  .where(fmos.isCamFood, isEqualTo: false)
                  .orderBy(fmos.foodAddedTime, descending: false),
              itemBuilder: (context, doc) {
                FoodModel fm = FoodModel.fromMap(doc.data());
                fm.docRef = doc.reference;

                return GFListTile(
                  padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                  margin:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                  avatar: UrlAvatar(fm.rumm),
                  title: Text(fm.foodName, maxLines: 1),
                  icon: fm.foodTakenTime != null
                      ? const Icon(MdiIcons.accountCheck)
                      : null,
                  subTitleText:
                      (fm.notes == null || fm.notes == "") ? null : fm.notes,
                );
              }),
        ],
      ),
    );
  }
}
