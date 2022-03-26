import 'package:cloud_firestore/cloud_firestore.dart';

class FoodsModelForPlanCreation {
  Timestamp foodAddedTime;
  String foodName;
  String? imgURL;
  String? notes;
  String? refURL;

  FoodsModelForPlanCreation({

    required this.foodAddedTime,
    required this.foodName,
    required this.notes,
    required this.imgURL,
    required this.refURL,
  });

  Map<String, dynamic> toMap() {
    return {

      fmfpcfos.foodAddedTime: foodAddedTime,
      fmfpcfos.foodName: foodName,
      fmfpcfos.imgURL: imgURL,
      fmfpcfos.notes: notes,
      fmfpcfos.refURL: refURL,
    };
  }

  factory FoodsModelForPlanCreation.fromMap(Map dataMap) {
    return FoodsModelForPlanCreation(

      foodAddedTime: dataMap[fmfpcfos.foodAddedTime],
      foodName: dataMap[fmfpcfos.foodName] ?? "",
      imgURL: dataMap[fmfpcfos.imgURL],
      notes: dataMap[fmfpcfos.notes],
      refURL: dataMap[fmfpcfos.refURL],
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

  //
  final String foods = "foods";
}
