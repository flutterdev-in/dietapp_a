import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DayEditScreen extends StatelessWidget {
  const DayEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .doc(pcc.currentDayDRpath.value)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> docSnap) {
        if (docSnap.hasData) {
          Map<String, dynamic> docMap =
              docSnap.data!.data() as Map<String, dynamic>;
          DayPlanBasicInfoModel daypbim = DayPlanBasicInfoModel.fromMap(docMap);

          return Scaffold(
            appBar: AppBar(title: Text("Day " + daypbim.dayIndex.toString())),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Column(
                children: [
                  basicInfo(daypbim),
                  Expanded(
                    child: Container(),
                  ),
                  addTimingButton(),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(appBar: AppBar());
        }
      },
    );
  }

  Widget basicInfo(DayPlanBasicInfoModel daypbim) {
    Widget notesField() {
      TextEditingController tc = TextEditingController();
      tc.text = daypbim.notes ?? "";
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
          notesField(),
        ],
      ),
    );
  }

  Widget addTimingButton() {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .doc(pcc.currentPlanDocRefPath.value)
                    .collection("days")
                    .add(DayPlanBasicInfoModel(
                            dayIndex: pcc.lastDayIndex.value + 1,
                            notes: null,
                            refURL: null)
                        .toMap());
              },
              icon: Icon(MdiIcons.plusBoxMultipleOutline)),
          IconButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .doc(pcc.currentPlanDocRefPath.value)
                    .collection("days")
                    .add(DayPlanBasicInfoModel(
                            dayIndex: pcc.lastDayIndex.value + 1,
                            notes: null,
                            refURL: null)
                        .toMap());
              },
              icon: Icon(MdiIcons.penPlus)),
          IconButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .doc(pcc.currentPlanDocRefPath.value)
                    .collection("days")
                    .add(DayPlanBasicInfoModel(
                            dayIndex: pcc.lastDayIndex.value + 1,
                            notes: null,
                            refURL: null)
                        .toMap());
              },
              icon: Icon(MdiIcons.webPlus)),
          IconButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .doc(pcc.currentPlanDocRefPath.value)
                    .collection("days")
                    .add(DayPlanBasicInfoModel(
                            dayIndex: pcc.lastDayIndex.value + 1,
                            notes: null,
                            refURL: null)
                        .toMap());
              },
              icon: Icon(MdiIcons.folderPlusOutline)),
          IconButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .doc(pcc.currentPlanDocRefPath.value)
                    .collection("days")
                    .add(DayPlanBasicInfoModel(
                            dayIndex: pcc.lastDayIndex.value + 1,
                            notes: null,
                            refURL: null)
                        .toMap());
              },
              icon: Icon(MdiIcons.folderPlusOutline)),
        ],
      ),
    );
  }
}
