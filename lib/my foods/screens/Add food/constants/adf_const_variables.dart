import 'package:cloud_firestore/cloud_firestore.dart';

AddFoodsConstVariables adfcv = AddFoodsConstVariables();

class AddFoodsConstVariables {
  final CollectionReference fireFoodData =
      FirebaseFirestore.instance.collection("FoodData");

  String img150 = "img150";

  String sourceWebsite = "sourceWebsite";
  String listSubNames = "listSubNames";
  String fDetails = "fDetails";
  String imgURL = "imgURL";
  String sourceURL = "sourceURL";
  String fID = "fID";

  String foodCollectionModel = "foodCollectionModel";
  String foodModelOfFireFood = "foodModelOfFireFood";
  String matchedname = "matchedname";

  //


}
