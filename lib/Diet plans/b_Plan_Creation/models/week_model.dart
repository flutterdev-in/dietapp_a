import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';

class WeekModel {
  Timestamp weekCreationTime;

  String? notes;
  String? refURL;
  String? docRef;
  WeekModel({
    required this.weekCreationTime,
    required this.notes,
    required this.refURL,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    return {
      wmfos.weekCreationTime: weekCreationTime,
      wmfos.notes: notes,
      wmfos.refURL: refURL,
      wmfos.docRef: docRef,
    };
  }

  factory WeekModel.fromMap(Map dataMap) {
    return WeekModel(
      weekCreationTime: dataMap[wmfos.weekCreationTime],
      notes: dataMap[wmfos.notes],
      refURL: dataMap[wmfos.refURL],
      docRef: dataMap[wmfos.docRef],
    );
  }
}

final WeekModelFinalObjects wmfos = WeekModelFinalObjects();

class WeekModelFinalObjects {
  final String weekCreationTime = "weekCreationTime";
  final String notes = "notes";
  final String refURL = "refURL";
  String docRef = docRef0;
  //
  final String weeks = "weeks";
}
