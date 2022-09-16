import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';

DayWeekFunctions dayWeekFunctions = DayWeekFunctions();

class DayWeekFunctions {
  StartEndDates weekStartEndDates(DateTime selectedDate) {
    int toMonday = selectedDate.weekday - 1;
    int toSunday = 7 - selectedDate.weekday;
    return StartEndDates(selectedDate.subtract(Duration(days: toMonday)),
        selectedDate.add(Duration(days: toSunday)));
  }

  String weekString(DateTime middleDate) {
    var wSE = weekStartEndDates(middleDate);
    var s = admos.activeDayStringFromDate(wSE.startDate);
    var e = admos.activeDayStringFromDate(wSE.endDate);
    return s + "_" + e;
  }
}

class StartEndDates {
  DateTime startDate;
  DateTime endDate;
  StartEndDates(this.startDate, this.endDate);
}
