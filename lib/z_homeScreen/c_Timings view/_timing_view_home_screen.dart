import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_widget.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_food_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';
import 'package:dietapp_a/z_homeScreen/c_Timings%20view/a_timings_row_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../y_Active diet/controllers/active_plan_controller.dart';
import 'b_cam_pictures_timings_view.dart';
import 'c_foods_list_timings_view.dart';

//
class TimingViewHomeScreen extends StatelessWidget {
  final bool editingIconRequired;

  const TimingViewHomeScreen({Key? key, this.editingIconRequired = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: apc.currentActiveDayDR.value
            .collection(atmos.timings)
            .orderBy(atmos.timingString)
            .snapshots(),
        builder: (context, snapshot) {
          List<ActiveTimingModel> listTimings = [];
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            listTimings = snapshot.data!.docs.map((e) {
              var atm = ActiveTimingModel.fromMap(e.data());
              atm.docRef = e.reference;
              return atm;
            }).toList();
          }

          return FutureBuilder<List<ActiveTimingModel>>(
              future: atmos.getMergedActiveTimings(
                  listTimings, apc.currentActiveDayDR.value),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  listTimings = snapshot.data!;
                }

                return Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listTimings.length,
                    itemBuilder: (context, index) {
                      ActiveTimingModel atm = listTimings[index];
                      atm.docRef = apc.currentActiveDayDR.value
                          .collection(atmos.timings)
                          .doc(atm.timingString);

                      return timingsView(context, atm);
                    },
                  ),
                );
              });
        }));
  }

  Widget timingsView(BuildContext context, ActiveTimingModel atm) {
    RefUrlMetadataModel rumm = atm.prud ?? rummfos.constModel;

    return Card(
      child: Column(
        children: [
          TimingsRowHomeScreen(atm: atm),
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
          CamPicturesTimingsView(atm: atm),
          Container(
              color: Colors.green.shade50,
              child: FoodsListTimingsView(atm: atm, foodTypePlanUp: afmos.up)),
          FoodsListTimingsView(atm: atm, foodTypePlanUp: afmos.plan),
        ],
      ),
    );
  }
}
