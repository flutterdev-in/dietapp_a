import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/url/url_avatar.dart';
import 'package:dietapp_a/y_Models/day_model.dart';
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
            var dm = DayModel.fromMap(snapshot.data!.data()!);

            return Column(
              children: [
                if (dm.rumm != null)
                  GFListTile(
                    avatar: UrlAvatar(dm.rumm),
                  ),
                if (dm.notes != null)
                  ExpandablePanel(
                      collapsed: Text(dm.notes!, maxLines: 1),
                      expanded: Text(dm.notes!)),
              ],
            );
          } else {
            return const SizedBox();
          }
        }));
  }
}
