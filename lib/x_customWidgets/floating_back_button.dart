import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

FloatingActionButton floatingBackButton() {
  return FloatingActionButton.small(
      backgroundColor: secondaryColor,
      child: const Icon(MdiIcons.arrowLeft),
      onPressed: () {
        Get.back();
      });
}
