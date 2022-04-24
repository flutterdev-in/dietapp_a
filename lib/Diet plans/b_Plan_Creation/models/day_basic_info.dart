import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/models/week_model.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';

class DayModel {
  Timestamp? dayCreatedTime;
  int? weekIndex;
  int? dayIndex;
  String? dayName;
  String? notes;
  RefUrlMetadataModel? rumm;
  DocumentReference<Map<String, dynamic>>? docRef;
//
  DayModel({
    required this.dayCreatedTime,
    required this.dayIndex,
    required this.weekIndex,
    this.dayName,
    this.notes,
    this.rumm,
    this.docRef,
  });
  Map<String, dynamic> toMap() {
    Map<String, dynamic> returnMap;
    if (weekIndex == null) {
      returnMap = {daymfos.dayCreatedTime: dayCreatedTime, unIndexed: {}};
    } else {
      returnMap = {
        wmfos.weekIndex: weekIndex,
        daymfos.dayIndex: dayIndex,
        unIndexed: {}
      };
    }
    //
    if (dayIndex != null) {
      returnMap[daymfos.dayIndex] = dayIndex;
    }
    //
    Map<String, dynamic> nullChaeckValues = {
      daymfos.dayName: dayName,
      daymfos.notes: notes,
      rummfos.rumm: rumm?.toMap(),
      daymfos.docRef: docRef,
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
      dayCreatedTime: dayPlanMap[daymfos.dayCreatedTime],
      dayIndex: dayPlanMap[daymfos.dayIndex],
      weekIndex: dayPlanMap[wmfos.weekIndex],
      dayName: dayPlanMap[unIndexed][daymfos.dayName],
      notes: dayPlanMap[unIndexed][daymfos.notes],
      rumm: rummfos.rummFromRummMap(dayPlanMap[unIndexed][rummfos.rumm]),
      docRef: dayPlanMap[unIndexed][daymfos.docRef],
    );
  }
}

final DayModelFinalObjects daymfos = DayModelFinalObjects();

class DayModelFinalObjects {
  String dayIndex = "dayIndex";
  String dayCreatedTime = "dayCreatedTime";
  String dayName = "dayName";
  String notes = "notes";
  String days = "days";
  String docRef = docRef0;

  List<int> listDaysIndex = [1, 2, 3, 4, 5, 6, 7];
  List<String> ls = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  String dayString(int dayIndex) {
    return ls[dayIndex - 1];
  }
}
