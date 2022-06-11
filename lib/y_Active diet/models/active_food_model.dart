import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';

class ActiveFoodModel {
  bool isCamFood;

  String foodName;
  DateTime? foodAddedTime;
  DateTime? takenTime;
  String? notes;

  RefUrlMetadataModel? rumm; // plannedRefUrlMetadataModel

  DocumentReference<Map<String, dynamic>>? docRef;

  ActiveFoodModel({
    required this.isCamFood,
    required this.foodAddedTime,
    required this.takenTime,
    required this.foodName,
    required this.notes,
    required this.rumm,
    required this.docRef,
  });
  Map<String, dynamic> toMap() {
    Map<String, dynamic> returnMap = {
      afmos.isCamFood: isCamFood,
      afmos.foodAddedTime: foodAddedTime?.millisecondsSinceEpoch,
      afmos.foodName: foodName,
      unIndexed: {}
    };
    if (takenTime != null) {
      returnMap[afmos.takenTime] = Timestamp.fromDate(takenTime!);
    }
    Map<String, dynamic> nullChaeckValues = {
      notes0: notes,
      rummfos.rumm: rumm?.toMap(),
      docRef0: docRef
    };

    nullChaeckValues.forEach((key, value) {
      if (value != null) {
        returnMap[unIndexed][key] = value;
      }
    });

    return returnMap;
  }

  factory ActiveFoodModel.fromMap(Map<String, dynamic> docMap) {
    return ActiveFoodModel(
      isCamFood: docMap[afmos.isCamFood] ?? false,
      foodAddedTime: docMap[afmos.foodAddedTime] != null
          ? DateTime.fromMillisecondsSinceEpoch(docMap[afmos.foodAddedTime])
          : null,
      takenTime: docMap[afmos.takenTime]?.toDate(),
      foodName: docMap[afmos.foodName] ?? "",
      notes: docMap[unIndexed][notes0],
      rumm: rummfos.rummFromRummMap(docMap[unIndexed][rummfos.rumm]),
      docRef: docMap[unIndexed][docRef0],
    );
  }
}

ActiveFoodModelObjects afmos = ActiveFoodModelObjects();

class ActiveFoodModelObjects {
  final String isCamFood = "isCamFood";
  final String takenTime = "takenTime";
  final String foodName = "foodName";
  final String foods = "foods";
  final String foodAddedTime = "foodAddedTime";
  final String listProofPicMaps = "listProofPicMaps";
}
