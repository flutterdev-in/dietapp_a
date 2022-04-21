import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/diet%20view/models/proof_pic_model.dart';

class ActiveFoodModel {
  bool isPlanned;
  bool isTaken;
  Timestamp? takenTime;
  String? foodName;
  String? plannedNotes;
  String? takenNotes;
  RefUrlMetadataModel? prud; // plannedRefUrlMetadataModel
  RefUrlMetadataModel? trud; // takenRefUrlMetadataModel
  List<ProofPicsModel>? listProofPicModels;
  DocumentReference? docRef;

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
    return {
      fofafm.isPlanned: isPlanned,
      fofafm.isTaken: isTaken,
      fofafm.takenTime: takenTime,
      unIndexed: {
        fofafm.foodName: foodName,
        fofafm.plannedNotes: plannedNotes,
        fofafm.takenNotes: takenNotes,
        fofafm.prud: prud,
        fofafm.trud: trud,
        fofafm.listProofPicMaps:
            listProofPicModels?.map((e) => e.toMap()).toList(),
        docRef0: docRef
      }
    };
  }

  factory ActiveFoodModel.fromMap(Map<String, dynamic> docMap) {
    return ActiveFoodModel(
      isPlanned: docMap[fofafm.isPlanned],
      isTaken: docMap[fofafm.isTaken],
      takenTime: docMap[fofafm.takenTime],
      foodName: docMap[unIndexed][fofafm.foodName],
      plannedNotes: docMap[unIndexed][fofafm.plannedNotes],
      takenNotes: docMap[unIndexed][fofafm.foodName],
      prud: docMap[unIndexed][fofafm.prud],
      trud: docMap[unIndexed][fofafm.trud],
      docRef: docMap[unIndexed][docRef0],
      listProofPicModels: docMap[unIndexed][fofafm.listProofPicMaps]
          ?.map((e) => ProofPicsModel.fromMap(e))
          .toList(),
    );
  }
}

FinalObjectsForActiveFoodModel fofafm = FinalObjectsForActiveFoodModel();

class FinalObjectsForActiveFoodModel {
  final String isPlanned = "isPlanned";
  final String isTaken = "isTaken";
  final String takenTime = "takenTime";
  final String foodName = "foodName";
  final String plannedNotes = "plannedNotes";
  final String takenNotes = "takenNotes";
  final String prud = "prud";
  final String trud = "trud";
  final String listProofPicMaps = "listProofPicMaps";
}
