import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/_plan_creation_combined_screen.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/dartUtilities/day_string_from_date.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:dietapp_a/x_customWidgets/expandable_text.dart';
import 'package:dietapp_a/x_customWidgets/lootie_animations.dart';
import 'package:dietapp_a/x_customWidgets/month_calander.dart';
import 'package:dietapp_a/y_Active%20diet/controllers/active_plan_controller.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/y_Models/day_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'c_Timings view/_timing_view_home_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isCalendarEnabled = false.obs;

    return Obx(() => StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: apc.currentActiveDayDR.value.snapshots(),
        builder: (context, snapshot) {
          bool isDayExists = false;
          DayModel? adm;

          if (snapshot.hasData && snapshot.data!.data() != null) {
            isDayExists = true;
            adm = DayModel.fromMap(snapshot.data!.data()!);
          }
          if (!snapshot.hasData) {
            isDayExists = false;
          }

          return Scaffold(
              appBar: AppBar(
                title: const Text("DietApp"),
                actions: [
                  InkWell(
                    child: Row(
                      children: [
                        Obx(() => Text(dayStringFromDate(apc.dt.value))),
                        const Icon(MdiIcons.chevronDown),
                      ],
                    ),
                    onTap: () async {
                      isCalendarEnabled.value = !isCalendarEnabled.value;
                    },
                  ),
                ],
              ),
              body: Obx(() => Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        children: [
                          Obx(() => isCalendarEnabled.value
                              ? monthCalander()
                              : const SizedBox()),
                          Expanded(
                              child: ListView(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            children: [
                              if (adm?.notes != null) dayNotes(adm!.notes!),
                              TimingViewHomeScreen(isDayExists: isDayExists),
                            ],
                          )),
                        ],
                      ),
                      if (isLoading.value) loot.linerDotsLoading(),
                    ],
                  )),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: floatingButton(context, isDayExists, adm));
        }));
  }

  Widget dayNotes(String notes) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Day Notes"),
          expText(notes)!,
        ],
      ),
    );
  }

  Widget monthCalander() {
    return MonthCalander(
        currentDay: apc.dt.value,
        onDaySelected: (selectedDate, focusedDate) async {
          apc.dt.value = focusedDate;

          apc.currentActiveDayDR.value =
              admos.activeDayDR(focusedDate, userUID);
          // await atmos.checkAndSetDefaultTimings(focusedDate);
        },
        personUID: userUID,
        onCurrentCalanderPressed: () async {
          apc.dt.value = DateTime.now().add(const Duration(days: 1));
          apc.dt.value = DateTime.now();
          apc.currentActiveDayDR.value =
              admos.activeDayDR(DateTime.now(), userUID);
        });
  }

  FloatingActionButton? floatingButton(
      BuildContext context, bool isDayExists, DayModel? adm) {
    var todayString = admos.activeDayStringFromDate(DateTime.now());
    var today = DateTime.parse(todayString);

    var selectedDate = DateTime.parse(apc.currentActiveDayDR.value.id);

    var difference = selectedDate.difference(today);

    if (isDayExists) {
      return FloatingActionButton(
          backgroundColor: secondaryColor,
          mini: true,
          child: const Icon(MdiIcons.clipboardEditOutline),
          onPressed: () async {
            if (difference.inDays > -7) {
              pcc.currentDayDR.value = apc.currentActiveDayDR.value;
              pcc.isCombinedCreationScreen.value = true;
              Get.to(() => const PlanCreationCombinedScreen(
                    isWeekWisePlan: false,
                    isForActivePlan: true,
                    isForSingleDayActive: true,
                  ));

              pcc.currentTimingDR.value =
                  await pcc.getTimingDRfromDay(pcc.currentDayDR.value);
            } else {
              textFieldAlertW(
                context,
                text: adm?.notes,
                lableText:
                    DateFormat("dd MMM yyyy (EEEE)").format(selectedDate) +
                        " notes",
                onPressedConfirm: (text) async {
                  Get.back();

                  apc.currentActiveDayDR.value.update({
                    "$unIndexed.$notes0": text,
                  });
                },
              );
            }
          });
    } else {
      return null;
    }
  }
}
