import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';

class FoodsModelForPlanCreation {
  Timestamp foodAddedTime;
  String foodName;
  String? imgURL;
  String? notes;
  String? refURL;
String? docRef;
  FoodsModelForPlanCreation({

    required this.foodAddedTime,
    required this.foodName,
    required this.notes,
    required this.imgURL,
    required this.refURL,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    return {

      fmfpcfos.foodAddedTime: foodAddedTime,
      fmfpcfos.foodName: foodName,
      fmfpcfos.imgURL: imgURL,
      fmfpcfos.notes: notes,
      fmfpcfos.refURL: refURL,
     fmfpcfos. docRef: docRef,
    };
  }

  factory FoodsModelForPlanCreation.fromMap(Map dataMap) {
    return FoodsModelForPlanCreation(

      foodAddedTime: dataMap[fmfpcfos.foodAddedTime],
      foodName: dataMap[fmfpcfos.foodName] ?? "",
      imgURL: dataMap[fmfpcfos.imgURL],
      notes: dataMap[fmfpcfos.notes],
      refURL: dataMap[fmfpcfos.refURL],
      docRef: dataMap[fmfpcfos.docRef],
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
