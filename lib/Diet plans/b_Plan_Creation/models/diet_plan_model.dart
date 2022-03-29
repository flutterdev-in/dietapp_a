import 'package:cloud_firestore/cloud_firestore.dart';

class DietPlanBasicInfoModel {
  String planName;
  String? notes;
  Timestamp? planCreationTime;
  String? refURL;
  List defaultTimings;
  List defaultTimings0;

  DietPlanBasicInfoModel({
    required this.planName,
    required this.notes,
    required this.planCreationTime,
    required this.refURL,
    required this.defaultTimings,
    required this.defaultTimings0,
  });

  Map<String, dynamic> toMap() {
    return {
      dietpbims.planName: planName,
      dietpbims.notes: notes,
      dietpbims.planCreationTime: planCreationTime,
      dietpbims.refURL: refURL,
      dietpbims.defaultTimings: defaultTimings,
      dietpbims.defaultTimings0: defaultTimings0,
    };
  }

  factory DietPlanBasicInfoModel.fromMap(Map mainPlanBasicMap) {
    return DietPlanBasicInfoModel(
      planName: mainPlanBasicMap[dietpbims.planName],
      notes: mainPlanBasicMap[dietpbims.notes],
      planCreationTime: mainPlanBasicMap[dietpbims.planCreationTime],
      refURL: mainPlanBasicMap[dietpbims.refURL],
      defaultTimings: mainPlanBasicMap[dietpbims.defaultTimings],
      defaultTimings0: mainPlanBasicMap[dietpbims.defaultTimings0],
    );
  }
}

DietPlanBasicInfoModelStrings dietpbims = DietPlanBasicInfoModelStrings();

class DietPlanBasicInfoModelStrings {
  final String planName = "planName";
  final String planCreationTime = "planCreationTime";
  final String notes = "notes";
  final String refURL = "refURL";
  final String defaultTimings = "defaultTimings";
  final String defaultTimings0 = "defaultTimings0";
}
