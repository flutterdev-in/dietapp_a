import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';

class FoodsModelForPlanCreation {
  Timestamp foodAddedTime;
  String foodName;
  String? notes;
  DocumentReference<Map<String, dynamic>>? docRef;
  RefUrlMetadataModel? rumm;
  FoodsModelForPlanCreation({
    required this.foodAddedTime,
    required this.foodName,
    required this.notes,
    required this.rumm,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> returnMap = {
      fmfpcfos.foodAddedTime: foodAddedTime,
      fmfpcfos.foodName: foodName,
      unIndexed: {}
    };
    Map<String, dynamic> nullChaeckValues = {
      rummfos.rumm: rumm?.toMap(),
      fmfpcfos.notes: notes,
      fmfpcfos.docRef: docRef,
    };

    nullChaeckValues.forEach((key, value) {
      if (value != null) {
        returnMap[unIndexed][key] = value;
      }
    });

    return returnMap;
  }

  factory FoodsModelForPlanCreation.fromMap(Map dataMap) {
    return FoodsModelForPlanCreation(
      foodAddedTime: dataMap[fmfpcfos.foodAddedTime],
      foodName: dataMap[fmfpcfos.foodName] ?? "",
      notes: dataMap[unIndexed][fmfpcfos.notes],
      rumm: rummfos.rummFromRummMap(dataMap[unIndexed][rummfos.rumm]),
      docRef: dataMap[unIndexed][fmfpcfos.docRef],
    );
  }
}

final FoodsModelForPlanCreationFinalObjects fmfpcfos =
    FoodsModelForPlanCreationFinalObjects();

class FoodsModelForPlanCreationFinalObjects {
  final String foodAddedTime = "foodAddedTime";
  final String foodName = "foodName";
  final String imgURL = "imgURL";
  final String notes = "notes";
  final String refURL = "refURL";
  String docRef = docRef0;
  //
  final String foods = "foods";
}
