import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/url/url_avatar.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../y_Active diet/controllers/active_plan_controller.dart';

class DayUrlNotesViewHS extends StatelessWidget {
  const DayUrlNotesViewHS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: apc.currentActiveDayDR.value.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.data() != null) {
            var dm = ActiveDayModel.fromMap(snapshot.data!.data()!);

            return Column(
              children: [
                if (dm.prud != null)
                  GFListTile(
                    avatar:
                        URLavatar(imgURL: dm.prud?.img, webURL: dm.prud?.url),
                  ),
                if (dm.plannedNotes != null)
                  ExpandablePanel(
                      collapsed: Text(dm.plannedNotes!, maxLines: 1),
                      expanded: Text(dm.plannedNotes!)),
              ],
            );
          } else {
            return const SizedBox();
          }
        }));
  }
}
