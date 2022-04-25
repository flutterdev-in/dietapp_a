import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/proof_pic_model.dart';

class ActiveFoodModel {
  bool isPlanned;
  bool isTaken;
  DateTime? takenTime;
  String? foodName;
  String? plannedNotes;
  String? takenNotes;
  RefUrlMetadataModel? prud; // plannedRefUrlMetadataModel
  RefUrlMetadataModel? trud; // takenRefUrlMetadataModel
  List<ProofPicsModel>? listProofPicModels;
  DocumentReference<Map<String, dynamic>>? docRef;

  ActiveFoodModel({
    required this.isPlanned,
    required this.isTaken,
    required this.takenTime,
    required this.foodName,
    required this.plannedNotes,
    required this.takenNotes,
    required this.prud,
    required this.trud,
    required this.listProofPicModels,
    required this.docRef,
  });
  Map<String, dynamic> toMap() {
    Map<String, dynamic> returnMap = {
      adfos.isPlanned: isPlanned,
      adfos.isTaken: isTaken,
      unIndexed: {}
    };
    if (takenTime != null) {
      returnMap[afmos.takenTime] = Timestamp.fromDate(takenTime!);
    }
    Map<String, dynamic> nullChaeckValues = {
      afmos.foodName: foodName,
      adfos.plannedNotes: plannedNotes,
      adfos.takenNotes: takenNotes,
      adfos.prud: prud?.toMap(),
      adfos.trud: trud?.toMap(),
      afmos.listProofPicMaps:
          listProofPicModels?.map((e) => e.toMap()).toList(),
      docRef0: docRef
    };

    nullChaeckValues.forEach((key, value) {
      if (value != null) {
        returnMap[unIndexed][key] = value;
      }
    });

    return returnMap;
  }

  factory ActiveFoodModel.fromMap(Map<String, dynamic> docMap) {
    return ActiveFoodModel(
      isPlanned: docMap[adfos.isPlanned],
      isTaken: docMap[adfos.isTaken],
      takenTime: docMap[afmos.takenTime]?.toDate(),
      foodName: docMap[unIndexed][afmos.foodName],
      plannedNotes: docMap[unIndexed][adfos.plannedNotes],
      takenNotes: docMap[unIndexed][afmos.foodName],
      prud: rummfos.rummFromRummMap(docMap[unIndexed][adfos.prud]),
      trud: rummfos.rummFromRummMap(docMap[unIndexed][adfos.trud]),
      docRef: docMap[unIndexed][docRef0],
      listProofPicModels: docMap[unIndexed][afmos.listProofPicMaps]
          ?.map((e) => ProofPicsModel.fromMap(e))
          .toList(),
    );
  }
}

ActiveFoodModelObjects afmos = ActiveFoodModelObjects();

class ActiveFoodModelObjects {
  final String takenTime = "takenTime";
  final String foodName = "foodName";
  final String foods = "foods";
  final String listProofPicMaps = "listProofPicMaps";
}
