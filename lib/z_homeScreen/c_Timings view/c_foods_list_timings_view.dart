import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/app%20Constants/url/url_avatar.dart';
import 'package:dietapp_a/x_customWidgets/expandable_text.dart';
import 'package:dietapp_a/x_customWidgets/youtube/youtube_video_player.dart';
import 'package:dietapp_a/y_Active%20diet/controllers/active_plan_controller.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:dietapp_a/y_Models/timing_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FoodsListTimingsView extends StatelessWidget {
  final TimingModel atm;
  final bool isCamFood;
  const FoodsListTimingsView(
      {Key? key, required this.atm, required this.isCamFood})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int dayDiffer = DateTime.parse(apc.currentActiveDayDR.value.id)
        .compareTo(DateTime.now());
    return FirestoreListView<Map<String, dynamic>>(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        query: atm.docRef!
            .collection(fmfpcfos.foods)
            .where(fmos.isCamFood, isEqualTo: isCamFood)
            .orderBy(fmos.foodAddedTime),
        itemBuilder: (context, fdoc) {
          FoodModel fm = FoodModel.fromMap(fdoc.data());

          return GFListTile(
            padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
            avatar: UrlAvatar(fm.rumm),
            title: Text(fm.foodName, maxLines: 2),
            subTitle: expText(
              fm.notes,
              textColor: Colors.brown.shade700,
              fontSize: 13,
            ),
            icon: (dayDiffer < 1 && dayDiffer > -8)
                ? IconButton(
                    onPressed: () async {
                      await fdoc.reference.update({
                        fmos.foodTakenTime: fm.foodTakenTime != null
                            ? null
                            : Timestamp.fromDate(DateTime.now()),
                      });
                    },
                    icon: Icon(fm.foodTakenTime != null
                        ? MdiIcons.checkCircle
                        : MdiIcons.plusCircleOutline))
                : null,
            onTap: () {
              if (fm.rumm?.isYoutubeVideo ?? false) {
                Get.to(() => YoutubeVideoPlayerScreen(fm.rumm!, fm.foodName));
              }
            },
          );
        });
  }
}
