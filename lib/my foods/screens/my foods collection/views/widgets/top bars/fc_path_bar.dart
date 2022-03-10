import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/rx_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:collection/collection.dart';

class FcPathBar extends StatelessWidget {
  const FcPathBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (rxfcv.pathsListMaps.isNotEmpty) {
        return Container(
          color: Colors.green.shade100,
          height: 40,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(children: [
              homeButton(),
              ScrollPaths(),
            ]),
          ),
        );
      } else {
        return SizedBox();
      }
    });
  }

  Widget homeButton() {
    return InkWell(
      child: const SizedBox(
        child: Icon(MdiIcons.homeRemoveOutline),
        width: 40,
      ),
      onTap: () async {
        await Future.delayed(const Duration(milliseconds: 100));
        rxfcv.currentPathCR.value = fdcs.foodsCR0.path;
        rxfcv.selecAllUnselectAll(trueSelectAllfalseUnselectAll: false);
        rxfcv.pathsListMaps.clear();
      },
    );
  }
}

class ScrollPaths extends StatelessWidget {
  const ScrollPaths({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
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
          children: rxfcv.pathsListMaps.mapIndexed((index, element) {
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
                      maxWidth: rxfcv.pathsListMaps.length < 2 ? 100 : 45,
                    ),
                  ),
                  onTap: () {
                    rxfcv.currentPathCR.value =
                        element[fdcs.pathCRstring] ?? fdcs.foodsCR0;
                    if (element != rxfcv.pathsListMaps.last) {
                      rxfcv.pathsListMaps
                          .removeRange(index + 1, rxfcv.pathsListMaps.length);
                      rxfcv.selecAllUnselectAll(
                          trueSelectAllfalseUnselectAll: false);
                    }
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
