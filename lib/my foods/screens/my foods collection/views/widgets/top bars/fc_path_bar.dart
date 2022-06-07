import 'package:collection/collection.dart';
import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
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
          if (fcc.pathsListMaps.value.isNotEmpty) {
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
        fcc.currentPathCR.value =
            (homePath != null) ? homePath! : fdcs.foodsCR0.path;
        fcc.isUnselectAll.value = true;
        fcc.pathsListMaps.value.clear();
        fcc.currentsPathItemsMaps.value.forEach((key, value) {
          fcc.currentsPathItemsMaps.value[key]?[fdcs.isItemSelected] = false;
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
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          controller: _controller,
          children: fcc.pathsListMaps.value.mapIndexed((index, element) {
            return Row(
              children: [
                const Icon(MdiIcons.chevronRight),
                InkWell(
                  child: Container(
                    child: Text(
                      element[fdcs.fieldName] ?? "$element",
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 15,
                      maxWidth: fcc.pathsListMaps.value.length < 2 ? 100 : 45,
                    ),
                  ),
                  onTap: () {
                    fcc.currentPathCR.value =
                        element[fdcs.pathCRstring] ?? fdcs.foodsCR0;
                    if (element != fcc.pathsListMaps.value.last) {
                      fcc.pathsListMaps.value.removeRange(
                          index + 1, fcc.pathsListMaps.value.length);
                      fcc.isUnselectAll.value = true;
                    }
                    fcc.currentsPathItemsMaps.value.forEach((key, value) {
                      fcc.currentsPathItemsMaps.value[key]
                          ?[fdcs.isItemSelected] = false;
                    });
                    fcc.itemsSelectionCount.value = 0;
                  },
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
