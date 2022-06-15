import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FcPathBar extends StatelessWidget {
  final String? homePath;
  const FcPathBar({Key? key, this.homePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondaryColor,
      height: 40,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Obx(() {
          if (fcc.listFoodModelsForPath.value.isNotEmpty) {
            return Row(children: [
              homeButton(),
              const ScrollPaths(),
            ]);
          } else {
            return homeButton();
          }
        }),
      ),
    );
  }

  Widget homeButton() {
    return InkWell(
      child: const SizedBox(
        child: Icon(MdiIcons.homeOutline),
        width: 40,
      ),
      onTap: () async {
        await Future.delayed(const Duration(milliseconds: 100));
        fcc.currentCR.value = (homePath != null)
            ? FirebaseFirestore.instance.collection(homePath!)
            : userDR.collection(fmos.foodsCollection);
        fcc.isUnselectAll.value = true;
        fcc.listFoodModelsForPath.value.clear();
        fcc.currentPathMapFoodModels.value.forEach((key, value) {
          fcc.currentPathMapFoodModels.value.update(key, (i) => false);
        });
        fcc.itemsSelectionCount.value = 0;
      },
    );
  }
}

class ScrollPaths extends StatelessWidget {
  const ScrollPaths({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = ScrollController();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _controller.jumpTo(_controller.position.maxScrollExtent);
    });
    return Expanded(
      child: SizedBox(
        child: Obx(() => ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              controller: _controller,
              children:
                  fcc.listFoodModelsForPath.value.mapIndexed((index, fdm) {
                return Row(
                  children: [
                    const Icon(MdiIcons.chevronRight),
                    InkWell(
                      child: Container(
                        child: Text(
                          fdm.foodName,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                        constraints: BoxConstraints(
                          minWidth: 15,
                          maxWidth: fcc.listFoodModelsForPath.value.length < 2
                              ? 100
                              : 45,
                        ),
                      ),
                      onTap: () {
                        fcc.currentCR.value =
                            fdm.docRef?.collection(fmos.subCollections) ??
                                userDR.collection(fmos.foodsCollection);
                        if (fdm != fcc.listFoodModelsForPath.value.last) {
                          fcc.listFoodModelsForPath.value.removeRange(index + 1,
                              fcc.listFoodModelsForPath.value.length);
                          fcc.isUnselectAll.value = true;
                        }
                        fcc.currentPathMapFoodModels.value
                            .forEach((key, value) {
                          fcc.currentPathMapFoodModels.value
                              .update(key, (i) => false);
                        });
                        fcc.itemsSelectionCount.value = 0;
                      },
                    ),
                  ],
                );
              }).toList(),
            )),
      ),
    );
  }
}
