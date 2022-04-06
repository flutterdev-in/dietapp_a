import 'package:collection/src/list_extensions.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:dietapp_a/v_chat/controllers/chat_room_controller.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/views/widgets/top%20bars/fc_path_bar.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/chat_room_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PlanViewForChat extends StatelessWidget {
  PlanViewForChat({Key? key}) : super(key: key);

  final currentPathCR = userDR.collection("dietPlansBeta").obs;
  final orderString = dietpbims.planCreationTime.obs;
  String title = "";
  String? subTitle;
  Widget? avatarW;
  int weekIndex = 0;
  final listCR = RxList<QueryDocumentSnapshot<Map<String, dynamic>>>([]).obs;
  Rx<String> currentWeekName = "".obs;
  // final listSelectedDRs =
  //     RxList<DocumentReference<Map<String, dynamic>>>([]).obs;

  @override
  Widget build(BuildContext context) {
    listCR.value.clear();
    chatSC.docList.value.clear();
    return Column(
      children: [
        SizedBox(
          child: ChatRoomBottom(isSuffixButtonsRequired: false),
          height: 60,
        ),
        planPathBar(),
        Expanded(
          child: Obx(
            () {
              return FirestoreListView<Map<String, dynamic>>(
                shrinkWrap: true,
                query: currentPathCR.value
                    .orderBy(orderString.value, descending: false),
                itemBuilder: (context, snapshot) {
                  String weekNm = '';

                  Rx<bool> isItemSelected = false.obs;
                  getTitle(snapshot);
                  if (currentPathCR.value.id == wmfos.weeks) {
                    weekNm = title;
                  }

                  return GFListTile(
                    padding: const EdgeInsets.fromLTRB(0, 5, 8, 0),
                    margin:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    avatar: avatarW,
                    subTitleText: subTitle,
                    title: Text(
                      title,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    icon: IconButton(
                      icon: Obx(
                        () {
                          if (chatSC.docList.value
                              .contains(snapshot.reference)) {
                            return const Icon(MdiIcons.checkboxMarkedCircle);
                          } else {
                            return const Icon(
                                MdiIcons.checkboxBlankCircleOutline);
                          }
                        },
                      ),
                      onPressed: () {
                        if (chatSC.docList.value.contains(snapshot.reference)) {
                          chatSC.docList.value.remove(snapshot.reference);
                        } else {
                          chatSC.docList.value.add(snapshot.reference);
                        }

                        // bool isSlected = fcc.currentsPathItemsMaps
                        //     .value[snapshot.reference]?[fdcs.isItemSelected];

                        // // isItemSelected.value = !isItemSelected.value;
                        // fcc.currentsPathItemsMaps.value[snapshot.reference]
                        //     ?[fdcs.isItemSelected] = !isSlected;
                        // isItemSelected.value = !isSlected;
                      },
                    ),
                    onTap: () async {
                      if (chatSC.docList.value.isNotEmpty) {
                        chatSC.docList.value.clear();
                        await Future.delayed(const Duration(milliseconds: 200));
                      }

                      if (snapshot.reference.parent.id == wmfos.weeks) {
                        currentWeekName.value = weekNm;
                      }
                      onPressed(snapshot);
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void onPressed(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    String crs = snapshot.reference.parent.id;

    weekIndex = 0;
    if (crs == "dietPlansBeta") {
      orderString.value = wmfos.weekCreationTime;
      currentPathCR.value = snapshot.reference.collection(wmfos.weeks);
    } else if (crs == wmfos.weeks) {
      orderString.value = daymfos.dayIndex;
      currentPathCR.value = snapshot.reference.collection(daymfos.days);
    } else if (crs == daymfos.days) {
      orderString.value = dtmos.timingString;
      currentPathCR.value = snapshot.reference.collection(dtmos.timings);
    } else if (crs == dtmos.timings) {
      orderString.value = fmfpcfos.foodAddedTime;
      currentPathCR.value = snapshot.reference.collection(fmfpcfos.foods);
    }
    if (!listCR.value.contains(snapshot) && crs != fmfpcfos.foods) {
      listCR.value.add(snapshot);
    }
  }

  void getTitle(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    String crs = snapshot.reference.parent.id;
    Map<String, dynamic> fcMap = snapshot.data();
    if (crs == "dietPlansBeta") {
      DietPlanBasicInfoModel dietpbm = DietPlanBasicInfoModel.fromMap(fcMap);
      title = dietpbm.planName;
    } else if (crs == wmfos.weeks) {
      title = pcc.weekName(weekIndex);
      weekIndex++;
    } else if (crs == daymfos.days) {
      DayModel dm = DayModel.fromMap(fcMap);
      title = daymfos.dayString(dm.dayIndex);
    } else if (crs == dtmos.timings) {
      DefaultTimingModel dtm = DefaultTimingModel.fromMap(fcMap);
      title = dtm.timingName;
    } else if (crs == fmfpcfos.foods) {
      FoodsModelForPlanCreation fm = FoodsModelForPlanCreation.fromMap(fcMap);

      title = fm.foodName;
      subTitle = null;
      if (fm.notes != "" && fm.notes != null) {
        subTitle = fm.notes;
      }

      Widget avatar = GFAvatar(
        shape: GFAvatarShape.standard,
        size: GFSize.MEDIUM,
        maxRadius: 20,
        backgroundImage: NetworkImage(fm.imgURL ?? ""),
      );
      if (fm.refURL?.contains("youtube.com/watch?v=") ?? false) {
        avatar = Stack(
          children: [
            avatar,
            Positioned(
              child: Container(
                color: Colors.white70,
                child: Icon(
                  MdiIcons.youtube,
                  color: Colors.red,
                  size: 15,
                ),
              ),
              right: 0,
              bottom: 0,
            )
          ],
        );
      }
      if (fm.imgURL != null) {
        avatarW = avatar;
      }
    }
  }

  Widget planPathBar() {
    Widget homeButton = InkWell(
      child: const SizedBox(
        child: Icon(MdiIcons.homeOutline),
        width: 40,
      ),
      onTap: () {
        currentPathCR.value = userDR.collection("dietPlansBeta");
        orderString.value = dietpbims.planCreationTime;
        listCR.value.clear();
      },
    );
    Widget scrollPaths() {
      ScrollController _controller = ScrollController();

      SchedulerBinding.instance!.addPostFrameCallback((_) {
        _controller.jumpTo(_controller.position.maxScrollExtent);
      });
      return Expanded(
        child: SizedBox(
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            controller: _controller,
            children: listCR.value.mapIndexed((index, snapshot) {
              String crs = snapshot.reference.parent.id;
              Map<String, dynamic> fcMap = snapshot.data();
              String pathTitle = "";
              if (crs == "dietPlansBeta") {
                DietPlanBasicInfoModel dietpbm =
                    DietPlanBasicInfoModel.fromMap(fcMap);
                pathTitle = dietpbm.planName;
              } else if (crs == wmfos.weeks) {
                // WeekModel wm = WeekModel.fromMap(fcMap);

                pathTitle = currentWeekName.value;
              } else if (crs == daymfos.days) {
                DayModel dm = DayModel.fromMap(fcMap);
                pathTitle = daymfos.dayString(dm.dayIndex);
              } else if (crs == dtmos.timings) {
                DefaultTimingModel dtm = DefaultTimingModel.fromMap(fcMap);
                pathTitle = dtm.timingName;
              }
              return Row(
                children: [
                  const Icon(MdiIcons.chevronRight),
                  InkWell(
                    child: Container(
                      child: Text(
                        pathTitle,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 15,
                        maxWidth: fcc.pathsListMaps.value.length < 2 ? 100 : 45,
                      ),
                    ),
                    onTap: () {
                      onPressed(snapshot);
                      listCR.value.removeRange(index + 1, listCR.value.length);
                    },
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      );
    }

    return Container(
      color: Colors.green.shade100,
      height: 40,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Obx(() {
          if (listCR.value.isNotEmpty) {
            return Row(children: [
              homeButton,
              scrollPaths(),
            ]);
          } else {
            return homeButton;
          }
        }),
      ),
    );
  }
}
