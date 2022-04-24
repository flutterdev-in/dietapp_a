import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';

class WeekModel {
  Timestamp weekCreatedTime;
  String? weekName;
  String? notes;
  RefUrlMetadataModel? rumm;
  DocumentReference<Map<String, dynamic>>? docRef;

  WeekModel({
    required this.weekCreatedTime,
    this.weekName,
    this.notes,
    this.rumm,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> returnMap = {
      wmfos.weekCreatedTime: weekCreatedTime,
      wmfos.weekName: weekName,
      unIndexed: {}
    };
    Map<String, dynamic> nullChaeckValues = {
      wmfos.notes: notes,
      rummfos.rumm: rumm?.toMap(),
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
      notes: dataMap[unIndexed][wmfos.notes],
      docRef: dataMap[unIndexed][docRef0],
      rumm: rummfos.rummFromRummMap(dataMap[unIndexed][rummfos.rumm]),
    );
  }
}

final WeekModelFinalObjects wmfos = WeekModelFinalObjects();

class WeekModelFinalObjects {
  final String weekCreatedTime = "weekCreatedTime";
  final String weekName = "weekName";
  final String notes = "notes";
  final String refURL = "refURL";
  String docRef = docRef0;
  //
  final String weeks = "weeks";
}
