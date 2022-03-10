import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';

FoodsCollectionStrings fdcs = FoodsCollectionStrings();

class FoodsCollectionStrings {
  String docID = "docID";
  String fieldName = "fieldName";
  String fieldTime = "fieldTime";
  String isFolder = "isFolder";
  String notes = "notes";
  String imgURL = "imgURL";
  String appFoodID = "appFoodID";
  String webURL = "webURL";
  String youtubeURL = "youtubeURL";
  String isItemSelected = "isItemSelected";
  String fcPathSeperator = "/subCollections";
  String pathCRstring = "pathCRstring";
  String pathCR = "pathCR";
  String snapRef = "snapRef";
  String itemIndex = "itemIndex";
  String fcModel = "fcModel";
  String foodsCollection = "foodsCollection";
  String subCollections = "subCollections";

  CollectionReference foodsCR0 = FirebaseFirestore.instance
      .collection(uss.users)
      .doc(userUID)
      .collection("foodsCollection");

  //  "/Users/$userUID/foodsCollection";
}
