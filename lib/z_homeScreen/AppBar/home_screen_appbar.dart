import 'package:dietapp_a/dartUtilities/day_string_from_date.dart';
import 'package:dietapp_a/y_Active%20diet/controllers/active_plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar homeScreenAppBar() {
  return AppBar(
    title: Obx(() => Text(
          dayStringFromDate(apc.dt.value),
          textScaleFactor: 0.9,
        )),
    
  );
}
