class FoodTimingModel {
  String name;
  int hours;
  int mins;
  int deviation;
  bool isAm;

  FoodTimingModel({
    required this.name,
    required this.hours,
    required this.mins,
    required this.deviation,
    required this.isAm,
  });
  Map<String, dynamic> toMap() {
    return {
      fts.name: name,
      fts.hours: hours,
      fts.mins: mins,
      fts.deviation: deviation,
      fts.isAm: isAm,
    };
  }

  factory FoodTimingModel.fromMap(Map foodTimingsMap) {
    return FoodTimingModel(
      name: foodTimingsMap[fts.name],
      hours: foodTimingsMap[fts.hours],
      mins: foodTimingsMap[fts.mins],
      deviation: foodTimingsMap[fts.deviation],
      isAm: foodTimingsMap[fts.isAm],
    );
  }
}

FoodTimingStrings fts = FoodTimingStrings();

class FoodTimingStrings {
  final String name = "name";
  final String hours = "hours";
  final String mins = "mins";
  final String deviation = "deviation";
  final String isAm = "isAm";
}
