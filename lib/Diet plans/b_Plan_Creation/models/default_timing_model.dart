import 'package:flutter/widgets.dart';

class DefaultTimingModel {
  String timingName;
  int hour;
  int min;

  bool isAM;
  String timingString;

  DefaultTimingModel({
    required this.timingName,
    required this.hour,
    required this.min,
    required this.isAM,
    required this.timingString,
  });

  Map<String, dynamic> toMap() {
    return {
      dtmos.timingName: timingName,
      dtmos.hour: hour,
      dtmos.min: min,
      dtmos.isAM: isAM,
      dtmos.timingString: timingString,
    };
  }

  factory DefaultTimingModel.fromMap(Map dataMap) {
    return DefaultTimingModel(
      timingName: dataMap[dtmos.timingName],
      hour: dataMap[dtmos.hour],
      min: dataMap[dtmos.min],
      isAM: dataMap[dtmos.isAM],
      timingString: dataMap[dtmos.timingString],
    );
  }
}

final DefaultTimingModelObjects dtmos = DefaultTimingModelObjects();

class DefaultTimingModelObjects {
  String timingName = "timingName";
  String hour = "hour";
  String min = "min";

  String isAM = "isAM";
  String timingString = "timingString";
  String timings = "timings";

  List<DefaultTimingModel> foodTimingsListSort(
      List<DefaultTimingModel> listDefaultTimingModel) {
    listDefaultTimingModel.sort((a, b) {
      String timeF(DefaultTimingModel dtm) {
        return timingStringF(dtm.hour, dtm.min, dtm.isAM);
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
}
