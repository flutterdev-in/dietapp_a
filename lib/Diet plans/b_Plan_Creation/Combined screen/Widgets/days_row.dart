import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget daysRow000PlanCreationCombinedScreen() {
  List<String> ls = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  return SizedBox(
    height: 30,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Row(
        children: ls.map((e) {
          int index = ls.indexOf(e);
          return Expanded(
            child: InkWell(
              child: Obx(() => Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      color: pcc.currentDayIndex.value == index
                          ? Colors.deepPurple.shade200
                          : Colors.white,
                    ),
                    child: Center(child: Text(e)),
                  )),
              splashColor: Colors.deepPurple,
              onTap: () {
                pcc.currentTimingDR.value = userDR;
                pcc.currentDayIndex.value = index;
              },
            ),
          );
        }).toList(),
      ),
    ),
  );
}
