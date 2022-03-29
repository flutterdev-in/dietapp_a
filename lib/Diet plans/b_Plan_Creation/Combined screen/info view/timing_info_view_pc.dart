import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';

import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_widget.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TimingInfoViewPC extends StatelessWidget {
  const TimingInfoViewPC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => StreamBuilder<DocumentSnapshot>(
        stream: pcc.currentTimingDR.value.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic> dataMap =
                snapshot.data!.data() as Map<String, dynamic>;
            DefaultTimingModel dtm = DefaultTimingModel.fromMap(dataMap);
            String notes = dtm.notes ?? "";
            RefUrlMetadataModel rumm = RefUrlMetadataModel.fromMap(
                dtm.refUrlMetadata ?? rummfos.constModel.toMap());
            return Column(
              children: [
                Card(
                  color: Colors.yellow.shade50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: RefURLWidget(refUrlMetadataModel: rumm),
                          color: Colors.deepOrange.shade50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Timing notes",
                            style: TextStyle(color: Colors.orange),
                          ),
                          IconButton(
                              padding: const EdgeInsets.all(0.0),
                              onPressed: () => notesEdit(context, notes),
                              icon: Icon(MdiIcons.clipboardEditOutline))
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
      ),
    );
  }

  void notesEdit(BuildContext context, String notes) {
    Rx<String> rxNotes = notes.obs;
    alertDialogueW(
      context,
      body: Column(
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: 100,
              maxHeight: 250,
            ),
            child: TextField(
              maxLines: null,
              autofocus: true,
              controller: TextEditingController(text: notes),
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
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
                  child: Text("Close")),
              ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    Get.back();

                    await pcc.currentTimingDR.value
                        .update({dtmos.notes: rxNotes.value});
                  },
                  child: Text("Update")),
            ],
          )
        ],
      ),
    );
  }
}
