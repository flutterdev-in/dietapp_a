import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/x_Days/Menu%20button/_menu_button.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/x_Days/days_listview.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PlanCreationScreen extends StatelessWidget {
  const PlanCreationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diet Plan"),
        actions: [
          MenuButtonPCdays(),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .doc(pcc.currentPlanDocRefPath.value)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> docSnap) {
          if (docSnap.hasData) {
            Map<String, dynamic> docMap =
                docSnap.data!.data() as Map<String, dynamic>;
            DietPlanBasicInfoModel dpbim =
                DietPlanBasicInfoModel.fromMap(docMap);

            return Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Column(
                    children: [
                      basicInfo(dpbim),
                      Expanded(
                        child: DaysListViewOnPlanCreation(
                            docRef: docSnap.data!.reference),
                      ),
                    ],
                  ),
                  addDayButton(),
                ],
              ),
            );
          } else {
            return const Text("Network error");
          }
        },
      ),
    );
  }

  Widget addDayButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
          onPressed: () async {
            int dayIndex = 0;
            await FirebaseFirestore.instance
                .doc(pcc.currentPlanDocRefPath.value)
                .collection(daypbims.days)
                .orderBy(daypbims.docEntryTime, descending: true)
                .limit(1)
                .get()
                .then((value) {
              if (value.docs.length == 1) {
                Map<String, dynamic> dataMap =
                    value.docs.last.data() as Map<String, dynamic>;
                dayIndex = dataMap[daypbims.dayIndex];
              }
            });
            await FirebaseFirestore.instance
                .doc(pcc.currentPlanDocRefPath.value)
                .collection(daypbims.days)
                .add(DayPlanBasicInfoModel(
                        dayIndex: dayIndex + 1,
                        docEntryTime: Timestamp.fromDate(DateTime.now()),
                        notes: null,
                        refURL: null)
                    .toMap());
          },
          child: Text("Add day")),
    );
  }

  Widget basicInfo(DietPlanBasicInfoModel dpbim) {
    Rx<String> suffixType = "".obs;
    Widget nameField() {
      TextEditingController tc = TextEditingController();
      tc.text = dpbim.planName;
      tc.selection =
          TextSelection.fromPosition(TextPosition(offset: tc.text.length));
      return LimitedBox(
        maxHeight: 80,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            maxLines: null,
            decoration: InputDecoration(
              isDense: true,
              hintText: 'Plan Name',
              contentPadding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
            ),
            controller: tc,
            style: TextStyle(fontSize: 20, color: Colors.indigo),
            onChanged: (value) async {
              EasyDebounce.debounce("1", const Duration(seconds: 3), () async {
                await FirebaseFirestore.instance
                    .doc(pcc.currentPlanDocRefPath.value)
                    .update({"planName": value});
              });
            },
          ),
        ),
      );
    }

    Widget notesField() {
      TextEditingController tc = TextEditingController();
      tc.text = dpbim.notes ?? "";
      tc.selection =
          TextSelection.fromPosition(TextPosition(offset: tc.text.length));

      return LimitedBox(
        maxHeight: 180,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            maxLines: null,
            decoration: InputDecoration(
              isDense: true,
              hintText: 'Notes',
              contentPadding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
            ),
            controller: tc,
            onChanged: (value) async {
              EasyDebounce.debounce(
                "2",
                const Duration(seconds: 5),
                () async {
                  await FirebaseFirestore.instance
                      .doc(pcc.currentPlanDocRefPath.value)
                      .update({"notes": value});
                },
              );
            },
          ),
        ),
      );
    }

    return Card(
      elevation: 2,
      child: Column(
        children: [
          nameField(),
          notesField(),
        ],
      ),
    );
  }
}
