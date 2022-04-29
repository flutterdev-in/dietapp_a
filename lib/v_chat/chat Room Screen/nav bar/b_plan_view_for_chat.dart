import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/src/list_extensions.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/day_basic_info.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/default_timing_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/diet_plan_model.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/food_model_for_plan_creation.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/c_chat_room_bottom.dart';
import 'package:dietapp_a/v_chat/controllers/chat_room_controller.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PlanViewForChat extends StatelessWidget {
  PlanViewForChat({Key? key}) : super(key: key);

  final currentPathCR = userDR.collection(dietpbims.dietPlansBeta).obs;
  final orderString = dietpbims.planCreationTime.obs;
  String title = "";
  String? subTitle;
  Widget? avatarW;
  int weekIndex = 0;
  int dayIndex = 0;
  final listCR = RxList<QueryDocumentSnapshot<Map<String, dynamic>>>([]).obs;
  Rx<String> currentWeekName = "".obs;
  Rx<String> currentDayName = "".obs;
  @override
  Widget build(BuildContext context) {
    listCR.value.clear();

    chatSC.selectedList.value.clear();
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
                  String dayNm = "";

                  getTitle(snapshot);
                  if (currentPathCR.value.id == wmfos.weeks) {
                    weekNm = title;
                  } else if (currentPathCR.value.id == daymfos.days) {
                    DayModel dm = DayModel.fromMap(snapshot.data());
                    if (dm.dayCreatedTime != null) {
                      dayNm = title;
                    }
                  }

                  return GFListTile(
                    padding: const EdgeInsets.fromLTRB(0, 5, 8, 0),
                    margin:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    avatar: (snapshot.reference.parent.id == fmfpcfos.foods)
                        ? avatarW
                        : null,
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
                          if (chatSC.selectedList.value.contains(snapshot)) {
                            return const Icon(MdiIcons.checkboxMarkedCircle);
                          } else {
                            return const Icon(
                                MdiIcons.checkboxBlankCircleOutline);
                          }
                        },
                      ),
                      onPressed: () {
                        if (chatSC.selectedList.value.contains(snapshot)) {
                          chatSC.selectedList.value.remove(snapshot);
                        } else {
                          chatSC.selectedList.value.add(snapshot);
                        }
                      },
                    ),
                    onTap: () async {
                      if (chatSC.selectedList.value.isNotEmpty &&
                          snapshot.reference.parent.id != fmfpcfos.foods) {
                        chatSC.selectedList.value.clear();
                        await Future.delayed(const Duration(milliseconds: 200));
                      }

                      if (snapshot.reference.parent.id == wmfos.weeks) {
                        currentWeekName.value = weekNm;
                      } else if (snapshot.reference.parent.id == daymfos.days) {
                        currentDayName.value = dayNm;
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

    weekIndex = 1;
    dayIndex = 1;
    if (crs == dietpbims.dietPlansBeta) {
      DietPlanBasicInfoModel dietpbm =
          DietPlanBasicInfoModel.fromMap(snapshot.data());
      if (dietpbm.isWeekWisePlan) {
        orderString.value = wmfos.weekCreatedTime;
        currentPathCR.value = snapshot.reference.collection(wmfos.weeks);
      } else {
        orderString.value = daymfos.dayCreatedTime;
        currentPathCR.value = snapshot.reference.collection(daymfos.days);
      }
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
    if (crs == dietpbims.dietPlansBeta) {
      DietPlanBasicInfoModel dietpbm = DietPlanBasicInfoModel.fromMap(fcMap);
      title = dietpbm.planName;
    } else if (crs == wmfos.weeks) {
      WeekModel wm = WeekModel.fromMap(fcMap);
      title = wm.weekName ?? "Week $weekIndex";
      weekIndex++;
    } else if (crs == daymfos.days) {
      DayModel dm = DayModel.fromMap(fcMap);
      if (dm.dayCreatedTime != null) {
        title = dm.dayName ?? "day $dayIndex";
        dayIndex++;
      } else if (dm.dayIndex != null) {
        title = daymfos.dayString(dm.dayIndex ?? 0);
      }
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
        backgroundImage: NetworkImage(fm.rumm?.img ?? ""),
      );
      if (fm.rumm?.isYoutubeVideo ?? false) {
        avatar = Stack(
          children: [
            avatar,
            Positioned(
              child: Container(
                color: Colors.white70,
                child: const Icon(
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
      if (fm.rumm?.img != null) {
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
        chatSC.selectedList.value.clear();
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
                if (dm.dayIndex != null) {
                  pathTitle = daymfos.dayString(dm.dayIndex ?? 0);
                } else {
                  pathTitle = dm.dayName ?? currentDayName.value;
                }
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
                      chatSC.selectedList.value.clear();
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
