import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';

class WeekModel {
  int weekIndex;
  String? weekName;
  String? notes;
  RefUrlMetadataModel? rumm;

  WeekModel({
    required this.weekIndex,
    this.weekName,
    this.notes,
    this.rumm,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> returnMap = {
      wmfos.weekIndex: weekIndex,
    };
    Map<String, dynamic> nullChaeckValues = {
      wmfos.weekName: weekName,
      wmfos.notes: notes,
      rummfos.rumm: rumm?.toMap(),
    };

    nullChaeckValues.forEach((key, value) {
      if (value != null) {
        returnMap[key] = value;
      }
    });

    return returnMap;
  }

  factory WeekModel.fromMap(Map dataMap) {
    return WeekModel(
      weekIndex: dataMap[wmfos.weekIndex],
      notes: dataMap[wmfos.notes],
      rumm: rummfos.rummFromRummMap(dataMap[rummfos.rumm]),
    );
  }
}

final WeekModelFinalObjects wmfos = WeekModelFinalObjects();

class WeekModelFinalObjects {
  final String weekIndex = "weekIndex";
  final String weekName = "weekName";
  final String notes = "notes";
  final String refURL = "refURL";
  String docRef = docRef0;
  //
  final String weeks = "weeks";
}
