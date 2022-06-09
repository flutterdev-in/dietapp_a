import 'package:dietapp_a/hive%20Boxes/box_names.dart';
import 'package:dietapp_a/hive%20Boxes/boxes.dart';
import 'package:dietapp_a/w_bottomBar/_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

Future<void> hiveIndexesUpdate(AppLifecycleState state) async {
  if (state == AppLifecycleState.resumed) {
    var bottomIndex = boxIndexes.get(boxKeyNames.bottomBarindex);
    if (bottomIndex != null  && bottomIndex is int ) {
      bottomNavController.jumpToTab(bottomIndex);
    }
  } else if (state == AppLifecycleState.inactive ||
      state == AppLifecycleState.detached) {
    boxIndexes.put(boxKeyNames.bottomBarindex, bottomNavController.index);
  }
}

