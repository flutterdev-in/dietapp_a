import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller0.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/timing_info_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/Widgets/food_add_bottom_buttons.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';

class FoodsScreenPC extends StatelessWidget {
  FoodsScreenPC({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pcc0.activePageTimingsMaps.value.values.last.timingName)),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            FoodAddButtons(),
          ],
        ),
      ),
    );
  }

  Widget basicInfo(DayModel daypbim) {
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
            decoration:const InputDecoration(
              isDense: true,
              hintText: 'Notes',
              contentPadding:  EdgeInsets.fromLTRB(0, 0, 10, 0),
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
                      .doc(pcc0.currentPlanDocRefPath.value)
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
}
