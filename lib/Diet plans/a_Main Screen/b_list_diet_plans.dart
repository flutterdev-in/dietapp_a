import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/Combined%20screen/_plan_creation_combined_screen.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/x_customWidgets/expandable_text.dart';
import 'package:dietapp_a/x_customWidgets/web%20view/web_view_page.dart';
import 'package:dietapp_a/x_customWidgets/youtube/youtube_video_player.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ListDietPlansW extends StatelessWidget {
  const ListDietPlansW({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        activeDietPlan(),
        plannedList(),
      ],
    );
  }

  Widget activeDietPlan() {
    return GFListTile(
        avatar: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: userDR.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.data() != null) {
                var uwm = UserWelcomeModel.fromMap(snapshot.data!.data()!);
                if (uwm.photoURL != null) {
                  return GFAvatar(
                    size: GFSize.MEDIUM,
                    backgroundImage: CachedNetworkImageProvider(
                      uwm.photoURL!,
                    ),
                  );
                }
              }
              return const GFAvatar(
                  size: GFSize.MEDIUM,
                  child: Icon(MdiIcons.clipboardAccountOutline, size: 30));
            }),
        titleText: "My active diet plan",
        onTap: () async {
          pcc.currentPlanDR.value = userDR;
          pcc.currentDayDR.value = admos.activeDayDR(DateTime.now(), userUID);
          pcc.currentTimingDR.value =
              await pcc.getTimingDRfromDay(pcc.currentDayDR.value);
          pcc.isCombinedCreationScreen.value = true;
          Get.to(() => const PlanCreationCombinedScreen(
                isWeekWisePlan: false,
                isForActivePlan: true,
              ));
        });
  }

  Widget plannedList() {
    return Expanded(
      child: FirestoreListView<Map<String, dynamic>>(
        shrinkWrap: true,
        query: FirebaseFirestore.instance
            .collection(uwmos.users)
            .doc(userUID)
            .collection(dietpbims.dietPlansBeta),
        itemBuilder: (context, snapshot) {
          Map<String, dynamic> dietPlanMap = snapshot.data();
          DietPlanBasicInfoModel dpbim =
              DietPlanBasicInfoModel.fromMap(dietPlanMap);

          return GFListTile(
            title: Text(dpbim.planName),
            subTitle: (dpbim.notes != null && dpbim.notes!.isNotEmpty)
                ? expText(dpbim.notes)
                : null,
            avatar: GFAvatar(
              backgroundColor: primaryColor,
              shape: GFAvatarShape.standard,
              child: Text(
                dpbim.isWeekWisePlan ? "Weekly\nPlan" : "Daily\nPlan",
                textScaleFactor: 0.9,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            icon: dpbim.rumm != null
                ? IconButton(
                    onPressed: () {
                      if (dpbim.rumm!.isYoutubeVideo) {
                        Get.to(() => YoutubeVideoPlayerScreen(
                            dpbim.rumm!, dpbim.planName));
                      } else if (dpbim.rumm!.url.isURL) {
                        Get.to(
                            () => WebViewPage(dpbim.rumm!.url, dpbim.planName));
                      }
                    },
                    icon: dpbim.rumm!.isYoutubeVideo
                        ? const Icon(MdiIcons.youtube, color: Colors.red)
                        : const Icon(MdiIcons.web))
                : null,
            onTap: () async {
              pcc.currentPlanDR.value = snapshot.reference;
              await pcc
                  .getPlanRxValues(snapshot.reference, dpbim.isWeekWisePlan)
                  .then((value) {
                pcc.isCombinedCreationScreen.value = true;
                Get.to(() => PlanCreationCombinedScreen(
                      isWeekWisePlan: dpbim.isWeekWisePlan,
                      isForActivePlan: false,
                    ));
              });
            },
          );
        },
      ),
    );
  }
}
