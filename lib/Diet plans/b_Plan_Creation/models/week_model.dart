import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';

class WeekModel {
  Timestamp weekCreationTime;
  String? weekName;

  String? notes;
  RefUrlMetadataModel? rumm;
  DocumentReference? docRef;

  WeekModel({
    required this.weekCreationTime,
    required this.notes,
    this.rumm,
    this.weekName,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    return {
      wmfos.weekCreationTime: weekCreationTime,
      wmfos.weekName: weekName,
      unIndexed: {
        wmfos.notes: notes,
        rummfos.rumm: rumm?.toMap(),
        wmfos.docRef: docRef,
      }
    };
  }

  factory WeekModel.fromMap(Map dataMap) {
    return WeekModel(
      weekCreationTime: dataMap[wmfos.weekCreationTime],
      notes: dataMap[unIndexed][wmfos.notes],
      rumm: rummfos.rummFromRummMap(dataMap[unIndexed][rummfos.rumm]),
      docRef: dataMap[unIndexed][wmfos.docRef],
    );
  }
}

final WeekModelFinalObjects wmfos = WeekModelFinalObjects();

class WeekModelFinalObjects {
  final String weekCreationTime = "weekCreationTime";
  final String weekName = "weekName";
  final String notes = "notes";
  final String refURL = "refURL";
  String docRef = docRef0;
  //
  final String weeks = "weeks";
}
