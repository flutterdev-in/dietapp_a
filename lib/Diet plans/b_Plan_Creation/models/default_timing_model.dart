import 'package:flutter/widgets.dart';

class DefaultTimingModel {
  String timingName;

  String timingString;

  DefaultTimingModel({
    required this.timingName,
    required this.timingString,
  });

  Map<String, dynamic> toMap() {
    return {
      dtmos.timingName: timingName,
      dtmos.timingString: timingString,
    };
  }

  factory DefaultTimingModel.fromMap(Map dataMap) {
    return DefaultTimingModel(
      timingName: dataMap[dtmos.timingName],
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
