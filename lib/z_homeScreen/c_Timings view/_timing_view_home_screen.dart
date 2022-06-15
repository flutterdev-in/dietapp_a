import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/_plan_creation_combined_screen.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_widget.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:dietapp_a/x_customWidgets/expandable_text.dart';
import 'package:dietapp_a/y_Active%20diet/controllers/active_plan_controller.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';
import 'package:dietapp_a/y_Models/day_model.dart';
import 'package:dietapp_a/y_Models/timing_model.dart';
import 'package:dietapp_a/z_homeScreen/c_Timings%20view/a_timings_row_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

import 'b_cam_pictures_timings_view.dart';
import 'c_foods_list_timings_view.dart';

//
class TimingViewHomeScreen extends StatelessWidget {
  final bool editingIconRequired;
  final bool isDayExists;

  const TimingViewHomeScreen({
    Key? key,
    required this.isDayExists,
    this.editingIconRequired = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isDayExists) {
      return Obx(() => FirestoreListView<Map<String, dynamic>>(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          query: apc.currentActiveDayDR.value
              .collection(tmos.timings)
              .orderBy(tmos.timingString),
          itemBuilder: (context, qDS) {
            var atm = TimingModel.fromMap(qDS.data());
            atm.docRef = qDS.reference;

            return Card(
              child: Column(
                children: [
                  TimingsRowHomeScreen(atm: atm),
                  CamPicturesTimingsView( atm,isActionAllowed: true),
                  if (atm.rumm != null)
                    RefURLWidget(
                      refUrlMetadataModel: atm.rumm ?? rummfos.constModel,
                      editingIconRequired: editingIconRequired,
                    ),
                  if (atm.notes != null && atm.notes != "") notes(context, atm),
                  FoodsListTimingsView(atm: atm, isCamFood: false),
                ],
              ),
            );
          }));
    } else {
      return dayNotExistsW(context);
    }
  }

  Widget dayNotExistsW(BuildContext context) {
    var todayString = admos.activeDayStringFromDate(DateTime.now());
    var today = DateTime.parse(todayString);

    var selectedDate = DateTime.parse(apc.currentActiveDayDR.value.id);

    var isBefore = selectedDate.isBefore(today);

    var isAfter = true;
    if (todayString != apc.currentActiveDayDR.value.id && isBefore) {
      isAfter = false;
    }
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Diet not ${isAfter ? 'planned' : 'recorded'} for this day"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GFButton(
                color: primaryColor,
                onPressed: () async {
                  if (isAfter) {
                    pcc.currentDayDR.value = apc.currentActiveDayDR.value;

                    pcc.isCombinedCreationScreen.value = true;
                    Get.to(() => const PlanCreationCombinedScreen(
                          isWeekWisePlan: false,
                          isForActivePlan: true,
                          isForSingleDayActive: true,
                        ));
                    await atmos.activateDefaultTimings(pcc.currentDayDR.value);
                    pcc.currentTimingDR.value =
                        await pcc.getTimingDRfromDay(pcc.currentDayDR.value);
                  } else if (isBefore) {
                    textFieldAlertW(context,
                        lableText: DateFormat("dd MMM yyyy (EEEE)")
                                .format(selectedDate) +
                            " notes",
                        text: null, onPressedConfirm: (text) async {
                      FocusScope.of(context).unfocus();
                      Get.back();
                      apc.currentActiveDayDR.value.set(DayModel(
                        dayDate: selectedDate,
                        dayCreatedTime: null,
                        dayIndex: null,
                        notes: text,
                      ).toMap());
                    });
                  }
                },
                child: Text(isAfter ? "Plan now" : "Make a note")),
          ),
        ],
      ),
    );
  }

  Widget notes(BuildContext context, TimingModel atm) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: expText(
          atm.notes!,
          expandOnTextTap: true,
          textColor: Colors.black,
        ),
      ),
    );
  }
}
