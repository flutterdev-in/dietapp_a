import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/x_Browser/_browser_main_screen.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:dietapp_a/y_Active%20diet/controllers/active_plan_controller.dart';
import 'package:dietapp_a/y_Active%20diet/functions/delete_active_entries.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';
import 'package:dietapp_a/y_Models/timing_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MenuItemsTimingViewHS extends StatelessWidget {
  final TimingModel atm;

  const MenuItemsTimingViewHS(this.atm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PopupMenuButton(
        padding: const EdgeInsets.all(10.0),
        color: Colors.white,
        child: const Icon(MdiIcons.dotsVertical),
        itemBuilder: (context) {
          var todayString = admos.dayStringFromDate(DateTime.now());
          var selectedDate = DateTime.parse(apc.currentActiveDayDR.value.id);

          var isBefore = selectedDate.isBefore(DateTime.now());
          var difference = selectedDate.difference(DateTime.now());
          return [
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {
                  await Future.delayed(const Duration(milliseconds: 100));
                  Navigator.pop(context);
                  addNotes(context, isForPlanned: true);
                },
                child: SizedBox(
                    width: double.maxFinite,
                    child: Text(atm.notes == null
                        ? "Add planned notes"
                        : "Edit planned notes")),
              ),
            ),
            if ((todayString == apc.currentActiveDayDR.value.id) ||
                (isBefore && difference.inDays < 7))
              PopupMenuItem(
                child: TextButton(
                  onPressed: () async {
                    await Future.delayed(const Duration(milliseconds: 100));
                    Navigator.pop(context);
                    addNotes(context, isForPlanned: false);
                  },
                  child: SizedBox(
                      width: double.maxFinite,
                      child: Text(atm.notes == null
                          ? "Add taken notes"
                          : "Edit taken notes")),
                ),
              ),
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  apc.currentActiveTimingDR.value = atm.docRef!;
                  Get.to(() => const AddFoodScreen());
                },
                child: const Text("Add Foods from Web"),
              ),
            ),
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {},
                child: const Text("Add Foods from Collection"),
              ),
            ),
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {},
                child: const Text("Add Foods from Plans"),
              ),
            ),
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {
                  await deleteActiveEntries.deleteActiveTiming(atm.docRef!);
                  Navigator.pop(context);
                },
                child: const Text("Delete this timing"),
              ),
            ),
          ];
        },
      ),
    );
  }

  void addNotes(BuildContext context, {required bool isForPlanned}) {
    var tc = TextEditingController();
    if (isForPlanned && atm.notes != null) {
      tc.text = atm.notes!;
    } else if (!isForPlanned && atm.notes != null) {
      tc.text = atm.notes!;
    }
    alertDialogW(context,
        body: Column(
          children: [
            Container(
              constraints: const BoxConstraints(
                maxHeight: 150,
              ),
              child: TextField(
                autofocus: true,
                maxLines: null,
                controller: tc,
                decoration:
                    InputDecoration(hintText: "${atm.timingName} notes"),
              ),
            ),
            GFButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  Get.back();

                  if (tc.text.isNotEmpty) {
                    atm.docRef!.update({
                      "$unIndexed.$notes0": tc.text,
                    });
                  }
                },
                child: const Text("Add")),
          ],
        ));
  }
}
