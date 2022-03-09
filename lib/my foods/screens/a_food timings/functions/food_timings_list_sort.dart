import 'package:dietapp_a/my%20foods/screens/a_food%20timings/models/food_timing_model.dart';

List foodTimingsListSort(
    List listmap) {
  listmap.sort((a, b) {
    String timeF(Map x) {
      FoodTimingModel ftm = FoodTimingModel.fromMap(x);
      String ampm = ftm.isAm == true ? "a" : "b";
      String hours =
          ftm.hours > 9 ? ftm.hours.toString() : "0${ftm.hours.toString()}";
      String min = ftm.mins == 0 ? "00" : ftm.mins.toString();
      return ampm + hours + min;
    }

    return timeF(a).compareTo(timeF(b));
  });
  return listmap;
}
