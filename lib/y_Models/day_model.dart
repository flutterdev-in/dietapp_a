import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';

class DayModel {
  DateTime? dayDate;
  DateTime? dayCreatedTime;
  int? dayIndex;
  String? dayName;
  String? notes;
  RefUrlMetadataModel? rumm;
  DocumentReference<Map<String, dynamic>>? docRef;
//
  DayModel({
    required this.dayDate,
    required this.dayCreatedTime,
    required this.dayIndex,
    this.dayName,
    this.notes,
    this.rumm,
    this.docRef,
  });
  Map<String, dynamic> toMap() {
    Map<String, dynamic> returnMap;
    if (dayIndex != null) {
      returnMap = {
        dmos.dayIndex: dayIndex,
        dmos.dayName: dayName,
        unIndexed: {},
      };
    } else if (dayDate != null) {
      returnMap = {
        dmos.dayDate: dayDate,
        unIndexed: {},
      };
    } else {
      returnMap = {
        dmos.dayCreatedTime: dayCreatedTime,
        dmos.dayName: dayName,
        unIndexed: {},
      };
    }

    //
    Map<String, dynamic> nullChaeckValues = {
      notes0: notes,
      rummfos.rumm: rumm?.toMap(),
      docRef0: docRef,
    };
    //
    nullChaeckValues.forEach((key, value) {
      if (value != null) {
        returnMap[unIndexed][key] = value;
      }
    });
    //
    return returnMap;
  }

  factory DayModel.fromMap(Map dayPlanMap) {
    return DayModel(
      dayDate: dayPlanMap[dmos.dayDate]?.toDate(),
      dayCreatedTime: dayPlanMap[dmos.dayCreatedTime]?.toDate(),
      dayIndex: dayPlanMap[dmos.dayIndex],
      dayName: dayPlanMap[dmos.dayName],
      notes: dayPlanMap[unIndexed][notes0],
      rumm: rummfos.rummFromRummMap(dayPlanMap[unIndexed][rummfos.rumm]),
      docRef: dayPlanMap[unIndexed][docRef0],
    );
  }
}

final DayModelObjects dmos = DayModelObjects();

class DayModelObjects {
  final String dayDate = "dayDate";
  final String dayIndex = "dayIndex";
  final String dayCreatedTime = "dayCreatedTime";
  final String dayName = "dayName";

  final String days = "days";

  final List<int> listDaysIndex = [1, 2, 3, 4, 5, 6, 7];
  final List<String> ls = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  String dayString(int dayIndex) {
    return ls[dayIndex - 1];
  }
}
