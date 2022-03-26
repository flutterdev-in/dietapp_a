import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/timing_info_model.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

class TimingInfoViewPC extends StatelessWidget {
  const TimingInfoViewPC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => StreamBuilder<DocumentSnapshot>(
        stream: pcc.currentTimingDR.value.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> dataMap =
                snapshot.data!.data() as Map<String, dynamic>;
            DefaultTimingModel dtm = DefaultTimingModel.fromMap(dataMap);
            String notes = dtm.notes ?? "";
            RefUrlMetadataModel rumm = RefUrlMetadataModel.fromMap(
                dtm.refUrlMetadata ?? rummfos.constModel.toMap());
            return Column(
              children: [
                Card(
                  child: LimitedBox(
                    maxHeight: 150,
                    child: TextField(
                      maxLines: null,
                      autofocus: false,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(5),
                          hintText: "Notes"
                          // labelText: "Notes",
                          ),
                      onChanged: (value) {},
                    ),
                  ),
                ),
                RefURLWidget(refUrlMetadataModel: rumm),
                Divider(
                  height: 0.5,
                  thickness: 2,
                )
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
