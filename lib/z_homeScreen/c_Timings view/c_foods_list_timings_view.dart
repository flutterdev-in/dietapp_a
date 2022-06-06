import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/url_avatar.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_food_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../y_Active diet/controllers/active_plan_controller.dart';

class FoodsListTimingsView extends StatelessWidget {
  final ActiveTimingModel atm;
  final bool isCamFood;
  const FoodsListTimingsView(
      {Key? key, required this.atm, required this.isCamFood})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int dayDiffer =
        DateTime.parse(apc.currentActiveDayDR.value.id).compareTo(DateTime.now());
    return FirestoreListView<Map<String, dynamic>>(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        query: atm.docRef!
            .collection(fmfpcfos.foods)
            .where(afmos.isCamFood, isEqualTo: isCamFood),
        itemBuilder: (context, fdoc) {
          ActiveFoodModel fm = ActiveFoodModel.fromMap(fdoc.data());

          return GFListTile(
            padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
            avatar: URLavatar(
                imgURL: fm.rumm?.img,
                webURL: fm.rumm?.url),
            title: Text(fm.foodName, maxLines: 2),
            subTitleText: (fm.notes == null || fm.notes == "")
                ? null
                : fm.notes,
            icon: Row(
              children: [
                if (dayDiffer < 1 && dayDiffer > -8)
                  IconButton(
                      onPressed: () async {
                        await fdoc.reference.update({
                          adfos.isTaken: !fm.isTaken,
                          afmos.takenTime:
                              fm.isTaken ? null : Timestamp.fromDate(DateTime.now()),
                        });
                      },
                      icon: Icon(fm.isTaken
                          ? MdiIcons.checkCircle
                          : MdiIcons.plusCircleOutline)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(MdiIcons.dotsVerticalCircle)),
              ],
            ),
          );
        });
  }
}
