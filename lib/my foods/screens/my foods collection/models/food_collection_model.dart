import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';

class FoodsCollectionModel {
  String fieldName;
  Timestamp fieldTime;
  bool isFolder;
  String notes;
  String? imgURL;
  String? appFoodID;
  String? webURL;
  String? docRef;

  FoodsCollectionModel({
    required this.fieldName,
    required this.fieldTime,
    required this.isFolder,
    this.notes = "",
    this.appFoodID,
    this.webURL,
    this.imgURL,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    return isFolder
        ? {
            fdcs.fieldName: fieldName,
            fdcs.fieldTime: fieldTime,
            fdcs.isFolder: isFolder,
            fdcs.notes: notes,
            fdcs.docRef: docRef,
          }
        : {
            fdcs.fieldName: fieldName,
            fdcs.fieldTime: fieldTime,
            fdcs.isFolder: isFolder,
            fdcs.notes: notes,
            fdcs.webURL: webURL,
            fdcs.appFoodID: appFoodID,
            fdcs.imgURL: imgURL,
          };
  }

  factory FoodsCollectionModel.fromMap(Map foodCollectionFieldMap) {
    return FoodsCollectionModel(
      fieldName: foodCollectionFieldMap[fdcs.fieldName],
      fieldTime: foodCollectionFieldMap[fdcs.fieldTime],
      isFolder: foodCollectionFieldMap[fdcs.isFolder]??false,
      notes: foodCollectionFieldMap[fdcs.notes],
      appFoodID: foodCollectionFieldMap[fdcs.appFoodID],
      webURL: foodCollectionFieldMap[fdcs.webURL],
      imgURL: foodCollectionFieldMap[fdcs.imgURL],
      docRef: foodCollectionFieldMap[fdcs.docRef],
    );
  }
}
