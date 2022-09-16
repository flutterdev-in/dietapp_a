import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';

class WeekModel {
  Timestamp weekCreatedTime;
  String? weekName;

  DocumentReference<Map<String, dynamic>>? docRef;

  WeekModel({
    required this.weekCreatedTime,
    this.weekName,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> returnMap = {
      wmfos.weekCreatedTime: weekCreatedTime,
      wmfos.weekName: weekName,
      unIndexed: {}
    };
    Map<String, dynamic> nullChaeckValues = {
      docRef0: docRef,
    };

    nullChaeckValues.forEach((key, value) {
      if (value != null) {
        returnMap[unIndexed][key] = value;
      }
    });

    return returnMap;
  }

  factory WeekModel.fromMap(Map dataMap) {
    return WeekModel(
      weekCreatedTime: dataMap[wmfos.weekCreatedTime],
      weekName: dataMap[wmfos.weekName],
      docRef: dataMap[unIndexed][docRef0],
    );
  }
}

final WeekModelFinalObjects wmfos = WeekModelFinalObjects();

class WeekModelFinalObjects {
  final String weekCreatedTime = "weekCreatedTime";
  final String weekName = "weekName";

  String docRef = docRef0;
  //
  final String weeks = "weeks";
}
