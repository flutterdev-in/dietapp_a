import 'dart:collection';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

DaysController dc = DaysController();

class DaysController {
  final dt = DateTime.now().obs;
  var dt0 = DateTime.now();

  DateTime dateDiffer(DateTime date, bool increase,
      {int differ = 1, String ymd = "m"}) {
    int? year = date.year;
    int? month = date.month;
    int? day = date.day;

    if (ymd == "m") {
      return DateTime(year, increase ? month + differ : month - differ, day);
    } else if (ymd == "y") {
      return DateTime(increase ? year + differ : year - differ, month, day);
    } else {
      return DateTime(year, month, increase ? day + differ : day - differ);
    }
  }

  var k = LinkedHashMap();
}
