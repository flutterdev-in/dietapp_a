class DefaultTimingModel {
  String timingName;
  int hour;
  int min;

  bool isAM;

  DefaultTimingModel({
    required this.timingName,
    required this.hour,
    required this.min,
    required this.isAM,
  });

  Map<String, dynamic> toMap() {
    return {
      dtmos.timingName: timingName,
      dtmos.hour: hour,
      dtmos.min: min,
      dtmos.isAM: isAM,
    };
  }

  factory DefaultTimingModel.fromMap(Map dataMap) {
    return DefaultTimingModel(
      timingName: dataMap[dtmos.timingName],
      hour: dataMap[dtmos.hour],
      min: dataMap[dtmos.min],
      isAM: dataMap[dtmos.isAM],
    );
  }
}

final DefaultTimingModelObjects dtmos = DefaultTimingModelObjects();

class DefaultTimingModelObjects {
  String timingName = "timingName";
  String hour = "hour";
  String min = "min";

  String isAM = "isAM";
  String timings = "timings";

  List<DefaultTimingModel> foodTimingsListSort(
      List<DefaultTimingModel> listDefaultTimingModel) {
    listDefaultTimingModel.sort((a, b) {
      String timeF(DefaultTimingModel dtm) {
        String ampm = dtm.isAM == true ? "a" : "b";
        String hours =
            dtm.hour > 9 ? dtm.hour.toString() : "0${dtm.hour.toString()}";
        String min = dtm.min == 0 ? "00" : dtm.min.toString();
        return ampm + hours + min;
      }

      return timeF(a).compareTo(timeF(b));
    });
    return listDefaultTimingModel;
  }
}
