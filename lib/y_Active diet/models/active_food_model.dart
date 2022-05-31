import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';

class ActiveFoodModel {
  String foodTypeCamPlanUp;  // Up = updated from homescreen
  bool isTaken;
  DateTime? foodAddedTime;
  DateTime? takenTime;
  String foodName;
  String? plannedNotes;
  String? takenNotes;
  RefUrlMetadataModel? prud; // plannedRefUrlMetadataModel
  RefUrlMetadataModel? trud; // takenRefUrlMetadataModel

  DocumentReference<Map<String, dynamic>>? docRef;

  ActiveFoodModel({
    required this.foodTypeCamPlanUp,
    required this.isTaken,
    required this.foodAddedTime,
    required this.takenTime,
    required this.foodName,
    required this.plannedNotes,
    required this.takenNotes,
    required this.prud,
    required this.trud,
    required this.docRef,
  });
  Map<String, dynamic> toMap() {
    Map<String, dynamic> returnMap = {
      afmos.foodTypeCamPlanUp: foodTypeCamPlanUp,
      adfos.isTaken: isTaken,
      afmos.foodAddedTime: foodAddedTime?.millisecondsSinceEpoch,
      afmos.foodName: foodName,
      unIndexed: {}
    };
    if (takenTime != null) {
      returnMap[afmos.takenTime] = Timestamp.fromDate(takenTime!);
    }
    Map<String, dynamic> nullChaeckValues = {
      adfos.plannedNotes: plannedNotes,
      adfos.takenNotes: takenNotes,
      adfos.prud: prud?.toMap(),
      adfos.trud: trud?.toMap(),
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
      foodTypeCamPlanUp: docMap[afmos.foodTypeCamPlanUp],
      isTaken: docMap[adfos.isTaken],
      foodAddedTime:
          DateTime.fromMillisecondsSinceEpoch(docMap[afmos.foodAddedTime]),
      takenTime: docMap[afmos.takenTime]?.toDate(),
      foodName: docMap[afmos.foodName] ?? "",
      plannedNotes: docMap[unIndexed][adfos.plannedNotes],
      takenNotes: docMap[unIndexed][afmos.foodName],
      prud: rummfos.rummFromRummMap(docMap[unIndexed][adfos.prud]),
      trud: rummfos.rummFromRummMap(docMap[unIndexed][adfos.trud]),
      docRef: docMap[unIndexed][docRef0],
    );
  }
}

ActiveFoodModelObjects afmos = ActiveFoodModelObjects();

class ActiveFoodModelObjects {
  final String takenTime = "takenTime";
  final String foodName = "foodName";
  final String foods = "foods";
  final String foodAddedTime = "foodAddedTime";
  final String listProofPicMaps = "listProofPicMaps";
  final String foodTypeCamPlanUp = "foodTypeCamPlanUp";
  final String cam = "Cam";
  final String plan = "Plan";
  final String up = "Up";
}
