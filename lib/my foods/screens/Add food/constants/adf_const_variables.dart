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
  String duplicateAnimation = "assets/10360-done.json";
  String sendAnimation = "assets/10360-done.json";
  String deleteAnimation = "assets/79053-delete-message.json";
  String heartAnimation = "assets/85819-kadokado-heart.json"; 

}
