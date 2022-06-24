import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';
import 'package:flutter/material.dart';

Future<void> userActivityUpdate(AppLifecycleState state) async {

  Timestamp ts = Timestamp.fromDate(DateTime.now());

  if (state == AppLifecycleState.resumed) {
    await userDR.update({
      "$unIndexed.${uss.activeAt}": ts,
    });
  } else {
    await userDR.update({
      "$unIndexed.${uss.inactiveAt}": ts,
    });
  }
}

ActivityStates activityStates = ActivityStates();

class ActivityStates {
  String active = "active";
  String pauced = "pauced";
  String inactive = "inactive";
}
