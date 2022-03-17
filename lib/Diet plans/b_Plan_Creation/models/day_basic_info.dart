import 'package:cloud_firestore/cloud_firestore.dart';

class DayPlanBasicInfoModel {
  int dayIndex;
  String? notes;
  String? refURL;
  Timestamp docEntryTime;
  DayPlanBasicInfoModel({
    required this.dayIndex,
    required this.notes,
    required this.refURL,
    required this.docEntryTime,
  });

  Map<String, dynamic> toMap() {
    return {
      daypbims.dayIndex: dayIndex,
      daypbims.notes: notes,
      daypbims.refURL: refURL,
      daypbims.docEntryTime: docEntryTime,
    };
  }

  factory DayPlanBasicInfoModel.fromMap(Map dayPlanMap) {
    return DayPlanBasicInfoModel(
      dayIndex: dayPlanMap[daypbims.dayIndex],
      notes: dayPlanMap[daypbims.notes],
      refURL: dayPlanMap[daypbims.refURL],
      docEntryTime: dayPlanMap[daypbims.docEntryTime],
    );
  }
}

final DayPlanBasicInfoModelStrings daypbims = DayPlanBasicInfoModelStrings();

class DayPlanBasicInfoModelStrings {
  String dayIndex = "dayIndex";
  String docEntryTime = "docEntryTime";
  String notes = "notes";
  String refURL = "refURL";
  String days = "days";
}
