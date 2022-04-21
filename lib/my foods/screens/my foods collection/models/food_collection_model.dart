import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';

class FoodsCollectionModel {
  String fieldName;
  Timestamp fieldTime;
  bool isFolder;
  String? notes;
  RefUrlMetadataModel? rumm;
  DocumentReference? docRef;
  FoodsCollectionModel({
    required this.fieldName,
    required this.fieldTime,
    required this.isFolder,
    required this.notes,
    required this.rumm,
    this.docRef,
  });

  Map<String, dynamic> toMap() {
    return isFolder
        ? {
            fdcs.fieldName: fieldName,
            fdcs.fieldTime: fieldTime,
            fdcs.isFolder: isFolder,
            unIndexed: {
              fdcs.notes: notes,
              fdcs.docRef: docRef,
            }
          }
        : {
            fdcs.fieldName: fieldName,
            fdcs.fieldTime: fieldTime,
            fdcs.isFolder: isFolder,
            unIndexed: {
              fdcs.notes: notes,
              rummfos.rumm: rumm?.toMap(),
            }
          };
  }

  factory FoodsCollectionModel.fromMap(Map dataMap) {
    return FoodsCollectionModel(
      fieldName: dataMap[fdcs.fieldName],
      fieldTime: dataMap[fdcs.fieldTime],
      isFolder: dataMap[fdcs.isFolder] ?? false,
      notes: dataMap[unIndexed][fdcs.notes],
      rumm: rummfos
          .rummFromRummMap(dataMap[unIndexed][rummfos.rumm]),
      docRef: dataMap[unIndexed][fdcs.docRef],
    );
  }
}
