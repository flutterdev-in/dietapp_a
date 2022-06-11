import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';

class FoodModel {
  DateTime foodAddedTime;
  DateTime? foodTakenTime;
  String foodName;
  bool? isCamFood;
  bool? isFolder;
  String? notes;
  RefUrlMetadataModel? rumm;
  DocumentReference<Map<String, dynamic>>? docRef;

  FoodModel({
    required this.foodAddedTime,
    required this.foodTakenTime,
    required this.foodName,
    required this.isCamFood,
    required this.isFolder,
    required this.notes,
    required this.rumm,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> returnMap = {
      fmos.foodAddedTime:
          Timestamp.fromDate(foodAddedTime).millisecondsSinceEpoch,
      fmos.foodName: foodName,
      unIndexed: {}
    };
    Map<String, dynamic> nullChaeckValuesInd = {
      fmos.isFolder: isFolder,
      fmos.isCamFood: isCamFood,
      fmos.foodTakenTime:
          foodTakenTime != null ? Timestamp.fromDate(foodTakenTime!) : null,
    };

    nullChaeckValuesInd.forEach((key, value) {
      if (value != null) {
        returnMap[key] = value;
      }
    });
    Map<String, dynamic> nullChaeckValues = {
      rummfos.rumm: rumm?.toMap(),
      notes0: notes,
      docRef0: docRef,
    };

    nullChaeckValues.forEach((key, value) {
      if (value != null) {
        returnMap[unIndexed][key] = value;
      }
    });

    return returnMap;
  }

  factory FoodModel.fromMap(Map dataMap) {
    return FoodModel(
      foodAddedTime:
          DateTime.fromMillisecondsSinceEpoch(dataMap[fmos.foodAddedTime]),
      foodTakenTime: dataMap[fmos.foodTakenTime]?.toDate(),
      isFolder: dataMap[fmos.isFolder],
      isCamFood: dataMap[fmos.isCamFood],
      foodName: dataMap[fmos.foodName] ?? "",
      notes: dataMap[unIndexed][notes0],
      rumm: rummfos.rummFromRummMap(dataMap[unIndexed][rummfos.rumm]),
      docRef: dataMap[unIndexed][docRef0],
    );
  }
}

final FoodsModelObjects fmos = FoodsModelObjects();

class FoodsModelObjects {
  final String foodAddedTime = "foodAddedTime";
  final String foodTakenTime = "foodTakenTime";
  final String foodName = "foodName";
  final String isCamFood = "isCamFood";
  final String isFolder = "isFolder";
  //
  final String foods = "foods";
}
