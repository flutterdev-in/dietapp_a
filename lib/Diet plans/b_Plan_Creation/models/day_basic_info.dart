

class DayModel {
  int dayIndex;
  String? notes;
  String? refURL;

  DayModel({
    required this.dayIndex,
    required this.notes,
    required this.refURL,

  });

  Map<String, dynamic> toMap() {
    return {
      daymfos.dayIndex: dayIndex,
      daymfos.notes: notes,
      daymfos.refURL: refURL,

    };
  }

  factory DayModel.fromMap(Map dayPlanMap) {
    return DayModel(
      dayIndex: dayPlanMap[daymfos.dayIndex],
      notes: dayPlanMap[daymfos.notes],
      refURL: dayPlanMap[daymfos.refURL],

    );
  }
}

final DayModelFinalObjects daymfos = DayModelFinalObjects();

class DayModelFinalObjects {
  String dayIndex = "dayIndex";

  String notes = "notes";
  String refURL = "refURL";
  String days = "days";

  List<String> ls = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  String dayString (int dayIndex){
    return ls[dayIndex];
  }
}
