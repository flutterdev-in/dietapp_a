import 'package:dietapp_a/app%20Constants/constant_objects.dart';

class DayModel {
  int dayIndex;
  String? notes;
  String? refURL;
  String? docRef;

  DayModel({
    required this.dayIndex,
    required this.notes,
    required this.refURL,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    return {
      daymfos.dayIndex: dayIndex,
      daymfos.notes: notes,
      daymfos.refURL: refURL,
      daymfos.docRef: docRef,
    };
  }

  factory DayModel.fromMap(Map dayPlanMap) {
    return DayModel(
      dayIndex: dayPlanMap[daymfos.dayIndex],
      notes: dayPlanMap[daymfos.notes],
      refURL: dayPlanMap[daymfos.refURL],
      docRef: dayPlanMap[daymfos.docRef],
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
