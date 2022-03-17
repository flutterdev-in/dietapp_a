
class TimingInfoModel {
  bool? hasChoices;
  int timingIndex;
  String timingName;
  String notes;
  String refURL;

  TimingInfoModel({
    required this.hasChoices,
    required this.timingIndex,
    required this.timingName,
    required this.notes,
    required this.refURL,
  });

  Map<String, dynamic> toMap() {
    return {
      tims.hasChoices: hasChoices,
      tims.timingIndex: timingIndex,
      tims.timingName: timingName,
      tims.notes: notes,
      tims.refURL: refURL,
    };
  }

  factory TimingInfoModel.fromMap(Map dataMap) {
    return TimingInfoModel(
      hasChoices: dataMap[tims.hasChoices],
      timingIndex: dataMap[tims.timingIndex],
      timingName: dataMap[tims.timingName],
      notes: dataMap[tims.notes],
      refURL: dataMap[tims.refURL],
    );
  }
}

TimingInfoModelStrings tims = TimingInfoModelStrings();

class TimingInfoModelStrings {
  final String hasChoices = "hasChoices";
  final String timingIndex = "timingIndex";
  final String timingName = "timingName";
  final String notes = "notes";
  final String refURL = "refURL";
}
