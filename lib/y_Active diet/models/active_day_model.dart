import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:intl/intl.dart';

class ActiveDayModel {
  String dayDate;
  String dayName;
  bool isPlanned;

  bool? isTaken;
  String? plannedNotes;
  String? takenNotes;
  RefUrlMetadataModel? prud;
  RefUrlMetadataModel? trud;
  DocumentReference<Map<String, dynamic>>? docRef;
  DocumentReference<Map<String, dynamic>>? refPlanDR;

  //
  ActiveDayModel({
    required this.dayDate,
    required this.isPlanned,
    required this.dayName,
    this.isTaken,
    this.plannedNotes,
    this.takenNotes,
    this.prud,
    this.trud,
    this.docRef,
    this.refPlanDR,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> returnMap = {
      admos.dayDate: dayDate,
      unIndexed: {
        adfos.isPlanned: isPlanned,
      }
    };
    Map<String, dynamic> nullChaeckValues = {
      adfos.isTaken: isTaken,
      adfos.plannedNotes: plannedNotes,
      adfos.takenNotes: takenNotes,
      adfos.prud: prud,
      adfos.trud: trud,
      docRef0: docRef,
      admos.refPlanDR: refPlanDR,
    };

    nullChaeckValues.forEach((key, value) {
      if (value != null) {
        returnMap[unIndexed][key] = value;
      }
    });

    return returnMap;
  }

  factory ActiveDayModel.fromMap(Map docMap) {
    return ActiveDayModel(
      dayDate: docMap[admos.dayDate],
      dayName: docMap[admos.dayDate],
      isPlanned: docMap[unIndexed][adfos.isPlanned],
      isTaken: docMap[unIndexed][adfos.isTaken],
      plannedNotes: docMap[unIndexed][adfos.plannedNotes],
      takenNotes: docMap[unIndexed][adfos.takenNotes],
      prud: rummfos.rummFromRummMap(docMap[unIndexed][adfos.prud]),
      trud: rummfos.rummFromRummMap(docMap[unIndexed][adfos.trud]),
      docRef: docMap[unIndexed][docRef0],
      refPlanDR: docMap[unIndexed][admos.refPlanDR],
    );
  }
}

final ActiveDayModelObjects admos = ActiveDayModelObjects();

class ActiveDayModelObjects {
  final String dayDate = "dayDate";
  final String dayName = "dayName";
  final String refPlanDR = "refPlanDR";
  final String activeDaysPlan = "activeDaysPlan";

  String dayStringFromDate(DateTime date) {
    return DateFormat("yyyyMMdd").format(date);
  }
}
