import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/constants/adf_const_variables.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';

class FoodModelOfFireFood {
  String img150;

  String sourceWebsite;
  List listSubNames;
  String sourceURL;
  String fID;

  FoodModelOfFireFood({
    required this.img150,
    required this.sourceWebsite,
    required this.listSubNames,
    required this.sourceURL,
    required this.fID,
  });

  factory FoodModelOfFireFood.fromMap(Map foodDataMap) {
    return FoodModelOfFireFood(
      img150: foodDataMap[adfcv.imgURL][adfcv.img150],
      sourceWebsite: foodDataMap[adfcv.fDetails][adfcv.sourceWebsite],
      sourceURL: foodDataMap[adfcv.fDetails][adfcv.sourceURL],
      listSubNames: foodDataMap[adfcv.listSubNames],
      fID: foodDataMap[adfcv.fID],
    );
  }
}
