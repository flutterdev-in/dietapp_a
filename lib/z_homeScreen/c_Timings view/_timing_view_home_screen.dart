import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_widget.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:dietapp_a/y_Active%20diet/controllers/active_plan_controller.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_food_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';
import 'package:dietapp_a/z_homeScreen/c_Timings%20view/a_timings_row_home_screen.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import 'b_cam_pictures_timings_view.dart';
import 'c_foods_list_timings_view.dart';

//
class TimingViewHomeScreen extends StatelessWidget {
  final bool editingIconRequired;
  final bool? isDayExists;

  const TimingViewHomeScreen({
    Key? key,
    required this.isDayExists,
    this.editingIconRequired = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isDayExists == true) {
      return Obx(() => FirestoreListView<Map<String, dynamic>>(
          shrinkWrap: true,
          query: apc.currentActiveDayDR.value
              .collection(atmos.timings)
              .orderBy(atmos.timingString),
          itemBuilder: (context, qDS) {
            var atm = ActiveTimingModel.fromMap(qDS.data());
            atm.docRef = qDS.reference;

            return Card(
              child: Column(
                children: [
                  TimingsRowHomeScreen(atm: atm),
                  CamPicturesTimingsView(atm: atm),
                  if (atm.prud != null)
                    RefURLWidget(
                      refUrlMetadataModel: atm.prud ?? rummfos.constModel,
                      editingIconRequired: editingIconRequired,
                    ),
                  if (atm.plannedNotes != null && atm.plannedNotes != "")
                    Card(
                        child: SizedBox(
                      child: Text(atm.plannedNotes!),
                      width: double.maxFinite,
                    )),
                  if (atm.takenNotes != null && atm.takenNotes != "")
                    takenNotes(context, atm),
                  Container(
                      color: Colors.green.shade50,
                      child: FoodsListTimingsView(
                          atm: atm, foodTypePlanUp: afmos.up)),
                  FoodsListTimingsView(atm: atm, foodTypePlanUp: afmos.plan),
                ],
              ),
            );
          }));
    } else {
      return const Text("To be update");
    }
  }

  Widget takenNotes(BuildContext context, ActiveTimingModel atm) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        color: Colors.green.shade50,
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                child: const Text(
                  "Taken notes",
                  style: TextStyle(
                    color: Colors.teal,
                    // decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {
                  var todayString = admos.dayStringFromDate(DateTime.now());
                  var selectedDate =
                      DateTime.parse(apc.currentActiveDayDR.value.id);

                  var isBefore = selectedDate.isBefore(DateTime.now());
                  var difference = selectedDate.difference(DateTime.now());

                  if ((todayString == apc.currentActiveDayDR.value.id) ||
                      (isBefore && difference.inDays < 7)) {
                    var tc = TextEditingController();
                    tc.text = selectedDate.toString();
                    alertDialogW(
                      context,
                      body: Column(
                        children: [
                          TextField(controller: tc),
                          GFButton(
                            onPressed: () {},
                            child: const Text("Update"),
                          )
                        ],
                      ),
                    );
                  }
                },
              ),
              ExpandableText(
                atm.takenNotes!,
                expandOnTextTap: true,
                collapseOnTextTap: true,
                maxLines: 2,
                animation: true,
                expandText: "more",
                hashtagStyle: const TextStyle(color: Colors.blue),
                onHashtagTap: (text) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
