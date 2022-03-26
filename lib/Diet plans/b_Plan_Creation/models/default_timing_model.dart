
class DefaultTimingModel {
  String timingName;
  String timingString;
  String? notes;
  Map<String, dynamic>? refUrlMetadata;

  DefaultTimingModel({
    required this.timingName,
    required this.timingString,
    this.notes,
    this.refUrlMetadata,
  });

  Map<String, dynamic> toMap() {
    return {
      dtmos.timingName: timingName,
      dtmos.timingString: timingString,
       dtmos.notes: notes,
      dtmos.refUrlMetadata: refUrlMetadata,
    };
  }

  factory DefaultTimingModel.fromMap(Map dataMap) {
    return DefaultTimingModel(
      timingName: dataMap[dtmos.timingName],
      timingString: dataMap[dtmos.timingString],
      notes: dataMap[dtmos.notes],
      refUrlMetadata: dataMap[dtmos.refUrlMetadata],
    );
  }
}

final DefaultTimingModelObjects dtmos = DefaultTimingModelObjects();

class DefaultTimingModelObjects {
  String timingName = "timingName";

  String timingString = "timingString";
  String timings = "timings";
  final String notes = "notes";
  final String refUrlMetadata = "refUrlMetadata";

  List<DefaultTimingModel> foodTimingsListSort(
      List<DefaultTimingModel> listDefaultTimingModel) {
    listDefaultTimingModel.sort((a, b) {
      String timeF(DefaultTimingModel dtm) {
        return dtm.timingString;
      }

      return timeF(a).compareTo(timeF(b));
    });
    return listDefaultTimingModel;
  }

  String timingStringF(int hour, int min, bool isAM) {
    String ampm = isAM == true ? "am" : "pm";
    String hours = hour > 9 ? hour.toString() : "0${hour.toString()}";
    String mins = min == 0 ? "00" : min.toString();
    return ampm + hours + mins;
  }

  String displayTiming(String timingString) {
    return timingString.substring(2, 4).replaceAll(RegExp(r"^0"), "") +
        "." +
        timingString.substring(4) +
        timingString.substring(0, 2);
  }
}
