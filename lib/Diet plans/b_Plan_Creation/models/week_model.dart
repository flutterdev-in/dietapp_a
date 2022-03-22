class WeekModel {
  int weekIndex;

  String? notes;
  String? refURL;

  WeekModel({
    required this.weekIndex,
    required this.notes,
    required this.refURL,
  });

  Map<String, dynamic> toMap() {
    return {
      wmfos.weekIndex: weekIndex,
      wmfos.notes: notes,
      wmfos.refURL: refURL,
    };
  }

  factory WeekModel.fromMap(Map dataMap) {
    return WeekModel(
      weekIndex: dataMap[wmfos.weekIndex],
      notes: dataMap[wmfos.notes],
      refURL: dataMap[wmfos.refURL],
    );
  }
}

final WeekModelFinalObjects wmfos = WeekModelFinalObjects();

class WeekModelFinalObjects {
  final String weekIndex = "weekIndex";

  final String notes = "notes";
  final String refURL = "refURL";

  //
  final String weeks = "weeks";
}
