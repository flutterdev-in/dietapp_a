import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_widget.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';
import 'package:dietapp_a/y_Models/timing_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TimingInfoViewPC extends StatelessWidget {
  final bool editingIconRequired;
  const TimingInfoViewPC({Key? key, this.editingIconRequired = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (pcc.currentTimingDR.value == userDR) {
          return const SizedBox();
        } else {
          return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: pcc.currentTimingDR.value.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.exists) {
                Map<String, dynamic> dataMap =
                    snapshot.data!.data() as Map<String, dynamic>;

                TimingModel dtm;
                if (pcc.currentDayDR.value.parent.id == admos.activeDaysPlan) {
                  dtm = dtmos.dtmFromATM(TimingModel.fromMap(dataMap));
                } else {
                  dtm = TimingModel.fromMap(dataMap);
                }
                dtm.docRef = snapshot.data!.reference;

                String notes = dtm.notes ?? "";
                RefUrlMetadataModel rumm = dtm.rumm ?? rummfos.constModel;
                return Column(
                  children: [
                    Card(
                      color: Colors.yellow.shade50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child:
                                  // Text(snapshot.data!.data().toString()),
                                  RefURLWidget(refUrlMetadataModel: rumm),
                              color: Colors.deepOrange.shade50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                " Timing notes",
                                style: TextStyle(color: Colors.orange),
                              ),
                              if (editingIconRequired)
                                IconButton(
                                    padding: const EdgeInsets.all(0.0),
                                    onPressed: () => notesEdit(context, notes),
                                    icon: const Icon(
                                        MdiIcons.clipboardEditOutline))
                            ],
                          ),
                          if (notes.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 3),
                              child: Text(notes),
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              }

              return Container();
            },
          );
        }
      },
    );
  }

  void notesEdit(BuildContext context, String notes) {
    Rx<String> rxNotes = notes.obs;
    alertDialogW(
      context,
      body: Column(
        children: [
          Container(
            constraints: const BoxConstraints(
              minHeight: 100,
              maxHeight: 250,
            ),
            child: TextField(
              maxLines: null,
              autofocus: true,
              controller: TextEditingController(text: notes),
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                  // isDense: true,
                  contentPadding: EdgeInsets.all(5),
                  hintText: "Notes"
                  // labelText: "Notes",
                  ),
              onChanged: (value) {
                rxNotes.value = value;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Get.back();
                  },
                  child: const Text("Close")),
              ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    Get.back();
                    if (pcc.currentDayDR.value.parent.id ==
                        admos.activeDaysPlan) {
                      await pcc.currentTimingDR.value
                          .update({"$unIndexed.$notes0": rxNotes.value});
                    } else {
                      await pcc.currentTimingDR.value
                          .update({"$unIndexed.$notes0": rxNotes.value});
                    }
                  },
                  child: const Text("Update")),
            ],
          )
        ],
      ),
    );
  }
}
