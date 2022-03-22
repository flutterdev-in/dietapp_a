import 'package:cloud_firestore/cloud_firestore.dart';

class DayPlanBasicInfoModel {
  int dayIndex;
  String? notes;
  String? refURL;

  DayPlanBasicInfoModel({
    required this.dayIndex,
    required this.notes,
    required this.refURL,

  });

  Map<String, dynamic> toMap() {
    return {
      daypbims.dayIndex: dayIndex,
      daypbims.notes: notes,
      daypbims.refURL: refURL,

    };
  }

  factory DayPlanBasicInfoModel.fromMap(Map dayPlanMap) {
    return DayPlanBasicInfoModel(
      dayIndex: dayPlanMap[daypbims.dayIndex],
      notes: dayPlanMap[daypbims.notes],
      refURL: dayPlanMap[daypbims.refURL],

    );
  }
}

final DayPlanBasicInfoModelStrings daypbims = DayPlanBasicInfoModelStrings();

class DayPlanBasicInfoModelStrings {
  String dayIndex = "dayIndex";

  String notes = "notes";
  String refURL = "refURL";
  String days = "days";
}
