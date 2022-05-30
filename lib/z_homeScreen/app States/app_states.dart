import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:flutter/material.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';

Future<void> fireActivity(AppLifecycleState state) async {
  Map<String, dynamic> activityMap;
  Timestamp ts = Timestamp.fromDate(DateTime.now());

  if (state == AppLifecycleState.resumed) {
    activityMap = {
      "${uss.userActivity}.${uss.isActive}": true,
      "${uss.userActivity}.${uss.activeAt}": ts,
    };
    await userDR.update(activityMap);
  }else{
    activityMap = {
      "${uss.userActivity}.${uss.isActive}": false,
      "${uss.userActivity}.${uss.inactiveAt}": ts,
    };
    await userDR.update(activityMap);
  }
}

ActivityStates activityStates = ActivityStates();

class ActivityStates {
  String active = "active";
  String pauced = "pauced";
  String inactive = "inactive";
}
