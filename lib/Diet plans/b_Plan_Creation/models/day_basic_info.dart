import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';

class DayModel {
  int dayIndex;

  String? notes;
  RefUrlMetadataModel? rumm;
  DocumentReference? docRef;

  DayModel({
    required this.dayIndex,
    required this.notes,
    required this.rumm,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    return {
      daymfos.dayIndex: dayIndex,
      unIndexed: {
        daymfos.notes: notes,
        rummfos.rumm: rumm?.toMap(),
        daymfos.docRef: docRef,
      }
    };
  }

  factory DayModel.fromMap(Map dayPlanMap) {
    return DayModel(
      dayIndex: dayPlanMap[daymfos.dayIndex],
      notes: dayPlanMap[unIndexed][daymfos.notes],
      rumm: rummfos.rummFromRummMap(dayPlanMap[unIndexed][rummfos.rumm]),
      docRef: dayPlanMap[unIndexed][daymfos.docRef],
    );
  }
}

final DayModelFinalObjects daymfos = DayModelFinalObjects();

class DayModelFinalObjects {
  String dayIndex = "dayIndex";

  String notes = "notes";
  String refURL = "refURL";
  String days = "days";
  String docRef = docRef0;

  List<String> ls = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  String dayString(int dayIndex) {
    return ls[dayIndex];
  }
}
