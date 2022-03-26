import 'package:cloud_firestore/cloud_firestore.dart';

class WeekModel {
  Timestamp weekCreationTime;

  String? notes;
  String? refURL;

  WeekModel({
    required this.weekCreationTime,
    required this.notes,
    required this.refURL,
  });

  Map<String, dynamic> toMap() {
    return {
      wmfos.weekCreationTime: weekCreationTime,
      wmfos.notes: notes,
      wmfos.refURL: refURL,
    };
  }

  factory WeekModel.fromMap(Map dataMap) {
    return WeekModel(
      weekCreationTime: dataMap[wmfos.weekCreationTime],
      notes: dataMap[wmfos.notes],
      refURL: dataMap[wmfos.refURL],
    );
  }
}

final WeekModelFinalObjects wmfos = WeekModelFinalObjects();

class WeekModelFinalObjects {
  final String weekCreationTime = "weekCreationTime";

  final String notes = "notes";
  final String refURL = "refURL";

  //
  final String weeks = "weeks";
}
