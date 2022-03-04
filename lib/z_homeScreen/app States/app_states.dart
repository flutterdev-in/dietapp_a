import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';
import 'package:flutter/material.dart';

Future<void> fireActivity(AppLifecycleState state) async {
  Map<String, dynamic> activityMap;
  Timestamp ts = Timestamp.fromDate(DateTime.now());
  
  if (state == AppLifecycleState.inactive) {
    activityMap = { "${uwms.userActivity}.${uwms.inactiveFrom}":ts,"${uwms.userActivity}.${uwms.activity}":activityStates.inactive
     
    };
    await userDR.update(activityMap);
  }
  if (state == AppLifecycleState.paused) {
    activityMap = {
      uwms.userActivity: {
        uwms.pausedFrom: ts,
        uwms.activity: activityStates.pauced
      }
    };
    await userDR.update(activityMap);
  }
  if (state == AppLifecycleState.resumed) {
    activityMap = {
      uwms.userActivity: {
        uwms.activeFrom: ts,
        uwms.activity: activityStates.active
      }
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
